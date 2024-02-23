#!/bin/bash

# System Update Script

This Bash script automates the process of updating various system packages and software on macOS. It checks for updates to Homebrew packages, macOS system software, Ruby gems, npm packages, Python packages, and Go packages, and performs the necessary updates.

## Features

- Automatically installs missing dependencies (jq, npm).
- Updates Homebrew and system packages.
- Updates Ruby gems.
- Updates npm and global packages.
- Updates pip and Python packages.
- Checks and updates Go packages.
- Displays current package versions.
- Performs cleanup tasks to optimize disk space.

## Usage

1. Ensure that you have permission to execute the script. You can set execute permissions using the command:

    ```bash
    chmod +x sys-update.sh
    ```

2. Execute the script using the following command:

    ```bash
    ./sys-update.sh
    ```

3. Follow the on-screen prompts to confirm installations and updates.

## Note

- This script is designed for use on macOS systems.
- Ensure that you have Homebrew installed before running the script.
- Some update operations may require administrative privileges and will prompt for password input.

## Disclaimer

This script automates system updates and package installations, but it is provided without any warranty. Use it at your own risk.

---

If you encounter any issues or have suggestions for improvements, feel free to submit an issue or pull request on [GitHub](https://github.com/dvblu/sys-update).

