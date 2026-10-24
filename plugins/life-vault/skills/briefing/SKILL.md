---
name: briefing
description: The daily briefing. Checks the user's email (inbound and sent), calendar and open vault tasks, writes a prioritized plan to Planner/Daily Briefing.md, gives a short version in chat, and files what it learned into project files and the user's profile. Also runs the weekly review.
when_to_use: '"good morning", "brief me", "what''s on my plate", "start my day", "plan my day", "catch me up", "what did I miss", "check my email", or a casual greeting that sounds like the start of the day. "weekly review" runs references/weekly-review.md instead.'
argument-hint: "[weekly]"
---

# Daily Briefing

Like a good assistant starting the day: check the calendar, the email and the to-do list, then hand over one clear plan.

If the user said "weekly review" or passed `weekly`, follow `references/weekly-review.md` instead.

## Before you start

Read fresh every time (they change):

1. `<vault>/About Me.md`: which email accounts and calendars they use, who the key people are.
2. `<vault>/How Claude Works With Me.md`: how they want this delivered.
3. `<vault>/Planner/Daily Briefing.md`: the date of the last briefing.

**Lookback:** from the last briefing's date to now. First briefing ever: 5 days. Cap it at 14 days and say so if the gap was longer.

**Mid-day re-run** (already briefed today): only what's new since the morning.

## Step 1: Check the tools

Find the email and calendar connectors in your tools (names containing `Gmail`, `Google_Calendar`, `ms365` or `outlook`). Ping each with a one-day query.

- A connector that fails or is missing: say so in the first line of the briefing and carry on with the rest. If none are connected, remind them once: connect them at https://claude.ai/customize/connectors, then restart Claude Code.

## Step 2: Gather (all at once)

Fire these in a single turn:

- **Email, each account, inbound AND sent.** Gmail: `search_threads` with `newer_than:<N>d` and `from:me newer_than:<N>d`. Outlook: `outlook_email_search` on Inbox and Sent Items with `afterDateTime`. Page through every result; don't stop at the first page.
- **Calendar:** today through three days out, every calendar they use.
- **Vault tasks:** every open `- [ ]` in `Projects/` whose file isn't `surface: optional` or `surface: latent`. Note due dates and priorities.

For every email from a real person (not a newsletter, receipt or alert), read the full message or thread. Subject lines aren't enough: you need who owes whom a reply and since when.

**Read Sent before judging anything.** People reply from their phone. Before you call a thread stale or say they owe someone, check Sent for a reply. Telling them they're behind on something they already handled is worse than missing an email.

## Step 3: Make sense of it

Sort each non-junk email:

| Bucket | What goes here |
|---|---|
| **Needs action today** | They owe a reply 2+ days; tied to today's meetings; time-sensitive; a bill or deadline |
| **This week** | Waiting 3+ days; a decision pending; read but not acted on |
| **FYI** | Notices, confirmations, newsletters worth a glance |

For each "today" and "this week" item: who, what, the open question, who owes whom, how long, which account.

Reconcile with the vault:
- Something resolved in email or Sent → tick the task (`- [x] … ✅ YYYY-MM-DD`).
- A clear new next step → add a task to the right project (`vault` skill routing). Due date only if the source has one.
- A project detail (a quote, a date, a decision) → file it into the project (`projects` skill, "Filing details").
- Anything overdue or due within 14 days → **Deadlines**.

**What the day taught you.** Watch for lasting facts about their life: a new person who keeps appearing, a new recurring commitment, a change at work, a new school or doctor. Don't save these silently. List them at the end of the chat briefing as numbered one-liners ("1. Save: Coach Lee runs Sam's soccer team, practice Tuesdays?"). Save the ones they confirm (`about-me` skill).

## Step 4: Deliver

Two outputs. Format for both: `references/briefing-format.md`.

1. **The file:** overwrite `Planner/Daily Briefing.md` with the full briefing.
2. **The chat:** the top only. Any degraded-source line, today's calendar, deadlines, the top 3 for today, and the numbered "save this?" list if there is one. Point to the file for the rest.

Then stop. No sign-off, no "let me know if".

## Drafting replies

When they ask you to answer an email:

- Make a real draft in their mail (the connector's create-draft tool), from the account the thread is on. Never paste a long reply into chat for them to copy.
- **Never send.** They send it. Sending needs an explicit "send it" every time.
- Sign with their first name only unless they say otherwise. Never add their phone number.
- Confirm in one line: "Draft is in your Gmail drafts."

## Tone

Direct, warm, no filler. Use people's names. Say plainly when something is overdue. Get the day right: check today's date and weekday before saying "tomorrow" or "Friday".
