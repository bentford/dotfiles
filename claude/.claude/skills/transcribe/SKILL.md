---
name: transcribe
description: Transcribe a YouTube video and summarize into structured markdown notes
argument-hint: "<youtube-url> <output-directory>"
user-invocable: true
allowed-tools: Bash, Read, Write, Glob
---

Transcribe a YouTube video and produce structured markdown notes.

## Steps

1. **Parse arguments** — extract the YouTube URL and output directory from `$ARGUMENTS`. Both are required. If either is missing, tell the user the usage: `/transcribe <youtube-url> <output-directory>` and stop.

2. **Extract video ID** from the URL. Handle these formats:
   - `youtube.com/watch?v=VIDEO_ID`
   - `youtu.be/VIDEO_ID`
   - `youtube.com/embed/VIDEO_ID`
   - `youtube.com/v/VIDEO_ID`
   - Bare video ID (11 characters, alphanumeric + `-_`)

3. **Check `youtube_transcript_api` CLI is available**:
   ```
   which youtube_transcript_api 2>/dev/null || pipx install youtube-transcript-api
   ```

4. **Fetch video title** using Python:
   ```
   python3 -c "
   import json, urllib.request, re
   url = 'https://www.youtube.com/watch?v=VIDEO_ID'
   req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0', 'Accept-Language': 'en-US,en;q=0.9'})
   html = urllib.request.urlopen(req).read().decode()
   match = re.search(r'<title>(.*?)(?:\s*-\s*YouTube)?</title>', html)
   print(match.group(1).strip() if match else 'Untitled')
   "
   ```

5. **Fetch transcript** using the CLI:
   ```
   youtube_transcript_api VIDEO_ID --format json
   ```
   If that fails (no transcript available), tell the user and stop.

6. **Generate kebab-case filename** from the video title:
   - Lowercase, replace spaces/special chars with hyphens
   - Remove consecutive hyphens, trim leading/trailing hyphens
   - Append `.md`

7. **Ensure the output directory exists** — create it with `mkdir -p` if needed.

8. **Summarize and format** — read the full transcript text and produce structured markdown notes. Follow this format:

   ```markdown
   # <Video Title>

   Source: <youtube-url>

   ## Overview

   <1-2 paragraph summary of the video's main thesis/content>

   ## <Topic Section>

   - **Key point**: explanation
   - **Key point**: explanation

   ## <Another Section>

   ...additional sections as appropriate...
   ```

   Guidelines for the summary:
   - Use `# Title` from the video title
   - Include `Source: <youtube-url>` right after the title
   - Write a concise **Overview** section summarizing the video's core message
   - Organize content into logical **H2 sections** based on topics covered
   - Use **bullet lists** for key principles, tips, and takeaways
   - Use **tables** where structured/comparative data makes sense (timelines, comparisons, specs)
   - **Bold** key terms and important concepts
   - Keep it practical and actionable — focus on what's useful to reference later
   - Don't include filler, repetition, or tangential asides from the video
   - Match the style of notes in the project (concise, scannable, reference-friendly)

9. **Write the file** to `<output-directory>/<kebab-case-title>.md` using the Write tool.

10. **Confirm** by telling the user:
    - The output file path
    - A one-line summary of what the video covered

## Rules

- NEVER write a file without first successfully fetching the transcript
- If the transcript fetch fails, report the error clearly and stop
- Keep the markdown clean — no raw transcript dumps, only structured summaries
- The summary should be comprehensive but concise — aim for the key points someone would want to reference later
