# QxD Layer L3 Workspace (`~/qxd-l3`)

## Context & Rules
- Project: QxD (QxD Node Grammar) Layer L3 state evaluation for `oeneyeOS`.
- Core grammar: Ternary phi-Trit values (`-`, `0`, `+`), `0;` fixpoint lock operator, and `S[...]S` state assertions (ignored when locked or invalid).
- Primary evaluator: `qxd_eval.py` (`TritState`, `eval_step`, `eval_qxd`, `run_file`, `--trace` CLI support).
- Sandbox tests: Keep test inputs in `sandbox/` (e.g., `sandbox/sample.qxd`) and leave core disk images such as `oeneyeOS.img` untouched.
- Never place third-party `@` handles on personal brand assets or files.
