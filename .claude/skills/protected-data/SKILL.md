---
name: protected-data
description: Rules for working in a project that holds protected data. Use at the start of every task in this project, and before reading, listing, or searching any file.
---

# Protected data

Both machines keep raw data in `inputs/private/raw/` and simulated data in `inputs/private/simulated/`. Run agents only on the AI machine, where the simulated folder contains files a person reviewed and manually transferred. The secure machine runs without AI. Reviewed metadata is in `inputs/metadata/`. All data stays gitignored.

## Never

- Read, list, open, search, or run code on `inputs/private/raw/`, other private input folders, `outputs/private/`, or `.env`. The only readable private input folder is the reviewed `inputs/private/simulated/` copy on the AI machine.
- Ask the user to paste real data, real output, or real summary values into the chat.
- Hard-code values copied from real data into code or text.
- Change a notebook's `data_dir` setting to `"raw"`. Only a person does that, without AI.
- Write to `inputs/private/`, even to test `scripts/generate-sim-data.R`. Test it with an output path in a temporary folder.

## Always

- Read data only from the reviewed `inputs/private/simulated/` copy and `inputs/metadata/`. Git ignores both folders, so open their files by path.
- Build paths with `here::here()` and the notebook's `data_dir` variable, so a person can switch to the real data by changing one line.
- Treat results as fake. Check that the code runs. Don't interpret the numbers.
- If a task seems to need the real data, **stop and say so** instead of finding a workaround.

## Rendering

Don't run `quarto render` in this project. It writes to `outputs/private/`. Never pass `--output-dir`. To check code, run it with `knitr::knit()` into a temporary folder. The user renders.

```r
knitr::opts_chunk$set(fig.path = file.path(tempdir(), "figure/"))
knitr::knit("notebooks/01_data-summary.qmd", output = file.path(tempdir(), "01_data-summary.md"))
```
