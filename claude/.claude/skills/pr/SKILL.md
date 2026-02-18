---
name: pr
description: Create a pull request with an auto-generated description
allowed-tools: Bash, Read, Grep, Glob
---

# Create a Pull Request with Auto-Generated Description

## Steps

1. **Determine the base branch** by running:

   ```bash
   git remote show origin
   ```

   Look for the "HEAD branch" line to identify whether the default branch is `master` or `main`. Use that as the base branch.

2. **Ensure the current branch is pushed** to origin. If it does not already track a remote branch, push with:

   ```bash
   git push -u origin HEAD
   ```

3. **Gather context** for the PR description:

   - Get all commit messages on this branch:

     ```bash
     git log <base>..HEAD --oneline
     ```

   - Get the full diff of changes:

     ```bash
     git diff <base>...HEAD
     ```

4. **Extract a ticket ID** from the current branch name using the pattern `[A-Z]+-[0-9]+` (e.g. `MCB-29` from `ben/MCB-29-add-admin-tool`). If a ticket ID is found, prepare a Linear link: `https://linear.app/issue/<TICKET>`.

5. **Generate a PR title** — a concise summary of the changes, under 70 characters.

6. **Generate a PR description** in this format:

   ```
   ## Summary
   <1-3 bullet points describing what changed and why>

   ## Test plan
   <bulleted checklist of how to verify the changes>

   <Linear ticket link if a ticket ID was found, otherwise omit>
   ```

7. **Create the PR** using `gh pr create` targeting the detected base branch. Use a HEREDOC for the body to preserve formatting:

   ```bash
   gh pr create --base <base> --title "the pr title" --body "$(cat <<'EOF'
   ## Summary
   ...

   ## Test plan
   ...

   https://linear.app/issue/TICKET-123
   EOF
   )"
   ```

8. **Enable auto-merge** (unless the user passed `--no-auto-merge` or `no-auto-merge` as an argument):

   ```bash
   gh pr merge --auto --merge
   ```

9. **Output the PR URL** returned by `gh pr create`.

## Important

- Do NOT amend or create any commits.
- Do NOT modify any files.
- If `gh pr create` fails because a PR already exists, inform the user and show the existing PR URL.
- Auto-merge is enabled by default. Pass `--no-auto-merge` to skip it.
