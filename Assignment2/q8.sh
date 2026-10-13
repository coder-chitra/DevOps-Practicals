
#!/bin/bash

echo "Updating package lists..."
if ! sudo apt-get update; then
    echo "Package list update failed!"
    exit 1
fi

echo "Upgrading installed packages..."
if ! sudo apt-get upgrade -y; then
    echo "Package upgrade failed!"
    exit 1
fi

echo "Removing unnecessary packages..."
if ! sudo apt-get autoremove -y; then
    echo "Package removal failed!"
    exit 1
fi

echo "Cleaning package cache..."
if ! sudo apt-get clean; then
    echo "Cache cleanup failed!"
    exit 1
fi

echo "System packages updated and cleaned up."
