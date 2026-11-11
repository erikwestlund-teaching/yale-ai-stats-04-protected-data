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
- Name files for what they contain, in `snake_case`: `bp_by_age_group.csv`, not `table1.csv`.
- Save only results someone will use. A rendered notebook already shows every table and figure, so don't save each one by default.
- Never write to `inputs/`. Cleaned data is the data-cleaning skill's job.
- Never save outputs that contain individual rows of protected data. Save summaries. If the project has a protected-data skill, its rules come first.

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
