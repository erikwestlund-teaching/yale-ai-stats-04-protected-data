# Yale AI Stats 04: Protected data

This project holds protected data. Do not read, list, search, or print anything in `inputs/private/` or `outputs/private/`, or the `.env` file.

Work only with the reviewed metadata in `inputs/metadata/` and the simulated data in `inputs/simulated/`. Git ignores both folders, so open their files by path. Follow the `protected-data` skill.

## Simulated data

`scripts/generate-sim-data.R` writes to `inputs/private/simulated/` by default. You can't write there. To test the script, pass an output path in a temporary folder, such as `file.path(tempdir(), "nhanes_2021_2023_analysis.csv")`. The user runs it for real, reviews the output, and copies it to `inputs/simulated/raw/`.

## Rendering

Don't run `quarto render` in this project. It writes to `outputs/private/`. Never pass `--output-dir`. To check code, run it with `knitr::knit()` into a temporary folder. The user renders.

```r
knitr::opts_chunk$set(fig.path = file.path(tempdir(), "figure/"))
knitr::knit("notebooks/01_data-summary.qmd", output = file.path(tempdir(), "01_data-summary.md"))
```
