# Exercise 4: Working With Protected Data

Part of the workshop **AI Tools for Statistical Programming and Analysis**. The prompts are on the workshop page.

This is a **privacy-sensitive** project. The protected data lives in `inputs/private/`, and AI tools never see it. You develop the code with an agent against simulated data in `inputs/public/`, then run the finished code on the real data yourself.

The "protected" file is public NHANES data, so nothing bad happens if you slip. Practice as if it weren't public.

## Open the project

- **RStudio:** open `yale-ai-stats-04-protected-data.Rproj`.
- **Positron or VS Code:** open this folder (or `yale-ai-stats-04-protected-data.code-workspace`).
- **Claude Code or Codex:** start the tool from a terminal in this folder.

You need R with the **tidyverse**, **rmarkdown**, and **here** packages, and Quarto (bundled with RStudio).

## Steps

1. **Extract the structure, without AI.** With no assistant running, run `source("scripts/extract-data-info.R")`. It writes metadata to `outputs/private/metadata/`.
2. **Review it.** Read every file. Look for identifiers, rare categories, small counts, exact dates, and free text. Copy only what's safe into `inputs/public/metadata/`.
3. **Simulate.** Have your agent complete and run `scripts/generate-sim-data.R`. It writes `inputs/public/raw/nhanes_2021_2023_analysis.csv`, the same file name as the real data.
4. **Develop.** Have the agent fill in the two notebooks against the simulated data.
5. **Run on the real data, without AI.** Close the assistant, change `data_dir` to `"private"` at the top of each notebook, and render.

## Layers of protection in this project

| Layer | Where | How strong |
|---|---|---|
| Git | `.gitignore` excludes every `private/` folder | Deterministic, but only for files git doesn't already track |
| Pre-commit hook | Framework installs a git hook that refuses commits with private data (in projects it creates; a clone or zip doesn't include it) | Deterministic, but skipped by `git commit --no-verify` |
| Tool permissions | `.claude/settings.json` denies Claude Code access to the private folders and turns on its sandbox | Enforced by the tool, but only that tool |
| Context file | `AGENTS.md` | An instruction; the model can ignore it |
| Skill | `protected-data` in `.agents/skills/` and `.claude/skills/` | An instruction; **not proof of safety** |

All of this sits in one folder on your laptop, which is weaker than a real enclave. For real protected data, the strongest layer is separation: the agent runs on a machine, VM, or server where the data doesn't exist.

**Note for this course:** the protected file is committed to this repository so the exercise works out of the box. It was added with `git add -f`, because `.gitignore` excludes it, and committed with `--no-verify`, because the pre-commit hook blocked it. Both protections stop accidents, not someone determined to get around them.

## About the folders

This project was created from a [Framework](https://framework.pub) blueprint, so it has the folder layout of a real analysis project: raw data in `inputs/private/raw/` and `inputs/public/raw/`, notebooks in `notebooks/`, results in `outputs/`. You don't need the framework R package; the notebooks use plain R. Files like `settings.yml` and `scaffold.R` belong to Framework and can be ignored.
