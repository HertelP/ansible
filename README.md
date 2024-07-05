# 1. Install System
**ansible-playbook --ask-vault-pass local.yml**

# 2. Install remaining things
**yay -S zsh-pure-prompt-git eww swww**

# 2. Decrypt pass_keys
**ansible-vault decrypt ...**

# 3. Clone password store
**git clone git@github.com:HertelP/pass.git ~/.password-store**

# 3. Import password store keys
**gpg --import --pinentry-mode loopback private.pgp**

# 4. Set shell permission if not done already
**sudo chmod o+rw $(tty)**



# 5. clone dotfiles repo (already done usually)
**git clone git@github.com:HertelP/dotfiles.git ~/.dotfiles**

# 6. Stow files (remove already existing files if necessary)
**stow .**
