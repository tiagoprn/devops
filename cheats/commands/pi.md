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
