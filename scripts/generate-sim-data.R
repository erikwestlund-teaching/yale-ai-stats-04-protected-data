# Generate simulated data from the reviewed metadata in inputs/metadata/.
# The agent completes this script. A person runs it, without AI.
#
# The default output is inputs/private/simulated/, on the secure side. Agents
# can't write there. To test the script, pass an output path in a temporary
# folder:
#
#   Rscript scripts/generate-sim-data.R "$(mktemp -d)/nhanes_2021_2023_analysis.csv"
#
# The person runs it with no argument (or source() it), reviews the output as a
# release, and copies it by hand to inputs/private/simulated/ on the AI machine.

library(readr)
library(dplyr)

metadata_dir <- here::here("inputs/metadata")
default_output_path <- here::here(
  "inputs/private/simulated/nhanes_2021_2023_analysis.csv"
)

args <- commandArgs(trailingOnly = TRUE)
output_path <- if (length(args) > 0) args[[1]] else default_output_path

# TODO: Read the metadata files:
# - dataset_info.csv
# - variable_info.csv
# - continuous_summary.csv
# - categorical_distribution.csv

# TODO: Generate a simulated dataset with the same file name, column names,
# broad data types, categorical levels, and plausible numeric ranges.

# TODO: Don't preserve or reconstruct real identifiers. Create new simulated IDs.

# TODO: Write the simulated data to output_path. Create its folder first:
# dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
