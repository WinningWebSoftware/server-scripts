# Server Scripts

A collection of useful scripts to help ease server setup.

---

## Available scripts:

### - `init.sh`

```
curl https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/init.sh | bash -s -- <username>
``` 

Run this when first connecting to your server as the **root** user. This script:

- Runs `apt-get update`
- Creates a new sudo user with the provided username argument
- Copies the SSH key for your root user to your new users directory
- Enables the firewall and allows OpenSSH, allowing you to SSH to your server as your new user

### - `install-jenkins.sh`

```
curl https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/install-jenkins.sh | bash
```

Primary aim as the name suggests is to install Jenkins. This script:

- Installs the Java Runtime Environment and Java Dev Kit
- Installs Jenkins
- Opens port 8080 so you can connect to &lt;your domain or ip&gt;:8080
- Displays your admin password so you don't need to go looking for it