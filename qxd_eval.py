#!/usr/bin/env python3
from dataclasses import dataclass
from pathlib import Path
import sys

VALID_TRITS = {"-", "0", "+"}

@dataclass
class TritState:
    value: str = "0"   # "-" | "0" | "+" (phi-Trit)
    locked: bool = False

def eval_step(expr: str, state: TritState) -> tuple[TritState, str]:
    tok = expr.strip()
    if tok == "0;":
        nxt = TritState(value=state.value, locked=True)
        return nxt, f"{tok:8} -> {nxt} (fixpoint lock)"
    if tok.startswith("S[") and tok.endswith("]S"):
        inner = tok[2:-2].strip()
        if inner not in VALID_TRITS:
            return state, f"{tok:8} -> {state} (ignored: invalid trit '{inner}')"
        if state.locked:
            return state, f"{tok:8} -> {state} (ignored: locked)"
        nxt = TritState(value=inner, locked=False)
        return nxt, f"{tok:8} -> {nxt} (asserted)"
    return state, f"{tok:8} -> {state} (ignored: unknown token)"

def eval_qxd(expr: str, state: TritState) -> TritState:
    nxt, _ = eval_step(expr, state)
    return nxt

def run_file(path: Path, trace: bool = False, initial: TritState | None = None) -> TritState:
    cur = initial if initial is not None else TritState()
    if trace:
        print(f"START    -> {cur}")
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        cur, note = eval_step(line, cur)
        if trace:
            print(note)
    return cur

if __name__ == "__main__":
    args = sys.argv[1:]
    trace = "--trace" in args
    files = [Path(a) for a in args if a != "--trace"]
    target = files[0] if files else Path("sandbox/sample.qxd")
    final = run_file(target, trace=trace)
    print("FINAL:", final)
