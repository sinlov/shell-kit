
[![GitHub license](https://img.shields.io/github/license/sinlov/shell-kit)](https://github.com/sinlov/shell-kit)
[![GitHub latest SemVer tag)](https://img.shields.io/github/v/tag/sinlov/shell-kit)](https://github.com/sinlov/shell-kit/tags)
[![GitHub release)](https://img.shields.io/github/v/release/sinlov/shell-kit)](https://github.com/sinlov/shell-kit/releases)

## Contributing

[![Contributor Covenant](https://img.shields.io/badge/contributor%20covenant-v1.4-ff69b4.svg)](.github/CONTRIBUTING_DOC/CODE_OF_CONDUCT.md)
[![GitHub contributors](https://img.shields.io/github/contributors/sinlov/shell-kit)](https://github.com/sinlov/shell-kit/graphs/contributors)

We welcome community contributions to this project.

Please read [Contributor Guide](.github/CONTRIBUTING_DOC/CONTRIBUTING.md) for more information on how to get started.

请阅读有关 [贡献者指南](.github/CONTRIBUTING_DOC/zh-CN/CONTRIBUTING.md) 以获取更多如何入门的信息

# this project for shell kit

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
