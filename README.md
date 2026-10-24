# Life Vault

A Claude Code plugin that runs your personal and work life from an Obsidian vault.

- **It gets to know you.** Setup starts with a conversation about who you are, what you do, and what's slipping through the cracks. Claude turns that into your first projects.
- **It keeps learning.** Tell Claude anything about yourself, or correct how it works, and it saves it to two notes you can read and edit: `About Me.md` and `How Claude Works With Me.md`. Every new session starts by reading them.
- **It plans your day.** Say "good morning" and Claude checks your email, calendar and tasks, then writes a briefing.

## What you need

- A Mac with [Claude Code](https://code.claude.com/docs/en/quickstart) installed and signed in with your claude.ai account
- [Obsidian](https://obsidian.md/download) (free)
- Optional: Gmail, Google Calendar or Microsoft 365 connected at [claude.ai/customize/connectors](https://claude.ai/customize/connectors) for the email and calendar parts

## Install

In your terminal:

```bash
claude plugin marketplace add rbennion/ccvault
claude plugin install life-vault@rick-plugins
```

Or, from a copy of this repo on your Mac:

```bash
claude plugin marketplace add /path/to/life-vault-plugin
claude plugin install life-vault@rick-plugins
```

Then start Claude Code and type:

```
/life-vault:setup
```

## Day to day

| Say | What happens |
|---|---|
| "good morning" | Daily briefing: email, calendar, deadlines, top 3 |
| "start a project for…" | New project with its tasks |
| "remind me to…" | Task filed into the right project |
| "let me tell you about…" | Saved to your profile |
| "save this" | End of session: everything worth keeping goes into the vault |
| "weekly review" | Catches what the daily list hides, and reviews what Claude learned about you |
| "what do you know about me" | Shows your profile so you can fix it |

## What's inside

| Skill | Job |
|---|---|
| `setup` | Creates the vault, runs the interview, seeds projects, walks you through Obsidian and connectors |
| `about-me` | The interview, and saving what Claude learns as you go |
| `vault` | Where everything goes (Claude loads this on its own) |
| `projects` | Project files, flags, status changes |
| `briefing` | Daily briefing and weekly review |
| `save` | End-of-session sweep into the vault |

A session-start hook loads your vault location, profile snapshot and working rules into every session.

## Updating

```bash
claude plugin marketplace update rick-plugins
claude plugin update life-vault@rick-plugins
```

Restart Claude Code afterwards.

## Tests

```bash
bash tests/run.sh
```
