{ ... }:

# Global AGENTS.md for the `pi` coding agent.
#
# This file is loaded for EVERY pi session, in addition to any AGENTS.md
# files found walking up from cwd and in cwd itself. Keep it generic:
# environment, tooling, and behavioral defaults that apply everywhere.
# Project- and directory-specific rules belong in per-project AGENTS.md.
#
# Pi context-file load order (all concatenated):
#   1. ~/.pi/agent/AGENTS.md           <- this file (managed by home-manager)
#   2. every parent dir of cwd, walking up
#   3. cwd/AGENTS.md

{
  home.file.".pi/agent/AGENTS.md".text = ''
    # Global Agent Context

    Always-on context for Cameron's environment. Per-project `AGENTS.md` files
    override or extend anything here — trust them over this file when they
    conflict.

    ## Operator

    - User: Cameron. Solo operator, no team conventions to satisfy.
    - Prefers short, direct answers. No preamble, no recap, no "Great question!".
    - Thinking out loud is fine; padded plans for trivial tasks are not.
    - Ask before doing anything destructive or anything that touches files
      outside the current working tree.

    ## Coding principles

    **1. Think Before Coding** — Don't assume. Don't hide confusion. Surface tradeoffs.

    Before implementing: state assumptions explicitly. If uncertain, ask. If multiple
    interpretations exist, present them — don't pick silently. If a simpler approach
    exists, say so. Push back when warranted.

    **2. Simplicity First** — Minimum code that solves the problem. Nothing speculative.

    No features beyond what was asked. No abstractions for single-use code. No
    "flexibility" that wasn't requested. No error handling for impossible scenarios.
    If you write 200 lines and it could be 50, rewrite it.

    **3. Surgical Changes** — Touch only what you must. Clean up only your own mess.

    Don't improve adjacent code, comments, or formatting. Don't refactor things that
    aren't broken. Match existing style. Remove imports/variables/functions that YOUR
    changes made unused — don't remove pre-existing dead code unless asked.

    **4. Goal-Driven Execution** — Define success criteria. Loop until verified.

    Transform tasks into verifiable goals. For multi-step tasks, state a brief plan:
    each step with a verify check. Strong success criteria let you loop independently.

    ## Output style

    Keep responses clear and concise. Optimize for fast scanning, not
    thoroughness theater.

    - **Short by default.** Answer the question, stop. No restating the
      prompt, no "let me know if..." closers, no recap of what you just
      did unless it's non-obvious.
    - **Structure beats prose.** Use bullet lists, short tables, or fenced
      code blocks when they carry information faster than a paragraph.
      Don't pad single facts into bullet lists.
    - **Use diagrams when they actually help.** ASCII diagrams, trees, or
      simple flow arrows are welcome for: file/dir layouts, data flow,
      state machines, dependency graphs, before/after comparisons. Skip
      them for things a sentence already covers.
      - Tree for hierarchy:
        ```
        foo/
        ├── bar.js
        └── baz/
            └── qux.js
        ```
      - Arrows for flow: `client → api → db`
      - Mermaid is fine if the surface renders it; otherwise stick to ASCII.
    - **Code over description.** If the answer is a command or a diff, lead
      with it. Explain only the parts that aren't self-evident.
    - **No filler headings.** Don't add `## Summary` / `## Conclusion` to
      short replies.

    ## Environment

    - OS: NixOS (x86_64-linux server) and macOS (aarch64-darwin laptop), both
      managed from `~/configurations` (a single flake with nix-darwin +
      home-manager).
    - Shell: fish (interactive). Scripts are typically `bash` or `nushell`.
    - Editor: helix (`hx`). Terminal: wezterm. Pager: whatever fish defaults to.
    - Package manager: **nix**. Prefer `nix run nixpkgs#<pkg>` or adding to
      the flake over `npm i -g`, `pip install --user`, `brew install`, etc.
      If a tool is missing, suggest the nix way first.
    - Git is available everywhere. `lazygit`, `fzf`, `ripgrep` (`rg`), `fd`,
      `bat`, `eza` are installed and preferred over their classic equivalents.

    ## Tool preferences

    - **Search files**: `rg` over `grep -r`. `fd` over `find`.
    - **List files**: `ls` (or `eza` if the tree is large). Avoid recursive
      `ls -R` — use `fd` or `rg --files` instead.
    - **Read files**: use the `read` tool, not `cat`/`head`/`sed`.
    - **Edit files**: use the `edit` tool for targeted changes; `write` only
      for new files or full rewrites.
    - **Run stuff**: `bash` tool. Don't background long-running processes
      without being asked.

    ## Skills

    Installed skills live under `~/.pi/agent/skills/`, one directory per
    package (e.g. `~/.pi/agent/skills/pi-skills/<skill-name>/SKILL.md`).
    The startup header and the `<available_skills>` block in the system
    prompt list what's currently loaded with a one-line description each.

    Rules of thumb:

    - **Discover before assuming.** If you're unsure whether a skill exists
      for a task, `ls ~/.pi/agent/skills/*/` or check the system prompt's
      `<available_skills>` list — don't guess from memory, the set changes.
    - **Read the contract before use.** A skill's description in the system
      prompt is a summary. Before invoking one, `read` its `SKILL.md` so you
      know its actual inputs, flags, and failure modes.
    - **Prefer a skill over reinventing.** If a skill covers the task (web
      search, calendar, email, transcription, browser automation, etc.),
      use it instead of hand-rolling curl/API calls.
    - **Skills are lazy.** They cost nothing until invoked, so their
      presence in the list is not a suggestion to use them — only reach for
      one when the task actually matches.

    ## Safety defaults

    - Never read files matching `*key*`, `*.pem`, `*.p12`, `*.kdbx`, `.env*`,
      `id_rsa*`, `id_ed25519*`, or anything under `~/ssl`, `~/wireguard-keys`,
      `~/.ssh`, `~/.gnupg` unless I name the exact file.
    - Never run: `rm -rf` on anything outside the current project, `git push
      --force`, `git reset --hard` on a shared branch, `chmod -R`, `chown -R`,
      `sudo` commands I didn't ask for.
    - Never commit or push on my behalf unless I explicitly say "commit" /
      "push". Staging (`git add`) for review is fine.
    - Never write to `/etc`, `/nix`, `/boot`, or anywhere outside `$HOME`
      without being asked.
    - If a command would take >30s or produce huge output, say so first and
      ask whether to proceed.

    ## Nix specifics (since most work touches nix)

    - Flake lives at `~/configurations`. See its `AGENTS.md` for structure,
      rebuild commands, and conventions.
    - Prefer `nix flake check --no-build` before suggesting a rebuild — it's
      the cheapest eval-time sanity check.
    - Don't suggest `nix-env -i` / `nix-channel` — this system is flake-only
      with home-manager.
    - On macOS, Determinate Systems manages the Nix daemon (`nix.enable =
      false` in the darwin config is intentional).

    ## When unsure

    - Ask one clarifying question rather than guessing across multiple
      branches of possibility.
    - If a project has its own `AGENTS.md`, defer to it. If it contradicts
      this file, the project wins.
  '';

  home.file.".pi/agent/skills/pi-skills/vikunja/SKILL.md".text = ''
    ---
    name: vikunja
    description: Vikunja todo app — create, list, and complete tasks. Use when the user wants to add tasks, todos, or reminders to their todo list.
    ---

    # Vikunja

    Create and manage tasks in Cameron's Vikunja instance.

    ## Usage

    ```bash
    # Create a task (defaults to TODO project)
    {baseDir}/task.sh create "Task title"

    # Create with options
    {baseDir}/task.sh create "Task title" --description "more detail" --due 2026-05-30 --priority 3

    # Create in a specific project
    {baseDir}/task.sh create "Task title" --project 3

    # List tasks in a project (defaults to TODO)
    {baseDir}/task.sh list
    {baseDir}/task.sh list 3

    # Mark a task done
    {baseDir}/task.sh done 50

    # List all projects with their IDs
    {baseDir}/task.sh projects
    ```

    ## Projects

    | ID | Name |
    |----|------|
    | 1  | TODO (default inbox) |
    | 2  | Mapplication |
    | 3  | Ideas |
    | 4  | Setup PI |
    | 5  | Discord Bot |

    ## Priority levels

    0 = none, 1 = low, 2 = medium, 3 = high, 4 = urgent, 5 = DO NOW

    ## When to use

    - User says "add a task", "remind me to", "add to my todo list", "make a note to"
    - Default to project 1 (TODO) unless the user specifies otherwise
    - Use --priority 3 or higher when user says "urgent", "important", "don't forget"
  '';

  home.file.".pi/agent/skills/pi-skills/vikunja/task.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Vikunja task CLI
      set -euo pipefail

      VIKUNJA_URL="http://localhost:3456"
      VIKUNJA_TOKEN="tk_4e8096dfcb255f263234de2c389afb718ff43e81"
      DEFAULT_PROJECT=1  # TODO project

      api() {
        local method="$1"; shift
        local path="$1"; shift
        curl -sf -X "$method" \
          -H "Authorization: Bearer $VIKUNJA_TOKEN" \
          -H "Content-Type: application/json" \
          "$VIKUNJA_URL/api/v1$path" "$@"
      }

      cmd="''${1:-help}"; shift || true

      case "$cmd" in
        create)
          title="$1"; shift
          project="$DEFAULT_PROJECT"
          description=""
          due=""
          priority=0
          while [[ $# -gt 0 ]]; do
            case "$1" in
              --project)     project="$2";      shift 2 ;;
              --description) description="$2";  shift 2 ;;
              --due)         due="$2T00:00:00Z"; shift 2 ;;
              --priority)    priority="$2";     shift 2 ;;
              *) shift ;;
            esac
          done
          payload=$(printf '{"title":"%s","description":"%s","due_date":"%s","priority":%d}' \
            "$title" "$description" "$due" "$priority")
          result=$(api PUT "/projects/$project/tasks" -d "$payload")
          id=$(echo "$result" | grep -oP '"id":\K\d+' | head -1)
          echo "Created task #$id: $title"
          ;;

        done)
          task_id="$1"
          api POST "/tasks/$task_id" -d '{"done":true}' > /dev/null
          echo "Task #$task_id marked as done"
          ;;

        list)
          project="''${1:-$DEFAULT_PROJECT}"
          api GET "/projects/$project/tasks" | \
            grep -oP '"id":\d+,"title":"[^"]*","description":"[^"]*","done":(true|false)' | \
            while IFS= read -r line; do
              id=$(echo "$line" | grep -oP '"id":\K\d+')
              title=$(echo "$line" | grep -oP '"title":"\K[^"]*')
              done=$(echo "$line" | grep -oP '"done":\K\w+')
              status=$( [[ "$done" == "true" ]] && echo "✓" || echo "○" )
              echo "$status #$id  $title"
            done
          ;;

        projects)
          api GET "/projects" | \
            grep -oP '"id":\d+,"title":"[^"]*"' | \
            grep -v '"title":"List"\|"title":"Gantt"\|"title":"Table"\|"title":"Kanban"' | \
            while IFS= read -r line; do
              id=$(echo "$line" | grep -oP '"id":\K\d+')
              title=$(echo "$line" | grep -oP '"title":"\K[^"]*')
              echo "#$id  $title"
            done
          ;;

        *)
          echo "Usage:"
          echo "  task.sh create \"title\" [--project <id>] [--description \"...\"] [--due YYYY-MM-DD] [--priority 0-5]"
          echo "  task.sh list [project_id]"
          echo "  task.sh done <task_id>"
          echo "  task.sh projects"
          ;;
      esac
    '';
  };
}
