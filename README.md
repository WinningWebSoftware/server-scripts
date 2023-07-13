# Server Scripts

A collection of useful scripts to help ease server setup.

---

## Available scripts:

### - `init.sh`

```
wget -O https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/init.sh danny | bash -s <username>
``` 


Run this when first connecting to your server as the **root** user. This script:

- Runs `apt-get update`
- Creates a new sudo user with the provided username argument
- Copies the SSH key for your root user to your new users directory
- Enables the firewall and allows OpenSSH, allowing you to SSH to your server as your new user