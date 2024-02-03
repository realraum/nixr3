# how to hass vm
`incus init --vm --empty hass`
`incus config edit hass`

ergänzen:
```
config:
  security.secureboot: "false"
devices:
  eth0:
    name: eth0
    nictype: macvlan
    parent: enp1s0
    type: nic
  root:
    path: /
    pool: default
    size: 64GB
    type: disk
```

`curl -O https://github.com/home-assistant/operating-system/releases/download/11.4/haos_ova-11.4.qcow2.xz -L`
`xz -d haos_ova-11.4.qcow2.xz`

`lsblk` # die zd devices beachten
`zfs set volmode=dev zroot/lxd/virtual-machines/hass.block`
`lsblk` # neues zd device kommt hinzu

`qemu-img convert haos_ova-11.4.qcow2 /dev/zdXX` # hier XX ersetzen mit neuem zd

`incus start hass`

`watch incus ls` # bekommt irgendwann ip

