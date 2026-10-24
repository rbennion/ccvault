# Briefing format

## The file: `Planner/Daily Briefing.md`

Overwrite it completely. Wikilink every project you mention (`[[Kitchen Remodel]]`). Escape every `$` as `\$` (Obsidian reads a bare `$` as math and the page stops rendering). Number items (D1, D2…, E1, E2…) so the user can say "do E2".

````markdown
# Daily Briefing: Thursday, October 23, 2026

*Written by Claude, 7:42 AM. Covers Oct 22 7:30 AM → now.*
*Sources: all connected.* ← or name what was missing or empty

---

## Deadlines

Overdue first (days late), then this week, then within 14 days.

- **D1** Car registration renewal: due Dec 15, 53 days → [[Car Registration Renewal]]

## Today's Calendar

- **9:00 AM** Team standup (Teams). Nothing to prep.
- **3:30 PM** Sam's dentist, Dr. Patel. Leave by 3:10.

## Coming Up (next 3 days)

| Day | What | Notes |
|---|---|---|
| Fri 10/24 | Contractor walkthrough | Bring the quote from Bay Builders |

## Email

### Needs action today
**E1. Dana Smith: Countertop options** (Wed, Gmail)
Sent three samples and needs a pick by Friday to hold the install date. You owe the reply; no answer in Sent.

### This week
**E2. HR: Benefits enrollment** (Mon, work email)
Open enrollment closes Nov 7. Nothing sent yet.

### FYI
- Amazon: package arriving Saturday
- Bank: statement ready

## Projects

| Project | Where it stands |
|---|---|
| [[Kitchen Remodel]] | Waiting on your countertop pick (E1) |

## Today's Tasks (live)

```tasks
not done
filter by function task.file.property('surface') !== 'optional' && task.file.property('surface') !== 'latent'
(due before tomorrow) OR (priority is highest)
sort by priority
sort by due
group by filename
hide task count
```

## Top 3 Today

1. **Reply to Dana with the countertop pick** (E1): holds the install date
2. **Sam's dentist at 3:30**: leave by 3:10
3. **Start benefits enrollment** (E2): closes Nov 7
````

Copy the `tasks` block exactly. It's a live query that runs when the note is opened in Obsidian. Never swap `tomorrow` for a fixed date; the list has to stay right on days with no briefing.

Leave out any section with nothing in it, except Top 3.

## The chat version

Short. The file has the detail.

```
Thursday, Oct 23. All sources connected.

Calendar: standup 9:00, Sam's dentist 3:30 (leave 3:10).
Deadlines: car registration Dec 15.

Top 3:
1. Reply to Dana with the countertop pick (holds the install date)
2. Dentist at 3:30
3. Benefits enrollment closes Nov 7

Worth saving to your profile?
1. Dr. Patel is Sam's dentist
2. Dana Smith is the kitchen contractor

Full briefing: Planner/Daily Briefing.md
```

If the user is on their phone or asks for short: no tables in chat, five lines or fewer per section, every question numbered so they can reply with a digit.
