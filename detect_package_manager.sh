#!/bin/bash
# Outputs the first available package manager on stdout.

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

package_managers=("apt" "yum" "brew" "dnf" "zypper" "pacman" "emerge" "apk")

for pm in "${package_managers[@]}"; do
    if command_exists "$pm"; then
        echo $pm
        exit 0
    fi
done

echo "No known package managers detected." >&2
exit 1
