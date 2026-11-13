---
name: outputs
description: Where and how to save tables, figures, and models in this project. Use whenever saving a result to a file.
---

# Outputs

Results go in `outputs/`, one folder per kind. Create the folder if it doesn't exist.

| Result | Folder | How |
|---|---|---|
| Table | `outputs/tables/` | `readr::write_csv()` |
| Figure | `outputs/figures/` | `ggplot2::ggsave()` with an explicit `width`, `height`, and `dpi` |
| Model | `outputs/models/` | `saveRDS()` |

## Rules

- Build paths with `here::here()`.
- Name files for what they contain, in `snake_case`. Use `mean_income_by_region.csv` instead of `table1.csv`.
- Never write results to `inputs/`. Only a data-cleaning step writes there.

## Slow steps

For a step that takes more than a minute, save its result with `saveRDS()` and read it back on later runs:

```r
path <- here::here("outputs/models/full_model.rds")
if (file.exists(path)) {
  fit <- readRDS(path)
} else {
  fit <- lm(y ~ ., data = analysis_data)
  saveRDS(fit, path)
}
```

Delete the saved file whenever the data or model changes.
