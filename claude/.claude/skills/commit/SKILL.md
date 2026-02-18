---
name: commit
description: Create a git commit describing the staged changes
user-invocable: true
disable-model-invocation: true
allowed-tools: "Bash(git *)"
argument-hint: "[optional context]"
---

Create a git commit for the currently staged changes.

## Steps

1. Run `git diff --cached` to see what is staged. If nothing is staged, tell the user and stop.
2. Run `git log --oneline -5` to see recent commit message style.
3. Draft a concise commit message that:
   - Summarizes the nature of the change (e.g. add, update, fix, refactor, remove)
   - Focuses on **why** over **what**
   - Matches the style of recent commits in this repo
   - If `$ARGUMENTS` is provided, use it as additional context for the message
4. Show the proposed message to the user and ask for approval.
5. Create the commit. Use a HEREDOC to pass the message:

```
git commit -m "$(cat <<'EOF'
<message>

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"
```

## Rules

- NEVER amend an existing commit unless the user explicitly says to
- NEVER use `--no-verify`
- NEVER stage additional files - only commit what is already staged
- Do NOT commit files that look like secrets (`.env`, credentials, etc.) - warn the user instead
- Keep the first line under 72 characters
