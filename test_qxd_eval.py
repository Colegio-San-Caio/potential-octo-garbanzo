import unittest
from pathlib import Path
import tempfile
from qxd_eval import TritState, eval_step, eval_qxd, run_file

class TestQxdEval(unittest.TestCase):
    def test_trit_state_defaults(self):
        state = TritState()
        self.assertEqual(state.value, "0")
        self.assertFalse(state.locked)

    def test_eval_step_valid_assertions(self):
        state = TritState()
        for trit in ["-", "0", "+"]:
            nxt, note = eval_step(f"S[{trit}]S", state)
            self.assertEqual(nxt.value, trit)
            self.assertFalse(nxt.locked)

    def test_eval_step_invalid_assertion(self):
        state = TritState(value="+")
        nxt, note = eval_step("S[X]S", state)
        self.assertEqual(nxt.value, "+")
        self.assertIn("invalid trit", note)

    def test_eval_step_fixpoint_lock(self):
        state = TritState(value="-")
        nxt, note = eval_step("0;", state)
        self.assertEqual(nxt.value, "-")
        self.assertTrue(nxt.locked)
        self.assertIn("fixpoint lock", note)

    def test_eval_step_locked_behavior(self):
        state = TritState(value="+", locked=True)
        nxt, note = eval_step("S[-]S", state)
        self.assertEqual(nxt.value, "+")
        self.assertTrue(nxt.locked)
        self.assertIn("ignored: locked", note)

    def test_eval_qxd(self):
        state = TritState()
        nxt = eval_qxd("S[-]S", state)
        self.assertEqual(nxt.value, "-")

    def test_run_file(self):
        with tempfile.TemporaryDirectory() as tmpdir:
            p = Path(tmpdir) / "test.qxd"
            p.write_text("S[-]S\n0;\nS[+]S\n")
            final = run_file(p, trace=False)
            self.assertEqual(final.value, "-")
            self.assertTrue(final.locked)

if __name__ == "__main__":
    unittest.main()
