# Yale AI Stats 04: Protected data

This project holds protected data. Do not read, list, search, or print anything in `inputs/private/` or `outputs/private/`, or the `.env` file.

Work only with the simulated data and reviewed metadata in `inputs/public/`. Follow the `protected-data` skill.

## Rendering

Don't run `quarto render` in this project. It writes to `outputs/private/`. Never pass `--output-dir`. To check code, run it with `knitr::knit()` into a temporary folder. The user renders.

```r
knitr::opts_chunk$set(fig.path = file.path(tempdir(), "figure/"))
knitr::knit("notebooks/01_data-summary.qmd", output = file.path(tempdir(), "01_data-summary.md"))
```
