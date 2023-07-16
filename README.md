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
curl https://raw.githubusercontent.com/WinningWebSoftware/server-scripts/main/install-jenkins.sh | bash -s -- <domainName> <emailAddress>
```

Primary aim as the name suggests is to install Jenkins. Before running this script make sure that your domain name is pointed to 
your server and has fully propagated, or you may encounter errors attempting to install your SSL certificate. This script:

- Installs the Java Runtime Environment and Java Dev Kit
- Installs Jenkins
- Installs Nginx
- Sets up a reverse proxy and installs an SSL certificate for your domain
- When done, displays your admin password and a link to your Jenkins setup