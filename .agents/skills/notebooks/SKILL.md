---
name: notebooks
description: How to write and organize notebooks and scripts in this project. Use whenever creating or editing a Quarto notebook or R script.
---

# Notebooks and scripts

## Structure

- Analysis lives in Quarto notebooks in `notebooks/`, numbered in the order they run: `01_cleaning.qmd`, `02_summary.qmd`, `03_analysis.qmd`.
- Each notebook does one step and reads what the step before it saved. Don't repeat cleaning in an analysis notebook.
- Put code that runs without being read, such as a data download, in `scripts/` as an `.R` file.

## The first chunk

Every notebook and script starts with the same setup:

```r
library(readr)
library(dplyr)

set.seed(2026)  # only if the notebook uses randomness
```

- Load every package here. Don't load packages partway through.
- Build every file path with `here::here()`, so the notebook renders from any working directory.
- Don't call `setwd()` or `rm(list = ls())`.

## Writing

- Explain each step in a sentence of prose before the chunk that does it.
- Keep chunks short. One chunk, one idea.
- Write a function when the same code appears three times. Put it in the notebook's first chunk.
- Render the notebook to check that it runs from top to bottom before saying it's done. If the project has a `protected-data` skill, follow its rules for checking code instead.

## Data flow

Raw data never changes. Cleaning writes new files next to it (usually `inputs/final/`), analysis reads the cleaned files, and results go to `outputs/`. The README lists this project's folders; follow it when it differs. When the README says tasks are independent, each notebook reads its own inputs.
