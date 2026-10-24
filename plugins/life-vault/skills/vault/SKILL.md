---
name: vault
description: How the user's life vault works. Where it lives, what goes in each folder, where a new task or note belongs, task syntax, project flags, and the writing rules. Load before reading or writing any note in the vault.
when_to_use: Any request that touches notes, projects or tasks ("add a task", "remind me to", "what's on my list", "put this in my notes", "obsidian", "my vault"), or anything the user says about their life that should be kept.
user-invocable: false
---

# The life vault

## Find it

The session-start note names the vault folder. If it's missing, run `cat "${CLAUDE_PLUGIN_DATA}/vault-path"`. No path means setup hasn't run: offer `/life-vault:setup` in one line.

Read `<vault>/CLAUDE.md` before writing anything. It holds the folder map, task syntax, priority meanings and project flags. This skill is how to apply them.

`How Claude Works With Me.md` is the user's own word. Where it conflicts with any life-vault skill (a format, a numbered list, a step), the user's rule wins.

## Where things go

| It's... | It goes in |
|---|---|
| A task for an existing project | That project's `## Action Items` |
| A task big or important enough to track on its own | A new project (`projects` skill). Don't bury it in a catch-all. |
| A small personal one-off ("mail the form", "call the vet") | `Projects/Personal Admin.md` → `## Action Items` |
| A small work one-off | `Projects/Work Admin.md` (create it if they work and it's missing) |
| A detail from an email, call or meeting about a project | That project file: the detail in its notes, a row in `## History` |
| A lasting fact worth looking up later (insurance policy number, the furnace model, how to reset the router) | `Reference/<Topic>.md` |
| A link, article or idea with nothing to do yet | Top of `Planner/Captured Notes.md`, with the date |
| A fact about the user or their life | `About Me.md` (`about-me` skill, "Learning as you go") |
| A correction to how you work | `How Claude Works With Me.md` → `## Learned rules` |

`Planner/Todos.md`, `Planner/Project Dashboard.md` and `Planner/Projects Dashboard.base` are live views. Never edit them to add or change tasks or projects; change the source file instead.

## Tasks

```
- [ ] What to do, with enough context to act on it cold 📅 2026-11-03 ⏫
```

- One line per task. Put the context inline (who, what, why, the reference number).
- Priority by consequence (table in `CLAUDE.md`). Default to no mark. Use ⏫ when it clearly matters to them. Never set 🔺; only the user does.
- 📅 only for a date the user gave or a real deadline in a source (a bill's due date, a renewal date). Never invent one.
- Done: change `- [ ]` to `- [x]` and add ` ✅ YYYY-MM-DD`. Don't delete finished tasks; they're the history.
- When you add a task, say where it went in one line: "Added to Car Registration Renewal: renew online by 12/15."

## Writing rules

- Keep the vault current without asking for small updates (three files or fewer). For anything bigger (new folders, renaming or moving several files, restructuring), show a numbered list and wait for a yes.
- Update notes in place. When something changes, replace the old statement instead of adding a contradiction below it.
- Link related notes with `[[wikilinks]]`. Name files with spaces and capitals.
- Absolute dates only. Escape `$` as `\$` inside notes.
- Never delete a note without asking. Never store passwords, PINs or ID numbers.
- Before researching something from scratch on the web, search the vault; they may have looked into it before.

## Reading the vault

Plain file reads and edits always work. If the Obsidian command line tool is turned on and Obsidian is running, it can answer some questions faster (project lists, backlinks, broken links): see `references/obsidian-cli.md`. Nothing depends on it.
