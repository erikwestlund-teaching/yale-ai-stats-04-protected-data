# Install the R packages every project in this workshop uses.
# Run once, from any workshop project folder: source("setup.R")

packages <- c(
  "readr",
  "dplyr",
  "tidyr",
  "ggplot2",
  "broom",
  "here",
  "rmarkdown"
)

missing <- setdiff(packages, rownames(installed.packages()))

if (length(missing) > 0) {
  repos <- getOption("repos")
  if (is.null(repos) || identical(unname(repos["CRAN"]), "@CRAN@")) {
    repos <- c(CRAN = "https://cloud.r-project.org")
  }
  install.packages(missing, repos = repos)
}

message("Packages ready: ", paste(packages, collapse = ", "))
