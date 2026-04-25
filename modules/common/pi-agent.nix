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
}
