
# Example workflow (inspired by <https://boristane.com/blog/how-i-use-claude-code/>)

## 1. Trigger research
**/research** the notification system

## 2. Review research.md in Neovim, then plan
**/plan** add cursor-based pagination to the list endpoint

## 3. Open plan.md in Neovim, add inline notes, then:

(add my notes as `> NOTE:`, so that pi can differ between its notes and mine)

**/annotate**

## 4. Repeat /annotate until satisfied, then
**/implement**

---

# Mental Model

| Phase     | My role         | Pi agent's role        | Output artifact          |
| --------- | --------------- | -------------------    | ------------------------ |
| Research  | Review & verify | Deep reading           | research.md              |
| Plan      | Architect       | Proposal writer        | plan.md                  |
| Annotate  | Domain expert   | Plan refiner           | Updated plan.md          |
| Implement | Supervisor      | Mechanical executor    | Code + checked todo list |

---

# Notes about this workflow

- Pi stores session history as a JSONL file at ~/.pi/agent/sessions/<encoded-cwd>/session.jsonl. When context compaction occurs, the model's working memory is reset, but the files on disk are not.
  So, `plan.md` and `research.md` are not just planning artifacts — they are my context recovery mechanism.

