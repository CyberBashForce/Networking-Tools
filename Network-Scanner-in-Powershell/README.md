# Network-Scanner-in-Powershell
Simple Powershell script to scan the network ports available on a target netowrk!

# Port-Scan.ps1

## Overview
This PowerShell script, `Port-Scan.ps1`, allows you to perform port scanning on a target IP address within a specified port range. It identifies open ports and attempts to determine their associated services using common port/service mappings.

## Prerequisites
- PowerShell installed on your system
- Access to the PowerShell command line interface

## Usage
To use the script, follow these steps:

1. **Clone the Repository**
    ```bash
    git clone https://github.com/Subas4/NetworkToolsPowerShell.git
    cd NetworkToolsPowerShell\Network-Scanner-in-Powershell
    ```

2. **Run the Script**
    ```bash
    ./Port-Scan.ps1 -target <TARGET_IP> -startPort <START_PORT> -endPort <END_PORT> -time <TIME_DELAY> -fast <BOOLEAN_VALUE>
    ```

    Replace `<TARGET_IP>` with the IP address you want to scan.
    - `<START_PORT>` and `<END_PORT>` define the range of ports to scan.
    - `<TIME_DELAY>` specifies the timeout duration for each port connection attempt.
    - `<BOOLEAN_VALUE>` indicates whether to perform a fast scan (`1` for fast, `0` for normal).

3. **Example**
    ```bash
    ./Port-Scan.ps1 -target 127.0.0.1 -startPort 1 -endPort 1024 -time 3 -fast 1
    ```

## Parameters
- `-target`: Specifies the target IP address. Default: `127.0.0.1` if not provided.
- `-startPort`: Defines the starting port for the scan range. Default: `1` if not provided.
- `-endPort`: Sets the ending port for the scan range. Default: `1024` if not provided.
- `-time`: Specifies the time delay (in seconds) for each port connection attempt. Default: `1` if not provided.
- `-fast`: When set to `1`, performs a fast scan using common ports. When `0`, scans through the specified port range.

## Help
To view the usage and help statement, execute the script with `-h` or without any parameters.
```bash
./Port-Scan.ps1 -h
```
Features
Customizable Scanning: Define target IP, port range, timeout, and scan speed.
Default Values: If parameters are not provided, default values are used.
Identifies Services: Attempts to identify services associated with open ports based on common port/service mappings.
Fast Scan Option: Conducts a quick scan using well-known ports for faster results.
Contributing
Contributions, issues, and feature requests are welcome! Feel free to create pull requests or report any bugs.


Feel free to adjust the GitHub repository URL, installation instructions, or any additional details to match your specific repository setup and preferences.

