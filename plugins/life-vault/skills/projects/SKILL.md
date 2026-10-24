---
name: projects
description: Creates and runs projects in the life vault. The project file format, the four flags (status, health, surface, domain), putting a project on hold or closing it, checking on a project, and filing email or call details into it. Use before creating or editing any file in the vault's Projects folder.
when_to_use: '"start a project", "new project for", "make a project", "put X on hold", "X is done", "cancel X", "how is X going", "status of X", "add to X:", "what projects do I have".'
---

# Projects

Every piece of real work, at home or at work, is a project file in `<vault>/Projects/`. The file holds everything about it: what it is, decisions, details from emails and calls, its tasks, and its history. Read the vault's `CLAUDE.md` for the flag definitions; this skill is how to use them.

## The project file

```markdown
---
type: project
status: active          # active | on_hold | complete | cancelled
health: green           # green | yellow | red, or "" when not active
surface: obligation     # obligation | optional | latent
domain: personal        # work | personal
started: 2026-10-23
deadline:               # only for a real deadline
---

# Kitchen Remodel

**Status:** On track. Waiting on the second contractor quote.
**People:** Dana Smith (contractor, dana@example.com)

## Summary
One short paragraph: what this is and why it matters.

## Details
Facts, decisions, quotes, measurements, links, file paths. Grows over time.

## Action Items
- [ ] Get the second quote from Bay Builders ⏫
- [ ] Pick the countertop by 11/15 📅 2026-11-15

## History
| Date | Event |
|---|---|
| 2026-10-23 | Project created |
```

Only the frontmatter, the title and the Summary are required. Add other sections when there's something to put in them. `type: project` must be there or the dashboard won't see it.

## Creating a project

1. Check it doesn't exist already (search `Projects/` for the name and close variants).
2. Name it for the one thing it is: `Car Registration Renewal`, `Garage Cleanout`, `Q4 Sales Report`. Spaces and capitals.
3. Set the flags with these tests:
   - **surface**: "Is there a real consequence if this doesn't get done?" Yes → `obligation`. No → `optional`. No deadline but a big downside if forgotten (taxes, insurance, backups, a will) → `latent`.
   - **domain**: "Is this for an employer, customer or client?" Yes → `work`. Otherwise `personal`.
   - `status: active`, `health: green`, `started:` today.
4. Write the Summary from what the user said. Add the first tasks they mentioned.
5. One line back: "Created Kitchen Remodel (obligation, personal) with 2 tasks."

**One real obligation, one project.** If something important comes up inside an optional project (getting insurance for a hobby car), it goes in an obligation file (its own project, or Personal Admin if it's small), not buried in the optional one. Prefer one more small project over a catch-all that hides things.

## Changing status

| Change | Frontmatter | Also |
|---|---|---|
| Put on hold | `status: on_hold`, `health: ""`, add `hold_reason:` and `hold_date:` (today) | History row with the reason |
| Resume | `status: active`, set `health`, remove `hold_reason` and `hold_date` | History row |
| Done | `status: complete`, `health: ""` | Tick finished tasks; ask what to do with open ones (done, move, drop); History row |
| Dropped | `status: cancelled`, `health: ""` | History row with why |

Never delete or move a finished project. The dashboard sorts by status.

## Health (active projects only)

- `green`: moving, no blockers
- `yellow`: stale over a week, waiting on someone, slipping
- `red`: blocked or overdue

Keep the `**Status:**` line under the title in step with `health`. Don't call a project stale when the user said they're waiting on someone or away; say who has the ball instead.

## Checking on a project

"How's the kitchen going?" Read the frontmatter, the Status line, the last three History rows and the open tasks. Answer in two or three lines: where it stands, what's next, who's waiting on whom.

## Filing details into a project

When an email, call, meeting or conversation changes a project (a quote, a decision, a date, a new person, a file), write it into the project file the same session, without asking:

1. The fact goes in `## Details` (replace anything it makes outdated).
2. A row in `## History`: date and one line.
3. A new task if someone now owes something.
4. Update `health` if the picture changed.

The briefing gets overwritten every day; the project file is the record.

## Attachments

When a project collects files (quotes, contracts, photos, PDFs), promote it to a folder: `Projects/Kitchen Remodel/Kitchen Remodel.md` plus `Projects/Kitchen Remodel/Attachments/`. Use the Obsidian CLI `move` if it's available (it fixes links); otherwise move the file and check that links to it still work.
