vVulnerability Proof of Concept README

This README describes how to run the Proof of Concept (PoC) scripts for each vulnerability discovered in the password management system. Each section includes setup instructions, how to run the PoC, and a brief description of the attack.

Vulnerability 1: Command Injection via JSON Parsing (Old)
Description

This vulnerability leverages command injection in the parse_json_file() function. The JSON rule file can include malicious input in the rules field, which is directly incorporated into the system’s command execution, allowing the attacker to run arbitrary commands.
Steps to Run

    Ensure the vul_1.sh script and the JSON file it references are in the same directory as the main application.

    Run the following command to execute the PoC:

    bash

    bash vul_1.sh

Expected Outcome

The PoC will attempt to inject a harmless echo command to demonstrate successful injection. Upon execution, you should see a message like Command executed via injection, confirming the injection.
Justification

This attack shows that malicious commands can be executed within the system context, allowing unauthorized actions and potentially compromising system integrity.

Vulnerability 2: Command Injection via Unsafe grep Command in gen_password() (old)
Description

In the gen_password() function, regex patterns from the JSON file are used directly in a grep command. This PoC demonstrates command injection through unvalidated regex input, allowing execution of additional commands.
Steps to Run

    Ensure vul_2.sh is available in the same directory as the application.

    Run the following command:

    bash

    bash vul_2.sh

Expected Outcome

The PoC script will run echo "Command executed via injection" as a result of the command injection vulnerability. Seeing this output confirms the injection was successful.
Justification

This demonstrates the risk of executing unvalidated regex patterns as system commands, highlighting potential unauthorized command execution and system control by an attacker.

Vulnerability 3: Buffer Overflow in JSON Rule File Processing (old)
Description

This vulnerability arises in parse_json_file() due to the unvalidated length of JSON fields like site. By supplying an overly large site value, this PoC demonstrates a buffer overflow, which may corrupt adjacent memory or crash the application.
Steps to Run

    Place vul_3.sh and its associated JSON file in the application directory.

    Run the following command:

    bash

    bash vul_3.sh

Expected Outcome

The PoC script will attempt to overflow the buffer. If successful, it may cause a segmentation fault or produce unexpected output, indicating memory corruption.
Justification

The attack shows how unvalidated JSON data length could lead to crashes or data corruption, potentially destabilizing the application and impacting system reliability.

## Vulnerability 4: Command Injection via Unsanitized Inputs in `callSQL()` and `callSiteSQL()` (old)

### Description

The `callSQL()` and `callSiteSQL()` functions in `regdb.cpp` construct and execute shell commands using the `system()` function with user-supplied inputs. These inputs are directly embedded into command strings without sufficient sanitization or validation, making the system susceptible to **Command Injection** attacks. Attackers can inject arbitrary shell commands by manipulating parameters such as `hexmail`, `hexpass`, or `site`.

### Steps to Run

1. **Ensure Authorization:**
   - **Only** execute this script in an environment where you have explicit permission to perform security testing.

2. **Place the Script:**
   - Save the `callSQL_poc.sh` script in the same directory as your main application.

3. **Make the Script Executable:**
   ```bash
   chmod +x vul_4.sh

    Execute the Script:

    ./vul_4.sh

Expected Outcome

The PoC will attempt to inject a command that creates a file and echoes a confirmation message. Upon execution, you should see a message like:

Command Injection successful: 'InjectionSuccess' message found.

Additionally, a file named /tmp/injection_test.txt should be created on the server, indicating that the injected command was executed.
Justification

This attack demonstrates that malicious commands can be executed within the system context, allowing unauthorized actions and potentially compromising system integrity. Creating files or echoing messages serves as a clear indicator of successful command injection.



Vulnerability 5: Path Traversal Attack via JSON Rule File (the only new one)

Description
This vulnerability leverages the site field in the JSON rule file, allowing an attacker to perform a path traversal attack. The attacker can use traversal sequences such as ../../ to write or overwrite files outside the intended directory. This PoC specifically writes a confirmation message to /tmp/attack_successful to demonstrate the vulnerability.

Steps to Run
Ensure the vul_5.sh script is in the same directory as the main application.
Run the following command:
bash vul_5.sh
Expected Outcome
The PoC will create a file at /tmp/attack_successful with an indicator message confirming the attack. If the attack is successful, you will see the following output:

[!] Path traversal attack successful: Vulnerability confirmed.
Justification
This attack demonstrates the risks of unvalidated file paths in the site field. An attacker can overwrite or create unauthorized files, potentially compromising the system or disrupting its integrity. Proper input validation is required to mitigate this risk.





For all PoC scripts:

    Ensure that each script and the relevant JSON rule file are located in the same directory as the main application.
    Run each script individually to confirm the vulnerability.

Each vulnerability demonstrates a significant security risk, either by allowing unauthorized command execution, accessing restricted files, or corrupting memory, which justifies the need for input validation and secure command handling within the application.
