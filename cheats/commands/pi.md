## CODING WORFLOW

- `/codeflow [path]` — Start a new session (no path) or resume an existing one (inform path of the artifact file from `pi-session` repo)
- `/briefing`, `/research`, `/plan`, `/code` — Navigate between phases
- `/status` — Show current phase and artifact info
- `/cancel` — Cancel the current session

More details here: </storage/src/aikt/pi/agent/extensions/codeflow/README.md>

## SCOPED MODELS

- choose a set of models to switch to with `<C-p>`: `/scoped-models`
    - save the list to the settings file: `<C-s>`

- cycle through scoped models: `<C-p>`

- token usage: `/tokens`

## WHEN & HOW TO USE `/tree` AND `/fork`:

- Keep a *clean mainline branch for decision and implementation*.
- Send all noisy *exploration into side branches with `/tree`*.
- Persist *outcomes to files*, not just chat text.
- Use *branch summarization when leaving heavy branches*.
- Use `/fork` once a *branch becomes a separate long-running mission*, or when you need to *diverge into a completely different topic* or one that *diverges at least partially* from the current one.
- Use `git` for *code rollback*: `/tree` **DOES NOT handle files**.

## How /tree works

`/tree` navigates a conversation's branching history, letting you jump to an earlier iteration (e.g. iteration 5, while currently at 56) and start a new branch from there.

When branching away from later turns, Pi offers to summarize the abandoned range (e.g. iterations 6–56): skip summarizing and discard it entirely, use the default summary, or provide custom instructions (e.g. "keep only the final database schema and the auth.py bug fix") to control exactly what gets preserved.

The chosen summary — a short condensed note — replaces the raw messages, tool calls, and tool outputs from that branch, and gets attached at the branch point (iteration 5).

Subsequent requests then send only iterations 1–5 plus this compact summary, not the full raw history, reducing tokens sent per request while the original abandoned branch remains intact in the session file for later retrieval.


## ETC

- <shit+tab>: change the thinking level of a model

- run bash commands inside pi: `! <command>`

- `pi-insights` extension commands:
    > NOTE: the html/md files are located at <aikt/pi/agent/usage-data>
    - normal run...........................: `/pi-insights`
    - forces re-extraction of all facets...: `/pi-insights --refresh`
    - only analyze the last 7 days.........: `/pi-insights --since 7d`
    - export as markdown...................: `/pi-insights --md`
