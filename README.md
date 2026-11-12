# Exercise 4: Working With Protected Data

Part of the workshop **AI-Powered Coding and Data Analysis**. The prompts are on the workshop page.

This is a **privacy-sensitive** project. Protected raw data lives in `inputs/private/raw/`, and AI tools never see it. Both machines use `inputs/private/raw/` for raw data and `inputs/private/simulated/` for simulated data. On the secure machine, generate and review the simulated file without AI. Manually copy the approved file to the same path on the AI machine, where the agent develops code against it. Run the finished code on the real data yourself on the secure machine. Simulated data comes from protected data, so it is never treated as public. Git ignores both copies, and you review the secure-side file before transferring it to the AI machine.

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
- **Claude Code or Codex:** start the tool from a terminal in the AI-machine copy only.

On Windows, Claude Code's sandbox needs WSL2. This project requires the sandbox, so Claude Code won't start here on Windows without WSL2. Use Codex or Posit Assistant instead.

You need R and Quarto. Quarto comes with RStudio and Positron. `setup.R` installs the packages.

## Steps

### 1. SECURE MACHINE: Extract the metadata

With no assistant running, run `source("scripts/extract-data-info.R")`. It writes metadata to `outputs/private/metadata/`.

### 2. SECURE MACHINE: Review the metadata

Review every file for identifiers, rare categories, small counts, exact dates, and free text. Merge categories with counts under 50 rather than deleting them, since other counts can reveal them by subtraction. Round or omit exact minimums and maximums that could identify people. Remove survey weights and design variables unless needed. Save only the reviewed metadata in `inputs/metadata/` on the secure machine.

### 3. SECURE MACHINE → AI-ENABLED MACHINE: Copy the reviewed metadata

Manually copy only the approved metadata to `inputs/metadata/` on the AI-enabled machine. Check the selected files before transferring them. Keep metadata out of Git; do not transfer raw data or unreviewed output.

### 4. AI-ENABLED MACHINE: Write the generator

Have the agent complete `scripts/generate-sim-data.R` using only the reviewed metadata. The script defaults to `inputs/private/simulated/nhanes_2021_2023_analysis.csv`. The agent tests it by passing an output path in a temporary folder, since it cannot write to `inputs/private/`.

### 5. AI-ENABLED MACHINE → SECURE MACHINE: Transfer the generator through version control

Review the generator and its changes. On the AI-enabled machine, commit and push only the generation script to the approved repository. On the secure machine, pull that commit without running an assistant. Inspect the staged changes before committing; keep data, metadata, and private outputs out of Git.

### 6. SECURE MACHINE: Generate the simulated data

With no assistant running, run `source("scripts/generate-sim-data.R")`. It reads the reviewed metadata and writes the simulated file to `inputs/private/simulated/`.

### 7. SECURE MACHINE: Review the simulated data

Review the generated file for small cells, exact minimums and maximums, recognizable combinations of values, and IDs that match real ones. Complete the required disclosure review and obtain approval before transferring it.

### 8. SECURE MACHINE → AI-ENABLED MACHINE: Copy the approved simulated data

Carefully copy only `nhanes_2021_2023_analysis.csv` from `inputs/private/simulated/` on the secure machine to the same path on the AI-enabled machine. Verify that it is the approved simulated file and that no raw data or unreviewed files are included. Keep both copies out of Git.

### 9. AI-ENABLED MACHINE: Develop the analysis

Have the agent fill in `notebooks/01_data-summary.qmd` and `notebooks/02_modeling.qmd`. Leave `data_dir <- "simulated"` so they read the approved simulated copy. Check code with `knitr::knit()` into a temporary folder. Do not render here, because rendering writes to `outputs/private/`. Develop and check the code without interpreting simulated results.

### 10. AI-ENABLED MACHINE → SECURE MACHINE: Transfer the analysis through version control

Review the analysis scripts and notebooks. On the AI-enabled machine, commit and push only the code to the approved repository. On the secure machine, pull those commits without running an assistant. Inspect staged changes before committing; keep data, metadata, and private outputs out of Git.

### 11. SECURE MACHINE: Run the analysis on real data

With no assistant running, change `data_dir` to `"raw"` at the top of each notebook and render them yourself. They read `inputs/private/raw/` and write HTML to `outputs/private/notebooks/`. Review all real-data output before sharing it, including small counts, exact minimums and maximums, and plots with one point per person. Remove text that describes the results as simulated.

## Layers of protection in this project

| Layer | Location | Strength |
|---|---|---|
| Git | `.gitignore` excludes data in every `private/` folder and in `inputs/metadata/` | Deterministic, but only for files git doesn't already track |
| Pre-commit hook | Framework installs a git hook that refuses commits with private data (in projects it creates; a clone or zip doesn't include it) | Deterministic, but skipped by `git commit --no-verify` |
| Tool permissions | `.claude/settings.json` blocks raw inputs and private outputs while allowing reads of the reviewed simulated copy and turns on its sandbox | Enforced by Claude Code only. Codex has no tool-permission layer here, so a Codex user who allows everything is protected only by `AGENTS.md` and the skills |
| Context file | `AGENTS.md` | An instruction; the model can ignore it |
| Skill | `protected-data` in `.agents/skills/` and `.claude/skills/` (with the general `git` skill: check `git status`, never stage private data) | An instruction; **not proof of safety** |

For this exercise, you can practice with separate project copies on one laptop. For real protected data, use separate machines, VMs, or servers. Never run the assistant in the secure environment. The AI machine receives only reviewed metadata and the approved simulated file.

**Note for this course:** the protected file is committed to this repository so the exercise works out of the box. It was added with `git add -f`, because `.gitignore` excludes it, and committed with `--no-verify`, because the pre-commit hook blocked it. Both protections stop accidents. They don't stop someone determined to get around them.

## Folder layout

This project was created from a [Framework](https://framework.pub) blueprint, so it has the folder layout of a real analysis project. You don't need the framework R package. The notebooks use plain R.

| Folder | Contents | Agents | Git |
|---|---|---|---|
| `inputs/private/raw/` | The protected data | No access | Ignored (this course commits the one file) |
| `inputs/private/simulated/` | Secure machine: generated data awaiting review. AI machine: manually transferred, reviewed copy | Read on AI machine only | Ignored |
| `outputs/private/` | Unreviewed metadata and rendered notebooks | No access | Ignored |
| `inputs/metadata/` | Metadata you reviewed and copied | Read | Ignored |
| `scripts/`, `notebooks/` | Code | Read and write | Committed |

## Other simulation tools

This exercise uses `generate-sim-data.R` built from reviewed metadata. [synthpop](https://www.synthpop.org.uk/) can instead fit synthesis models to the original records. Run it only inside the secure environment. Remove direct identifiers, address rare categories and extreme values, and assess utility and disclosure risk using the [package documentation](https://cran.r-project.org/web/packages/synthpop/index.html). Removing replicated unique records alone does not establish privacy. Keep data, fitted objects, and diagnostics in private folders until the required release review and approval. Transfer only the approved simulated file yourself, and keep it gitignored. The Module 8 guide has further guidance.
