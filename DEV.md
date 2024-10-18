# incus local containers

launch container:

```bash
incus launch images:nixos/unstable r3CONTAINER -c security.privileged=true -c security.nesting=true
```

open shell inside container: 

```bash
incus exec r3CONTAINER bash
```

# deploy from local repo

## setup

add keys:

container:

```bash
nix run --extra-experimental-features 'nix-command flakes' nixpkgs#ssh-import-id gh:YOURGHUSERNAME # add your github key for ssh
ip a # get ip
```

## use

local:

```bash
nixos-rebuild --flake .#PFAD --target-host root@<ip> switch -L -v
```

# deploy from inside container

## setup

local:

```bash
incus config device add r3website nixr3 disk path=/etc/nixos source=$PWD
```

container:

```bash
nix run --extra-experimental-features 'nix-command flakes' shell nixpkgs#git
git config --global --add safe.directory /etc/nixos
git config --global --add safe.directory /etc/nixos/.git
```

## use

```bash
nixos-rebuild swtich --flake /etc/nixos#TYPE
```
