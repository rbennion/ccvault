---
name: setup
description: First-time setup for the life vault. Creates the Obsidian vault from the starter template, connects it to Claude, runs the get-to-know-you interview, seeds the first projects from the user's challenges and goals, and walks them through Obsidian and email/calendar hookup. Re-run any time to reconnect a moved vault or check setup health.
when_to_use: '"set up my vault", "setup", "get started", "help me get organized", "organize my life", "my vault moved", or the session-start note says no vault is set up and the user wants to begin.'
---

# Setup

The goal: in one sitting, the user ends up with a working vault that already knows who they are and holds their first real projects.

The user may be new to Claude Code, Obsidian and the terminal. Use plain words, give one step at a time, and wait for "done" before the next step.

## Step 1: See what already exists

Run `cat "${CLAUDE_PLUGIN_DATA}/vault-path" 2>/dev/null`.

- **A path comes back and that folder has `About Me.md`:** setup already ran. Ask which they want:
  1. Redo the get-to-know-you interview (hand off to the `about-me` skill)
  2. Reconnect a vault that moved (Step 2, adopting the existing folder)
  3. Check setup health (Steps 5 and 6 only)
- **Nothing, or the folder is gone:** fresh setup. Continue.

Check Obsidian is installed: `ls -d /Applications/Obsidian.app`. If it's missing, tell them to download it from https://obsidian.md/download and drag it into Applications. Keep going while they do; the vault files don't need Obsidian to exist.

## Step 2: Create the vault

Ask where to keep it. Suggest `~/Documents/Life Vault`. Expand `~` to the full path.

- **Folder doesn't exist or is empty:** copy the starter template.
- **Folder already has notes** (an existing vault): adopt it. List which starter files would be added, confirm, and never overwrite anything that's there.

Copy without overwriting, then make the folders the template leaves empty:

```bash
VAULT="<full path>"
mkdir -p "$VAULT"
cp -Rn "${CLAUDE_PLUGIN_ROOT}/template/." "$VAULT/"
mkdir -p "$VAULT/Projects" "$VAULT/Reference" "$VAULT/Planner/Weekly Review"
mkdir -p "${CLAUDE_PLUGIN_DATA}" && printf '%s\n' "$VAULT" > "${CLAUDE_PLUGIN_DATA}/vault-path"
```

The last line is what lets every future session find the vault.

## Step 3: Get to know them

Hand off to the `about-me` skill in **full interview** mode. It asks the questions, plays back what it heard, and writes `About Me.md` and `How Claude Works With Me.md`. Come back here when it's done.

Then fill the placeholders in the vault's `CLAUDE.md`: `{{NAME}}` with the name they want used, `{{TODAY}}` with today's date (YYYY-MM-DD).

## Step 4: Seed the first projects

Turn what the interview surfaced (challenges, goals, things falling through the cracks, anything with a deadline) into projects. Follow the `projects` skill for the file format and flags.

Show a numbered list, one line each: project name, `surface`, `domain`, and its first task. For example:

```
1. Car Registration Renewal (obligation, personal): renew online before the 12/15 deadline
2. Garage Cleanout (optional, personal): pick a Saturday
3. Q4 Sales Report (obligation, work): gather numbers from the shared drive
4. Estate Planning (latent, personal): find an estate attorney
```

Ask which to create ("all", or numbers). Create only those. If they have a job or business, also create `Projects/Work Admin.md` (same shape as `Personal Admin.md`, `domain: work`) for small work one-offs.

Rules:
- One real obligation per project. Never fold an important item into Personal Admin because it's related to something.
- Due dates only where the user gave one or a real deadline exists.
- Small chores that aren't worth a project go into Personal Admin or Work Admin as tasks.

## Step 5: Open it in Obsidian

Give these one at a time and wait for "done" after each:

1. Open Obsidian. On the start screen choose **Open folder as vault** and pick the vault folder.
2. If Obsidian asks whether to trust the vault's plugins, choose trust.
3. Open **Settings** (gear, bottom left) → **Community plugins** → **Turn on community plugins**.
4. **Browse** → search **Tasks** (by Clare Macrae and Ilyas Landikov) → **Install** → **Enable**.
5. Close settings and open `Planner/Todos.md`. Their seeded tasks should show up there.

Optional, only if they're comfortable: Obsidian 1.12.7 and later has a command line tool. **Settings → General → Command line interface**, then follow the prompt (it asks for the Mac password once). It makes some vault lookups faster; nothing depends on it.

## Step 6: Connect email and calendar

Look at your available tools for email and calendar connectors (tool names containing `Gmail`, `Google_Calendar`, `ms365` or `outlook`).

- **Found:** for each email account from the interview, run a one-day search to prove it works. Note which accounts are connected in `About Me.md` → Accounts and Tools.
- **Missing:** connectors are added on the Claude website, not in the terminal. Tell them: go to https://claude.ai/customize/connectors, connect Gmail and Google Calendar (or Microsoft 365 for Outlook), then quit and restart Claude Code. Claude Code picks up connectors from the claude.ai account it's signed in with. Until then, briefings cover the vault only.

## Step 7: Hand over

Tell them how to use it, in four lines:

- Start the day with "good morning" (or `/life-vault:briefing`).
- Tell Claude anything about yourself, any time. It gets saved.
- End a working session with "save this" (or `/life-vault:save`).
- Once a week, say "weekly review".

Nothing else. No recap of the setup.
