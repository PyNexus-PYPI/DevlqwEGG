#!/bin/bash

# List of known cryptocurrency mining processes
MINING_PROCESSES=("xmrig" "cpuminer" "ccminer" "minerd" "cryptonight" "bfgminer" "cgminer")

# Function to check for mining processes
check_for_miners() {
    for miner in "${MINING_PROCESSES[@]}"; do
        # Check if any mining process is running
        if pgrep -x "$miner" > /dev/null; then
            echo "[WARNING] Cryptocurrency miner detected: $miner"
            echo "[ACTION] Initiating VPS shutdown."
            shutdown -h now  # Immediately shut down the system
            exit 1
        fi
    done
}

# Continuously monitor for mining processes
while true; do
    check_for_miners
    sleep 10   # Check every 10 seconds, adjust as needed
done
