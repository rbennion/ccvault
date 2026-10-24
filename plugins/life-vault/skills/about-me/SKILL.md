---
name: about-me
description: Gets to know the user and keeps their profile current. Runs the get-to-know-you interview (who they are, household, work, life areas, challenges, goals, accounts, how they want Claude to work) and writes About Me.md and How Claude Works With Me.md in the life vault. Also saves new facts and corrections as they come up, and answers "what do you know about me".
when_to_use: '"interview me", "get to know me", "let me tell you about myself", "update my profile", "what do you know about me", "that''s wrong about me", "I changed jobs", "we moved", "I got a new car", any correction to how Claude works ("don''t do that", "stop", "I prefer"), or the setup skill hands off to it.'
argument-hint: "[full | review | <section>]"
---

# About Me: the vault that learns

Two files hold what Claude knows about the user. Both sit at the vault root and the session-start hook loads them into every session:

- **`About Me.md`**: facts. Who they are, who's in their life, work, life areas, challenges, goals, accounts. Its `## Snapshot` (five to eight lines) is the part loaded every session; the rest is read when needed.
- **`How Claude Works With Me.md`**: behavior. How to talk to them, what to do vs ask, what never to do, and every rule learned from a correction.

Find the vault from the session-start note, or `cat "${CLAUDE_PLUGIN_DATA}/vault-path"`.

## Modes

| Mode | When | What to do |
|---|---|---|
| **Full interview** | First setup, "interview me", `/life-vault:about-me full` | The whole interview below |
| **One section** | "let me tell you about my job", `/life-vault:about-me work` | Only that topic's questions, then update that section and the Snapshot |
| **Review** | "what do you know about me" | Show the Snapshot and the last 10 rows of What Claude Has Learned. Ask what's wrong or missing. Fix it. |
| **Capture** | Anytime they mention a lasting fact or correct you | See "Learning as you go" |

## The interview

**How to ask:**
- One question per message. Plain, warm, short.
- Invite long answers: "Say as much as you like. Talking it out (dictation) works great."
- Follow up once when an answer hints at a worry, a deadline, or something slipping ("You mentioned the roof. Is that urgent or someday?"). Then move on.
- "Skip" is always fine. Don't push.
- Never ask for passwords, PINs, Social Security numbers or full card numbers.
- Keep a running list of anything that sounds like a project, a deadline or a worry. Setup turns it into projects.

**Questions, in order.** Adapt the wording to what they've already said; skip what's already answered.

1. **Basics.** "What should I call you? And roughly where do you live (city is enough)?"
2. **Household.** "Who's at home with you? Partner, kids, parents, pets?"
3. **Key people.** "Who else matters day to day? Family nearby, close friends, your boss, the people you work with most?"
4. **Work.** "What do you do for work? Who do you work for, and what does a normal week look like?"
5. **Work pain.** "What part of work piles up or slips through the cracks?"
6. **Own business** (only if they run one). "Tell me about the business: customers, the admin side (invoicing, taxes, filings), what you'd hand off if you could."
7. **Life areas.** "Outside work, what takes your time and attention? Home, money and bills, health, cars, kids' activities, hobbies, side projects, volunteering?"
8. **Challenges.** "What's falling through the cracks right now? What do you keep meaning to do but never get to?"
9. **Hidden risks.** "Anything with no deadline that would really hurt if it got forgotten? Taxes, insurance, backups, a will, a renewal?" (These become `latent` projects.)
10. **Goals.** "Three months from now, what would make you say this was worth it?"
11. **Accounts.** "Which email addresses do you use, and which is personal versus work? Which calendar do you live in?"
12. **Working with Claude.** Show the defaults already in `How Claude Works With Me.md` (do-or-ask and never lists) and ask:
    - "Do you want short answers or more detail?"
    - "Those defaults are what I'll follow. Anything to change or add? Anything I should never do?"
    - "What time does your day usually start?"

**Play it back** before writing anything. Ten lines or fewer: "Here's what I heard." Ask for corrections. Fix, then write.

**Write:**
- `About Me.md`: fill each section in plain sentences or the tables. Write the `## Snapshot` last: five to eight lines covering name, household, work, the top two or three challenges, and the main goal. Set `updated:` in the frontmatter to today.
- One row per fact in `## What Claude Has Learned`: `| YYYY-MM-DD | <fact> | interview |`. Keep rows short.
- `How Claude Works With Me.md`: fill `## How to talk to me` from question 12; apply any changes they asked for to the other lists; set `updated:`.
- Hand the running list of possible projects back to setup (Step 4). If this was a standalone interview, offer the same numbered project list setup uses and create what they pick through the `projects` skill.

## Learning as you go

This is what makes the vault get smarter. It runs in every session, not just interviews.

**What to save:**
- Lasting facts about their life: a new job, a move, a new car, a new baby, a diagnosis they choose to share, a new recurring commitment, a key person and who they are.
- Changes to goals or challenges ("the roof is fixed", "my new goal is to pay off the truck").
- Corrections to how you work ("don't summarize at the end", "always use my work email for school stuff"). These go in `How Claude Works With Me.md` → `## Learned rules` as one line: the rule, `Why:` their reason, and the date.

**What not to save:** passing moods, one-off trivia, anything they ask you to keep out, passwords or ID numbers.

**When:** in the same turn they say it. One line back, no fuss: "Saved to About Me: you started at Acme on Nov 3."

**Sensitive topics** (health, money trouble, family conflict, legal issues): ask first. "Want me to keep that in your profile?"

**Contradictions:** update the fact in place and delete the old statement. Never leave two versions. Log it: `| date | changed: works at Acme → works at Globex | conversation |`.

**Keep the Snapshot true.** Whenever a fact that's in the Snapshot changes, rewrite the Snapshot line too. It's what every new session sees first.

**Projects, not just facts.** If a new fact implies work ("we're selling the house in spring"), offer one line: "Want a project for the house sale?" Create it through the `projects` skill on yes.
