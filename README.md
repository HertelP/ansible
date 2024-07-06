# 1. Install System
**ansible-playbook --ask-vault-pass local.yml**

# 2. Install remaining things
**yay -S zsh-pure-prompt-git eww swww**

# 3. Decrypt pass_keys
**ansible-vault decrypt ...**

# 4. Clone password store
**git clone git@github.com:HertelP/pass.git ~/.password-store**

# 5. Import password store keys
**gpg --import --pinentry-mode loopback private.pgp**

# 6. Set shell permission if not done already
**sudo chmod o+rw $(tty)**

# 7. Install tmux plugins
**Leader + I in Tmux**



# 8. clone dotfiles repo (already done usually)
**git clone git@github.com:HertelP/dotfiles.git ~/.dotfiles**

# 9. Stow files (remove already existing files if necessary)
**stow .**
