Network Interface Scanner
This is a Bash script that scans all network interfaces on a Linux machine and provides the following network details in a readable format:

IP address
Interface name
Interface MAC address
Default gateway IP address
DNS server addresses
IP configuration type (static or DHCP)
Prerequisites
This script requires the following utilities to be installed on the system:

ip or netstat: Used to retrieve the default gateway IP address
awk: Used for string manipulation
cut: Used to extract substrings from strings
grep: Used for pattern matching
cat: Used to read files

Usage
To run the script, simply execute it in a terminal as follows:

./network_interface_scanner.sh
The script will output the network details for each network interface on the machine.

Supported Distributions
This script should work on most Debian-based, Arch-based, and Red Hat-based distributions. However, please note that there may be some distributions or versions where the network interface configuration files or commands are different, so you may need to modify the script accordingly for your specific system.

License
This script is released under the MIT License.



