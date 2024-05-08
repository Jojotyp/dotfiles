# List of my repositories to git clone
for more information see
```https://docs.github.com/en/authentication```

## SSH
To git clone the repos through SSH, add a public key to GitHub/GitLab in the settings.

possible key pairs (private + public)
- id_rsa + id_rsa.pub
- id_ecdsa + id_ecdsa.pub
- id_ed25519 + id_ed25519.pub

check for existing keys on your system (in default ~/.ssh folder)
```ls -al ~/.ssh```

### create a key pair
ed25519 algorithm
```ssh-keygen -t ed25519 -C "fabi.tost@outlook.de"```

rsa algorithm
```ssh-keygen -t rsa -b 4096 -C "fabi.tost@outlook.de"```

enter password if wanted

### Repositories
#### Base
.dotfiles
```git clone git@github.com:Jojotyp/.dotfiles.git```

hints
```git clone git@github.com:Jojotyp/hints.git ~/Programming```

scripts
```git clone git@github.com:Jojotyp/scripts.git ~/Programming```

python-utils
```git clone git@github.com:Jojotyp/python-utils.git ~/Programming/own_packages```

#### Projects
mtg-lich
```git clone git@github.com:Jojotyp/mtg-lich.git ~/Programming/Projects/private```
