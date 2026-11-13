---
name: git
description: How to use git in this project. Use before staging, committing, or pushing anything, and whenever the user mentions git or GitHub.
---

# Git

## Commit timing

- Commit only when the user asks.
- Never push unless the user asks. Never force-push.

## Before every commit

1. Run `git status` and read the list of changed files.
2. Make sure none of these are staged:
   - data or output in any `private/` folder (empty `.gitkeep` folder markers are allowed)
   - metadata extracted from protected data, such as files in `inputs/metadata/` (except an empty `.gitkeep` marker)
   - data files you didn't create from public sources
   - `.env`, credentials, or API keys
   - rendered output (`*.html`, `*_files/`) unless the user wants it committed
3. If a file that should be private shows up, stop and tell the user. Don't commit it, and don't add it to `.gitignore` without saying so.

Stage files by name (`git add notebooks/01_cleaning.qmd`). Don't use `git add .` or `git add -A`.

## Commit messages

- One line, under about 70 characters, in the imperative. Good: "Recode missing-value labels". Bad: "Cleaned stuff".
- Say what changed and, if it's not obvious, why.

## Never

- Rewrite history the user has pushed (`rebase`, `reset --hard`, `commit --amend` on pushed commits).
- Run `git commit --no-verify` to get around a hook. If a hook blocks a commit, tell the user what it found.
