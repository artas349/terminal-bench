#!/bin/bash
set -e

# Navigate to the directory containing the script
cd "$(dirname "$0")"

echo ">> Running unit tests from: $(pwd)"

# Run the test script
python3 test_outputs.py
