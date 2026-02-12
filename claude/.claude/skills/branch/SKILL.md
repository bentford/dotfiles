---
name: branch
description: Create a feature branch from a Linear ticket
argument-hint: "<ticket-id>"
disable-model-invocation: true
allowed-tools: Bash
---

# Create Feature Branch from Linear Ticket

## Steps

1. **Fetch the Linear ticket** using the `get_issue` MCP tool with ticket identifier `$ARGUMENTS`. Extract the ticket title.

2. **Generate a kebab-case slug** from the title:
   - Lowercase the title
   - Drop articles and filler words (a, an, the, for, and, or, to, in, of, with)
   - Replace spaces and non-alphanumeric characters with hyphens
   - Collapse multiple hyphens
   - Keep only the first 4-5 meaningful words
   - Trim trailing hyphens

3. **Get the developer prefix** by running `git config user.name`, lowercasing the result, and taking only the first name (first word).

4. **Update master**:

   ```bash
   git checkout master && git pull origin master
   ```

5. **Create the feature branch** from master:

   ```bash
   git checkout -b <prefix>/<TICKET>-<slug>
   ```

   Where `<TICKET>` is the original ticket identifier (e.g. `MCI-55`) and `<slug>` is the generated slug.

6. **Confirm** by showing:
   - The new branch name
   - The ticket title
   - Output of `git status`

## Example

For ticket `LMO-55` with title "Branch create util" and git user "Neb Borf":

- Branch: `neb/LMO-55-branch-create-util`

## Important

- Do NOT push the branch to remote.
- Do NOT make any commits.
