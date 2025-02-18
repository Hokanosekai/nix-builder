# Ganix ISO

> Build custom ISO images for Nix using github actions

## Goals

Easy to create, custom ISO images for [NixOS](https://nixos.org/).

The idea is to create an ISO image with my presets.

## Usage

1. Fork this repo
2. Go to the github actions section
3. Click on "Build ISO"
4. Trigger the workflow with the inputs you want to customize
5. Wait
6. Download the ISO
7. Flash it

When you fork the repo, you can custommize the `ganix.nix` file, and you won't need to provide
the env variables for the github action

## Development

### Check all is good

```sh
nix flake check --impure
```

### Build

Supported arch `aarch64-linux`

```sh
nix build
```

### Burning image to SD-card

Plug sd-card.

Find out USB's location.

| Mac             | Linux      |
| --------------- | ---------- |
| `diskutil list` | `lsblk -l` |

(output e.g: `/dev/disk2`)

Check that the SD is unmounted

| Mac                                    | Linux                   |
| -------------------------------------- | ----------------------- |
| `sudo diskutil unmountDisk /dev/disk2` | `sudo umount /dev/sda2` |

Burn the `.img` to the sd-card


```sh
sudo dd if=result/nixos-sd-image-23.05.20230326.0cd51a9-aarch64-linux.img of=/dev/disk2 bs=1m status=progress
```

Remember to download the img and unzip it from the github action.

Good luck!

## What services can you configure?

Take a look at [nixos configuration](https://nixos.org/manual/nixos/stable/index.html#ch-configuration).