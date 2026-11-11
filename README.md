# Exercise 4: Working With Protected Data

Part of the workshop **AI-Powered Coding and Data Analysis**. The prompts are on the workshop page.

This is a **privacy-sensitive** project. The protected data lives in `inputs/private/`, and AI tools never see it. You develop the code with an agent against simulated data in `inputs/simulated/`, then run the finished code on the real data yourself. Simulated data comes from protected data, so it is never treated as public. Git ignores it, and you review it before an agent sees it.

The "protected" file is public NHANES data, so nothing bad happens if you slip. Practice as if it weren't public.

## Install packages

Run this once in the R console, from the project folder:

```r
source("setup.R")
```

It installs any missing packages used anywhere in the workshop: readr, dplyr, tidyr, ggplot2, broom, here, and rmarkdown. If you already ran it for another workshop project, you can skip this step.

## Open the project

- **RStudio:** open `yale-ai-stats-04-protected-data.Rproj`.
- **Positron or VS Code:** open this folder.
- **Claude Code or Codex:** start the tool from a terminal in this folder.

On Windows, Claude Code's sandbox needs WSL2. This project requires the sandbox, so Claude Code won't start here on Windows without WSL2. Use Codex or Posit Assistant instead.

You need R and Quarto. Quarto comes with RStudio and Positron. `setup.R` installs the packages.

## Steps

1. **Extract the structure, without AI.** With no assistant running, run `source("scripts/extract-data-info.R")`. It writes metadata to `outputs/private/metadata/`.
2. **Review the metadata.** Read every file. Look for identifiers, rare categories, small counts, exact dates, and free text. Merge any category with a count under 50 into a larger one. Deleting it isn't enough, because the total and the other counts reveal it by subtraction. Round or drop the minimum and maximum of skewed variables. Remove survey weights and design variables unless you need them. Copy only what's safe into `inputs/metadata/`.
3. **Write the generator, with the agent.** Have your agent complete `scripts/generate-sim-data.R` from the files in `inputs/metadata/`. Its default output is `inputs/private/simulated/nhanes_2021_2023_analysis.csv`. The agent can't write there, so it tests the script by passing an output path in a temporary folder.
4. **Generate, without AI.** Bring the reviewed generator script and metadata into the secure environment. With no assistant running, run `source("scripts/generate-sim-data.R")` there. It writes to `inputs/private/simulated/`.
5. **Review the simulated data as a release, without AI.** Check for small cells, exact minimums and maximums, recognizable combinations of values, and IDs that match real ones. After the required release review and approval, copy the file yourself to `inputs/simulated/raw/nhanes_2021_2023_analysis.csv` on your AI machine. Keep both copies out of git.
6. **Develop.** Have the agent fill in the two notebooks. Each starts with `data_dir <- "simulated"`, so it reads `inputs/simulated/raw/`. The agent checks its code without rendering, because rendering writes to `outputs/private/`.
7. **Run on the real data, without AI.** Close the assistant, change `data_dir` to `"private"` at the top of each notebook, and render. The notebooks then read `inputs/private/raw/`, and the HTML goes to `outputs/private/notebooks/`. Before sharing it, check for exact small counts, exact minimums and maximums, and plots with one point per person. Delete any text saying the data are simulated.

## Layers of protection in this project

| Layer | Location | Strength |
|---|---|---|
| Git | `.gitignore` excludes every `private/` folder, `inputs/metadata/`, and `inputs/simulated/` | Deterministic, but only for files git doesn't already track |
| Pre-commit hook | Framework installs a git hook that refuses commits with private data (in projects it creates; a clone or zip doesn't include it) | Deterministic, but skipped by `git commit --no-verify` |
| Tool permissions | `.claude/settings.json` denies Claude Code access to the private folders and turns on its sandbox | Enforced by Claude Code only. Codex has no tool-permission layer here, so a Codex user who allows everything is protected only by `AGENTS.md` and the skills |
| Context file | `AGENTS.md` | An instruction; the model can ignore it |
| Skill | `protected-data` in `.agents/skills/` and `.claude/skills/` (with the general `git` skill: check `git status`, never stage `private/`) | An instruction; **not proof of safety** |

All of this sits in one folder on your laptop, which is weaker than a real enclave. For real protected data, the strongest layer is separation: the agent runs on a machine, VM, or server where the data doesn't exist.

**Note for this course:** the protected file is committed to this repository so the exercise works out of the box. It was added with `git add -f`, because `.gitignore` excludes it, and committed with `--no-verify`, because the pre-commit hook blocked it. Both protections stop accidents. They don't stop someone determined to get around them.

## Folder layout

This project was created from a [Framework](https://framework.pub) blueprint, so it has the folder layout of a real analysis project. You don't need the framework R package. The notebooks use plain R.

| Folder | Contents | Agents | Git |
|---|---|---|---|
| `inputs/private/raw/` | The protected data | No access | Ignored (this course commits the one file) |
| `inputs/private/simulated/` | Simulated data before your review | No access | Ignored |
| `outputs/private/` | Unreviewed metadata and rendered notebooks | No access | Ignored |
| `inputs/metadata/` | Metadata you reviewed and copied | Read | Ignored |
| `inputs/simulated/raw/` | Simulated data you reviewed and copied | Read | Ignored |
| `scripts/`, `notebooks/` | Code | Read and write | Committed |

## Other simulation tools

This exercise uses `generate-sim-data.R` built from reviewed metadata. [synthpop](https://www.synthpop.org.uk/) can instead fit synthesis models to the original records. Run it only inside the secure environment. Remove direct identifiers, address rare categories and extreme values, and assess utility and disclosure risk using the [package documentation](https://cran.r-project.org/web/packages/synthpop/index.html). Removing replicated unique records alone does not establish privacy. Keep data, fitted objects, and diagnostics in private folders until the required release review and approval. Transfer only the approved simulated file yourself, and keep it gitignored. The Module 8 guide has further guidance.
