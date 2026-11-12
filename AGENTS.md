# Yale AI Stats 04: Protected data

This is a privacy-sensitive project. Run only in the AI-enabled copy, which has no protected data. Never run an assistant on the secure machine.

In the workshop download, this project has two folders: `ai-enabled/` and `secure/`. If this project's folder is named `secure`, stop and tell the user to start you in `ai-enabled/` instead. Never read, list, or search anything outside this project folder, especially `../secure/`. Do not read, list, search, or print protected raw data in `inputs/private/raw/`, other private input folders, `outputs/private/`, or `.env`.

The one readable private input folder is `inputs/private/simulated/` on the AI machine. It holds only simulated files a person reviewed and manually transferred from the secure machine. Work with those files and reviewed metadata in `inputs/metadata/`. Git ignores their data. Follow the `protected-data` skill.

## Simulated data

Both machines use `inputs/private/simulated/`. A person runs `scripts/generate-sim-data.R` on the secure machine without AI, reviews its output there, and copies only the approved file to the same path on the AI machine.

Do not write into `inputs/private/simulated/` or overwrite the reviewed copy. Test the generator with an output path in a temporary folder, such as `file.path(tempdir(), "nhanes_2021_2023_analysis.csv")`.

## Rendering

Don't run `quarto render` in this project. It writes to `outputs/private/`. Never pass `--output-dir`. To check code, run it with `knitr::knit()` into a temporary folder. The user renders.

```r
knitr::opts_chunk$set(fig.path = file.path(tempdir(), "figure/"))
knitr::knit("notebooks/01_data-summary.qmd", output = file.path(tempdir(), "01_data-summary.md"))
```
