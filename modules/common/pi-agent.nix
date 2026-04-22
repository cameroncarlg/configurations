{ ... }:

# Global AGENTS.md for the `pi` coding agent.
#
# Pi loads this file for every session (not just when launched from ~).
# The original ~/AGENTS.md was written assuming cwd == ~, so a couple of
# lines ("You were launched from ~") are now a lie when pi is started
# elsewhere. Adjust if that bothers you.
#
# Pi search order (all matches are concatenated):
#   - ~/.pi/agent/AGENTS.md            <- this file
#   - every parent dir of cwd up to /
#   - cwd/AGENTS.md
# Project-level AGENTS.md files override/extend this one.

{
  home.file.".pi/agent/AGENTS.md".text = ''
    # Home Directory — Conversational Mode

    You were launched from `~` (Cameron's home directory). This is **not** a code
    project. Treat this session as a conversation, not a coding task.

    ## How to behave here

    - Default to **chat**, not action. Ask before doing.
    - Do **not** scan, grep, or `ls` the home tree looking for context unless I
      explicitly ask. My home dir is personal — respect it.
    - Do **not** create, edit, or move files in `~` on your own initiative. If a
      task needs a file, confirm the path with me first.
    - Keep answers short and direct. No preamble, no "Great question!", no
      recap of what I just said.
    - If I ask a factual or conceptual question, just answer it. Don't reach for
      tools unless the answer actually requires them.
    - Thinking out loud is fine; long structured plans for trivial chats are not.

    ## When I *do* want work done

    I'll usually say so explicitly ("help me fix…", "write a script that…",
    "edit ~/scripts/…"). In that case:

    - `cd` into the relevant subdirectory first (or work with absolute paths
      scoped to it) so you're not poking around the whole home tree.
    - Many subdirs are their own projects with their own `AGENTS.md` /
      conventions — prefer those over anything in this file.

    ## Layout cheat sheet (for when it's relevant)

    - `~/configurations` — NixOS flake (hosts, modules). Main system config.
    - `~/scripts/nix`, `~/scripts/nu` — personal shell/nushell scripts.
    - `~/notes` — personal notes and credentials-adjacent material. **Do not
      read files here unless I point you at a specific one.**
    - `~/projects`, `~/rust`, `~/learning_rust`, `~/cloud-resume-website`,
      `~/gleem`, `~/barotruama`, `~/cooking` — individual projects.
    - `~/ssl`, `~/wireguard-keys` — secrets. Never read, never cat, never diff.
    - `~/.pi/agent` — my pi config (skills, prompts, settings).

    ## Hard rules

    - Never read anything under `~/ssl`, `~/wireguard-keys`, or files matching
      `*key*`, `*.pem`, `*.p12`, `.env*` without an explicit instruction naming
      the exact file.
    - Never run destructive commands (`rm`, `mv` over existing files, `git
      reset --hard`, `git clean`, `chmod -R`, etc.) from this directory.
    - Don't `git` anything in `~` itself — it's not a repo and shouldn't become
      one.
  '';
}
