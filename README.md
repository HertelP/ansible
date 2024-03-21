# 1. Install System
**ansible-playbook --ask-vault-pass local.yml**

# 2. Decrypt pass_keys
**ansible-vault decrypt ...**

# 3. Clone password store
**git clone git@github.com:HertelP/pass.git ~/.password-store**

# 3. Import password store keys
**gpg --import --pinentry-mode loopback private.pgp**
