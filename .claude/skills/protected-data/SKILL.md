---
name: protected-data
description: Rules for working in a project that holds protected data. Use at the start of every task in this project, and before reading, listing, or searching any file.
---

# Protected data

This project keeps protected data in `private` folders and develops code on **simulated** data in `public` folders.

## Never

- Read, list, open, search, or run code on anything in `inputs/private/` or `outputs/private/`.
- Ask the user to paste real data, real output, or real summary values into the chat.
- Hard-code values copied from real data into code or text.
- Change a notebook's `data_dir` setting to `"private"`. Only a person does that, without AI.

## Always

- Work only with `inputs/public/`: the simulated data and the reviewed metadata in `inputs/public/metadata/`.
- Build paths with `here::here()` and the notebook's `data_dir` variable, so a person can switch to the real data by changing one line.
- Treat results as fake. Check that the code runs. Don't interpret the numbers.
- If a task seems to need the real data, **stop and say so** instead of finding a workaround.