#!/bin/bash
# Outputs the first available package manager on stdout.

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if the script is running on a Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "brew"
    exit 0
fi

package_managers=("apt" "yum" "dnf" "zypper" "pacman" "emerge" "apk")

for pm in "${package_managers[@]}"; do
    if command_exists "$pm"; then
        echo $pm
        exit 0
    fi
done

echo "No known package managers detected." >&2
exit 1
