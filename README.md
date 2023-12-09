# ARP Poisoning and MITM Detection Script

## Overview
This script is designed to detect ARP Poisoning, a technique used in Man-in-the-Middle (MITM) attacks. By continuously monitoring the ARP table for changes in the MAC address of the default gateway.

## Features
- **Real-time ARP Table Monitoring**: Continuously checks the ARP table for any changes in the MAC address of the default gateway.
- **Attack Detection Alert**: Notifies the user if a potential ARP Poisoning attack is detected.
- **Attacker Identification**: Scans the local network to identify the potential attacker's IP address.

### Make sure the default gateway MAC address is authentical before running the script

## When to Execute
- **While Penetration Testing**: Regularly run ARPMonitor in environments where network security is a priority.
- **In Public Networks**: Run ARPMonitor in public or untrusted networks, to detect potential MITM attacks.

## Usage: just run the script and check it regularly, script will stop once it detects a ARP Poisoning attack, however script can be modified to an infinite loop.

## Requirements
- A Unix-like operating system with Bash.
- Network utilities: `ip`, `arp`, `awk`.
