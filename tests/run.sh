#!/bin/bash
# Tests for the life-vault plugin: manifests, the session-start hook, and the
# starter template. Run from anywhere: bash tests/run.sh

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN="$ROOT/plugins/life-vault"
HOOK="$PLUGIN/scripts/session-context.sh"
TEMPLATE="$PLUGIN/template"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

pass=0
fail=0
ok()  { pass=$((pass + 1)); echo "OK   $1"; }
bad() { fail=$((fail + 1)); echo "FAIL $1"; [ -n "${2:-}" ] && echo "     $2"; }
check() { if eval "$2"; then ok "$1"; else bad "$1" "${3:-}"; fi; }

# --- Manifests -------------------------------------------------------------

check "plugin validates" "claude plugin validate '$PLUGIN' --strict >/dev/null 2>&1"
check "marketplace validates" "claude plugin validate '$ROOT' --strict >/dev/null 2>&1"
check "marketplace entry name matches plugin name" \
  "[ \"\$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))[\"plugins\"][0][\"name\"])' '$ROOT/.claude-plugin/marketplace.json')\" = \"\$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))[\"name\"])' '$PLUGIN/.claude-plugin/plugin.json')\" ]"

# --- Session-start hook ----------------------------------------------------

out=$(env -u CLAUDE_PLUGIN_DATA bash "$HOOK")
check "hook: no data dir offers setup" "grep -q '/life-vault:setup' <<<\"\$out\""

mkdir -p "$TMP/data-empty"
out=$(CLAUDE_PLUGIN_DATA="$TMP/data-empty" bash "$HOOK")
check "hook: no saved path offers setup" "grep -q 'no vault is set up' <<<\"\$out\""

mkdir -p "$TMP/data-gone"
echo "$TMP/does-not-exist" > "$TMP/data-gone/vault-path"
out=$(CLAUDE_PLUGIN_DATA="$TMP/data-gone" bash "$HOOK")
check "hook: missing vault asks to reconnect" "grep -q 'is missing' <<<\"\$out\""

# A fresh vault from the template, exactly as setup copies it.
VAULT="$TMP/Life Vault"
mkdir -p "$VAULT"
cp -Rn "$TEMPLATE/." "$VAULT/"
mkdir -p "$TMP/data"
printf '%s\n' "$VAULT" > "$TMP/data/vault-path"

out=$(CLAUDE_PLUGIN_DATA="$TMP/data" bash "$HOOK")
check "hook: names the vault (path with a space)" "grep -qF 'Life vault: $VAULT' <<<\"\$out\""
check "hook: empty snapshot offers the interview" "grep -q 'no snapshot yet' <<<\"\$out\""
check "hook: includes the working rules" "grep -q 'Never send an email' <<<\"\$out\""
check "hook: says the user's rules win over skill defaults" "grep -q 'override the life-vault skills' <<<\"\$out\""
check "hook: strips frontmatter" "! grep -q '^type: preferences' <<<\"\$out\""
check "hook: strips HTML comments" "! grep -q '<!--' <<<\"\$out\""

# Fill the snapshot the way the interview does.
python3 - "$VAULT/About Me.md" <<'EOF'
import sys
p = sys.argv[1]
s = open(p).read()
s = s.replace("## Snapshot\n", "## Snapshot\n- Name: Sam Rivera, Springfield\n- Works as a nurse, night shifts\n", 1)
open(p, "w").write(s)
EOF
out=$(CLAUDE_PLUGIN_DATA="$TMP/data" bash "$HOOK")
check "hook: includes the snapshot" "grep -q 'Sam Rivera' <<<\"\$out\" && grep -q 'night shifts' <<<\"\$out\""
check "hook: snapshot stops at the next section" "! grep -q '## Who I Am' <<<\"\$out\""

# Oversized preferences must stay under Claude Code's 10,000-character cap.
for i in $(seq 1 400); do echo "- Learned rule number $i. Why: testing the cap. 2026-10-23" ; done >> "$VAULT/How Claude Works With Me.md"
out=$(CLAUDE_PLUGIN_DATA="$TMP/data" bash "$HOOK")
check "hook: output under 10,000 characters" "[ \${#out} -le 10000 ]" "got ${#out}"

# --- Template --------------------------------------------------------------

# Setup must never overwrite an existing vault's notes.
ADOPT="$TMP/Existing"
mkdir -p "$ADOPT/Projects"
echo "my own admin notes" > "$ADOPT/Projects/Personal Admin.md"
cp -Rn "$TEMPLATE/." "$ADOPT/"
check "template copy keeps existing notes" "grep -q 'my own admin notes' '$ADOPT/Projects/Personal Admin.md'"
check "template copy adds missing files" "[ -f '$ADOPT/About Me.md' ] && [ -f '$ADOPT/.obsidian/core-plugins.json' ]"

if python3 -c 'import yaml' 2>/dev/null; then
  yaml_errors=$(python3 - "$TEMPLATE" <<'EOF'
import sys, pathlib, yaml
root = pathlib.Path(sys.argv[1])
for p in root.rglob("*.md"):
    text = p.read_text()
    if text.startswith("---\n"):
        try:
            yaml.safe_load(text.split("---\n")[1])
        except Exception as e:
            print(f"{p.relative_to(root)}: {e}")
for p in root.rglob("*.base"):
    try:
        yaml.safe_load(p.read_text())
    except Exception as e:
        print(f"{p.relative_to(root)}: {e}")
EOF
)
  check "template frontmatter and .base files parse" "[ -z \"\$yaml_errors\" ]" "$yaml_errors"
else
  echo "SKIP template YAML parse (python3 has no yaml module)"
fi

projects_have_flags() {
  local f k
  for f in "$TEMPLATE"/Projects/*.md; do
    for k in 'type: project' 'status:' 'health:' 'surface:' 'domain:'; do
      grep -q "^$k" "$f" || return 1
    done
  done
}
check "every template project has type: project and all four flags" projects_have_flags

# Open checkboxes outside code blocks would show up as real tasks in Todos.
stray_tasks() {
  find "$TEMPLATE" -name '*.md' -print0 | xargs -0 awk '
    FNR == 1 { fence = 0 }
    /^```/   { fence = !fence; next }
    !fence && /^- \[ \]/ { print FILENAME ": " $0 }'
}
check "template has no open tasks outside code blocks" '[ -z "$(stray_tasks)" ]' "$(stray_tasks)"

check "placeholders only in CLAUDE.md" \
  '[ -z "$(grep -rl "{{" "$TEMPLATE" | grep -v "/CLAUDE.md$")" ]'

echo
echo "$pass passed, $fail failed"
[ "$fail" -eq 0 ]
