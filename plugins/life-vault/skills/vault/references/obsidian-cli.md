# Obsidian command line tool (optional)

Obsidian 1.12.7 and later ships a command line tool. The user turns it on in **Settings → General → Command line interface** and approves the prompt; it installs `/usr/local/bin/obsidian` (source: https://obsidian.md/help/cli).

## Before using it

- Check it exists: `command -v obsidian`. If not, edit files directly.
- It drives the running Obsidian app. If Obsidian is closed (`pgrep -x Obsidian` prints nothing), any command opens the app. Don't open it uninvited; edit files directly instead.
- **Never run bare `obsidian` or `obsidian --version`.** Without a subcommand it opens the app and the shell hangs. Always pass a subcommand.

## Useful commands

Syntax: `obsidian <command> key=value`. `file=<name>` finds a note by name, like a wikilink; `path=<exact path>` is literal. Quote names with spaces: `file="Personal Admin"`.

| Job | Command |
|---|---|
| Every project and its flags | `obsidian base:query path="Planner/Projects Dashboard.base" format=json` |
| Read or set one flag | `obsidian property:read file="Kitchen Remodel" name=status` / `property:set ... value=on_hold` |
| Search the vault | `obsidian search query="roofer"` |
| What links to a note | `obsidian backlinks file="Kitchen Remodel"` |
| Broken links after a move or rename | `obsidian unresolved` |
| Move a note and fix every link to it | `obsidian move file="Old Name" to="Projects/New Name.md"` |

`obsidian tasks` counts every task line including finished ones and ignores the `surface` flags, so it is not the daily-list number. The daily list is whatever `Planner/Todos.md` shows.
