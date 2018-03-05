
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
gpgconf --launch gpg-agent

# Set GPG TTY
export GPG_TTY=$(tty)

export NAMECHEAP_CLIENT_IP_ADDRESS=72.142.16.190

# see: http://blog.yolo.pro/setting-up-a-gnupg-card-for-ssh-authentication-on-mac-os-x/
# and: http://florin.myip.org/blog/easy-multifactor-authentication-ssh-using-yubikey-neo-tokens
# and: https://www.isi.edu/~calvin/yubikeyssh.htm#load-pgp-keys-onto-yubikey

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ngrok="/Users/julienroger/Development/tools/ngrok"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/julienroger/Development/cordova-electron-test/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/julienroger/Development/cordova-electron-test/node_modules/tabtab/.completions/electron-forge.zsh