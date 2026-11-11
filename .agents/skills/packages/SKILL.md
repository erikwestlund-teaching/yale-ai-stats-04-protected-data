---
name: packages
description: How to add and load R packages in this project. Use whenever code needs a package that isn't loaded yet, or before installing anything.
---

# Packages

This project lists its packages in `setup.R`. Anyone who opens the project runs `source("setup.R")` once to install what's missing.

## Adding a package

1. Check whether it's already installed: `rlang::is_installed("janitor")` or `"janitor" %in% rownames(installed.packages())`.
2. Add it to the `packages` vector in `setup.R`, then run `source("setup.R")`.
3. Tell the user which package you added and why.

Don't call `install.packages()` in a notebook or script. A package installed that way isn't recorded, so the project breaks on the next computer.

## Loading packages

- Load each package the notebook uses with its own `library()` call at the top of the first chunk.
- Don't load meta-packages like `tidyverse`. Load the parts you use: `readr`, `dplyr`, `tidyr`, `ggplot2`.
- For a single function from a package you otherwise don't need, call it with `pkg::fun()` instead of loading the package.

## Choosing packages

- Prefer base R or a package the project already uses over adding a new one.
- Prefer small, well-maintained CRAN packages. Ask before adding a package from GitHub.
