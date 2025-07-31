import unittest
import json
from pathlib import Path
import xmlrunner

class TestCyberlogRecovery(unittest.TestCase):
    def test_output_json_validity(self):
        # Get path to current test_outputs.py file's parent dir (tests/)
        base = Path(__file__).resolve().parent
        # Point to task directory directly
        task_dir = base / ".." / "tasks" / "recover-incomplete-cyberlog-trace"
        output_path = task_dir / "output.json"
        expected_path = task_dir / "expected_output.json"

        self.assertTrue(output_path.exists(), "❌ output.json not found")
        self.assertTrue(expected_path.exists(), "❌ expected_output.json not found")

        with open(output_path) as f:
            student = json.load(f)

        with open(expected_path) as f:
            expected = json.load(f)

        matched = sum(1 for x, y in zip(student, expected) if x == y)
        self.assertGreaterEqual(
            matched,
            int(0.8 * len(expected)),
            f"❌ Only {matched} out of {len(expected)} matched. Minimum required: {int(0.8 * len(expected))}"
        )

if __name__ == '__main__':
    unittest.main(
        testRunner=xmlrunner.XMLTestRunner(output="/tmp"),
        verbosity=2
    )
