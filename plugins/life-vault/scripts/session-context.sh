#!/bin/bash
# SessionStart hook: tells Claude where the life vault is, who the user is,
# and how they want Claude to work. Plain stdout becomes session context.
# Claude Code caps hook output at 10,000 characters, so keep it under that.

LIMIT=9000
cfg="${CLAUDE_PLUGIN_DATA:-}/vault-path"

if [ -z "${CLAUDE_PLUGIN_DATA:-}" ] || [ ! -s "$cfg" ]; then
  echo "life-vault plugin: no vault is set up yet. If the user wants help organizing their life or work, offer /life-vault:setup in one line, once."
  exit 0
fi

vault=$(head -n 1 "$cfg")
if [ ! -d "$vault" ]; then
  echo "life-vault plugin: the saved vault folder ($vault) is missing. Ask the user where the vault is now, then run /life-vault:setup to reconnect it."
  exit 0
fi

# Drop YAML frontmatter and single-line HTML comments.
body() {
  awk 'NR == 1 && /^---$/ { fm = 1; next }
       fm && /^---$/      { fm = 0; next }
       !fm' "$1" | grep -v '^[[:space:]]*<!--.*-->[[:space:]]*$'
}

# Print one "## Heading" section, without the heading line.
section() {
  awk -v h="## $2" '$0 == h { on = 1; next } on && /^## / { exit } on' "$1" \
    | grep -v '^[[:space:]]*<!--.*-->[[:space:]]*$'
}

{
  echo "Life vault: $vault"
  echo "Vault rules: $vault/CLAUDE.md. Load the life-vault:vault skill before reading or writing notes there."
  echo "When the user shares a lasting fact about themselves or corrects how you work, save it the same turn (life-vault:about-me skill)."

  if [ -f "$vault/About Me.md" ]; then
    snap=$(section "$vault/About Me.md" "Snapshot" | sed '/^[[:space:]]*$/d')
    if [ -n "$snap" ]; then
      echo
      echo "## Who the user is (snapshot from About Me.md)"
      echo "$snap"
    else
      echo
      echo "About Me.md has no snapshot yet. If the user hasn't done the interview, offer /life-vault:about-me once."
    fi
  fi

  if [ -f "$vault/How Claude Works With Me.md" ]; then
    echo
    echo "## How the user wants you to work (How Claude Works With Me.md)"
    echo "These override the life-vault skills' default formats and steps wherever they conflict."
    body "$vault/How Claude Works With Me.md" | sed '/^# /d'
  fi
} | head -c "$LIMIT"
