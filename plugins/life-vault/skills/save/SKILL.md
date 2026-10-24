---
name: save
description: End-of-session sweep. Reviews the whole conversation and makes sure everything worth keeping lands in the life vault (project facts, decisions, research, finished and new tasks, and anything learned about the user or how they want Claude to work), then reports one line per file written.
when_to_use: '"save this", "save", "save the session", "put this in the vault", "make sure this is saved", "did we save all this", "wrap up". Also offer it in one line when a long session is ending with things not yet saved.'
---

# Save: session → vault

Chat scrolls away; the vault is the record. This makes sure nothing worth keeping dies in the conversation.

Load the `vault` skill first and read `<vault>/CLAUDE.md`. Every write follows its rules.

## Step 1: Recover the whole session

Work from the conversation. If it was long or got compacted, also search the transcript so early details aren't lost. Find it with `ls ~/.claude/projects/*/${CLAUDE_SESSION_ID}.jsonl` and search it with `grep`; never read the whole file into the conversation.

## Step 2: List what's worth keeping

Look for:

- **Project facts:** decisions, quotes, prices, dates, people and their roles, files and where they are.
- **Research:** what was compared, what was picked and why, with links and the date.
- **Finished work:** any vault task this session completed. Tick it (`- [x] … ✅ YYYY-MM-DD`). A finished task left open is a gap.
- **Open work:** anything left to do, as a task in the file that owns it. No due date unless the user gave one.
- **Reference facts:** how something was fixed, a model number, a setting. Goes in `Reference/`.
- **About the user:** lasting facts about their life → `About Me.md`. Corrections or preferences about how you work → `How Claude Works With Me.md` → Learned rules. Follow the `about-me` skill's rules (ask first on sensitive topics).

For each item, check the vault: **already saved** (there and current), **update** (the file exists but is missing or out of date), or **new** (needs a new note; prefer adding to an existing one).

Skip small talk, ideas the user rejected, and anything they asked you not to keep. Never save passwords or ID numbers.

## Step 3: Write

- **Three files or fewer, no new folders:** write them now.
- **More than that:** show a numbered list (item → destination file), and write after the user says which.

Update in place: replace outdated statements rather than adding contradictions. Use real dates. Link related notes.

## Step 4: Report

One line per file touched: `path: what was added`. Then one line for anything deliberately not saved and why. No recap of the session.
