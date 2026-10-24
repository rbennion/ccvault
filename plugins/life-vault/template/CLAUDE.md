# Life Vault

This vault runs {{NAME}}'s personal and work life. Claude reads this file before changing anything here.

It does three jobs:

1. **Projects and tasks**: every piece of work, at home or at work, lives in a project file with its tasks inside it.
2. **Daily planning**: a morning briefing pulls email, calendar and open tasks into one view.
3. **Learning**: the vault keeps a profile of {{NAME}} that grows as Claude learns more.

Set up {{TODAY}} with the life-vault plugin.

---

## Folders

| Folder / file | What goes there |
|---|---|
| `About Me.md` | Who {{NAME}} is: household, work, life areas, challenges, goals, accounts. Claude keeps it current. |
| `How Claude Works With Me.md` | How {{NAME}} wants Claude to talk and act. Claude adds a rule each time it's corrected. |
| `Planner/` | The daily system: `Todos.md` (every open task), `Daily Briefing.md`, `Project Dashboard.md`, `Captured Notes.md`, `Weekly Review/` |
| `Projects/` | One file per project, work and personal. `Personal Admin.md` holds small one-off personal chores. |
| `Reference/` | Facts worth keeping that aren't projects: the house, cars, insurance, medical, how-tos, product research |

Other top-level folders may be added for a big life area once it has several notes (ask first).

---

## Tasks

Tasks live **inside the project file they belong to**, under `## Action Items`, in Obsidian Tasks syntax:

```
- [ ] Call the roofer about the leak 📅 2026-11-03 ⏫
- [ ] Renew car registration 📅 2026-12-15
- [x] Book dentist ✅ 2026-10-20
```

Symbols: 📅 due · 🛫 start · ⏫ high · 🔼 medium · 🔽 low · 🔁 recurring · ✅ done date.

`Planner/Todos.md` gathers every open task in the vault into one list. Never edit it; it's a set of live queries.

**Priority means consequence, not urgency of feeling:**

| Mark | Meaning |
|---|---|
| 🔺 highest | Critical: ignoring it could seriously hurt (house, credit, legal, health, government). Only {{NAME}} sets this. |
| ⏫ high | Important to {{NAME}}; nothing breaks if it waits a bit |
| 🔼 medium or no mark | Chores; can sit |
| 🔽 low | Parked: not now |

Due dates come only from {{NAME}} or from a real deadline in an email or letter. Claude never invents one.

---

## Project flags

Every project file carries four flags in its frontmatter (the YAML block at the top).

**`status`**: where the project is in its life.
- `active`: work is happening or expected soon
- `on_hold`: paused; add `hold_reason:` and `hold_date:`
- `complete`: done
- `cancelled`: dropped

**`health`**: only for active projects.
- `green`: on track
- `yellow`: at risk (stale over a week, waiting on someone, slipping)
- `red`: blocked or overdue
- empty for anything not active

**`surface`**: does this project's work show on the daily list? Test: *is there a real consequence if it doesn't get done?*
- `obligation`: yes. Shows on the daily list.
- `optional`: no. Nice-to-do projects. Hidden from the daily list; visible when the project is opened.
- `latent`: no deadline, but a big downside if it rots (backups, taxes, a will, insurance renewals). Hidden daily, brought back every weekly review.

**`domain`**: work or life, for focus views. Test: *is this for an employer, customer or client?*
- `work`: yes
- `personal`: home, family, money, health, hobbies, your own admin

**One real obligation, one project.** Don't bury something important inside a catch-all file just because it's related. If it matters, it gets its own named project so it can't hide. `Personal Admin.md` is only for small one-offs.

---

## Writing rules

- File names use spaces and capitals: `Kitchen Remodel.md`, not `kitchen-remodel.md`.
- Link related notes with `[[wikilinks]]`: projects to people, reference notes to projects.
- Write dates as real dates (2026-10-23), never "yesterday" or "next week".
- Project files are the permanent record. When an email or call changes a project, the detail goes into the project file, not only the briefing.
- In notes, write a dollar sign as `\$` (Obsidian treats a bare `$` as math and breaks the page).
- Never store passwords, PINs or Social Security numbers. Write where the login lives instead: "Login: password manager, item 'Electric company'".
- Small updates (three files or fewer) happen without asking. Bigger reorganizations get a numbered list first and wait for a yes.
- Never delete a note without asking.
