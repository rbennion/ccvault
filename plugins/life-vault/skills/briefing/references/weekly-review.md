# Weekly Review

Run when the user asks ("weekly review"). It exists for what the daily list hides on purpose: `latent` projects, long `on_hold` projects, tasks that went stale, and what Claude has learned about the user.

**Gather first, then show numbered proposals, then change the vault only after the user picks.**

## Step 1: The window

Find the newest file in `Planner/Weekly Review/`. The review covers from that date to today. First review ever: the last 7 days. If it's been more than 6 weeks, say so and cover it all, older weeks more briefly.

## Step 2: What happened

Same sources as the daily briefing (email inbound and sent, calendar) over the whole window, plus tasks finished in the window. File project details into project files as you go.

## Step 3: Latent check (the main reason this exists)

Every project with `surface: latent`: last activity, open tasks, and one line on whether anything has become time-sensitive (a filing deadline, a renewal, a backup that stopped). Verdict per project: **nothing needed** or **needs action:** the specific action.

## Step 4: On-hold check

Every `status: on_hold` project held more than 3 weeks (or with no `hold_date`): why it's held, and a proposal: keep holding (with a date to look again), restart, or cancel. The user decides.

## Step 5: Health

Every active project gets `green`, `yellow` or `red` with a one-line reason. Don't count staleness across a known wait or absence; say who has the ball instead.

## Step 6: Stale tasks

For any project with more than 5 overdue tasks, or any task overdue more than 30 days: propose **done**, **new date** or **drop** for each. Apply what the user approves.

## Step 7: What Claude learned (the learning loop)

1. **New this week:** list the `What Claude Has Learned` rows added since the last review and any new `Learned rules`. Ask: "Anything here wrong?" Fix what they flag.
2. **Patterns:** look across the week for a topic that keeps coming up with no project (the boat came up four times), a project that hasn't been touched in a month, or a challenge in `About Me.md` with no project behind it. Propose each as one numbered line: create, close, or update.
3. **Stale profile:** any challenge or goal that no longer seems true ("the roof was fixed in September"). Propose the update.
4. **One getting-to-know-you question.** Pick the emptiest or oldest section of `About Me.md` and ask one question about it. Only one per week.

Save what they confirm through the `about-me` skill and keep the Snapshot current.

## Step 8: Write the review

Create `Planner/Weekly Review/YYYY-MM-DD.md`:

````markdown
# Weekly Review: YYYY-MM-DD

*Covers <last review> → today*

## What Happened
Per project, wikilinked, two to four bullets each. Only projects with activity.

## Decisions

## Latent Check
One line per latent project.

## On Hold Check
One line per long-held project and the user's decision.

## Health Changes
Only projects whose health changed: old → new, and why.

## What Claude Learned
The confirmed profile changes and new rules.

## Next Week
Three to five priorities, numbered.

## Latent Tasks (live)
```tasks
not done
filter by function task.file.property('surface') === 'latent'
group by filename
```
````

Never create tasks or set due dates the user didn't approve during the review.
