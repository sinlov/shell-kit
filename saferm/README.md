## saferm

SafeRM is a custom shell script that provides an extra layer of protection when using the rm -rf command. It prompts the user for confirmation before deleting files and directories, helping to prevent accidental data loss.

Supported Scenarios

- rm -rf /
- rm -rf /*
- rm -rf * (root directory)
- rm -rf ./* (root directory)
- rm -rf /bin
- Other root directory scenarios, and so on.

use this shell `saferm-install.sh` to install (if need sudo just run `sudo bash saferm-install.sh`)

```shell
install_url=https://raw.githubusercontent.com/sinlov/shell-kit/main/saferm/saferm.sh
echo "-> install saferm by url: ${install_url}"
curl -o /usr/local/bin/saferm "${install_url}" && \
 chmod +x /usr/local/bin/saferm
echo "-> install saferm at /usr/local/bin/saferm"

now_shell=$(basename $SHELL)

if [[ "${now_shell}" -eq "zsh" ]]; then
echo "-> add config at /etc/zsh/zprofile"
cat >> /etc/zsh/zprofile << EOF

# safe rm kit
alias rm='/usr/local/bin/saferm'
EOF
else
echo "-> add config at /etc/profile"
cat >> /etc/profile << EOF

# safe rm kit
alias rm='/usr/local/bin/saferm'
EOF
fi
```

```bash
## for bash
sudo curl -o /usr/local/bin/saferm https://raw.githubusercontent.com/sinlov/shell-kit/main/saferm/saferm.sh && \
 sudo chmod +x /usr/local/bin/saferm && \
 echo "\n\n# safe rm kit\nalias rm='/usr/local/bin/saferm'" >> ~/.bashrc && \
 source ~/.bashrc

## for zsh
sudo curl -o /usr/local/bin/saferm https://raw.githubusercontent.com/sinlov/shell-kit/main/saferm/saferm.sh && \
 sudo chmod +x /usr/local/bin/saferm && \
 echo "\n\n# safe rm kit\nalias rm='/usr/local/bin/saferm'" >> ~/.zshrc && \
 source ~/.zshrc
```

- bash add to  `/etc/profile`
- zsh aad to `/etc/zsh/zprofile` [zsh Startup/Shutdown Files](https://zsh.sourceforge.io/Doc/Release/Files.html#Files)

```shell
# safe rm kit
alias rm='/usr/local/bin/saferm'
```