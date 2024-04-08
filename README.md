## Bash Script for Automated Environment Setup

This bash script automates the setup of a web development environment suitable for PHP and Laravel applications. It updates the system, installs necessary base packages, and configures PHP along with essential PHP extensions. It also ensures that Apache2, Composer, Node.js, and MariaDB are installed and configured properly. If certain components (like Nginx or MySQL) are already installed, the script intelligently skips redundant installation steps.

### What Does the Script Do?

1. **Update and Upgrade System**: Ensures the system's package list and installed packages are updated.
2. **Install Base Packages**: Installs essential packages like `unzip`, `curl`, and `software-properties-common`.
3. **Add PHP Repository**: Adds the `ondrej/php` PPA repository to the system for installing PHP.
4. **Install PHP 8.2**: Installs PHP 8.2 and necessary extensions required for Laravel.
5. **Check and Install Apache2**: If Nginx is not installed, it installs Apache2.
6. **Install Composer**: Checks if Composer is installed, if not, installs it.
7. **Install Node.js and NPM**: Adds Node.js repository and installs Node.js along with NPM.
8. **Install and Secure MariaDB**: Installs MariaDB if not present and performs basic security steps equivalent to `mysql_secure_installation`.
9. **MySQL/MariaDB User Setup**: Prompts the user to create a new MySQL/MariaDB user with full privileges.

### Prerequisites

- A Debian-based Linux distribution (e.g., Ubuntu).
- `sudo` privileges for the executing user.

### How to Use

1. Download the script.
2. Make it executable: `chmod +x setup.sh`
3. Run the script: `./setup.sh`
4. Follow the on-screen prompts to configure the MySQL/MariaDB user.

or you can install it by run the command on terminal :
curl -sSL https://raw.githubusercontent.com/bayuapriansah/script-to-set-up-laravel-environtment-on-ubuntu-22.04/main/setup.sh | sudo bash

### License

This script is available under the [MIT License](https://opensource.org/licenses/MIT), which allows free use, modification, and distribution.
