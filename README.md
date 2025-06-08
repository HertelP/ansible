# 1. Install System
**ansible-playbook --ask-vault-pass local.yml**

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

# 10. Edit trust for gpg keys
**gpg --edit-key philipph_95@icloud.com**

