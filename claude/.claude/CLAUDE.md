# Global instructions

## Shell commands

- Do not use `find ... -exec`. It cannot be auto-approved (the `-exec` runs an
  arbitrary command), so it always triggers a permission prompt. To search file
  contents, use the `Grep` tool or `grep -r` / `rg`. To act on a found file
  list, pipe `find` into `xargs` or a `while read` loop instead of `-exec`.
