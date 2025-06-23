# DevSecOps Kali workspace (Kasm image)

Immutable-Infrastructure-as-Code (IIaC) workspace image file for DevSecOps for OSINT development, based on the [Kasm workspace image for Core Kali Linux](https://hub.docker.com/r/kasmweb/core-kali-rolling).

## Requirements

1. A Bash terminal ([Ubuntu on WSL2](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#2-install-wsl) recommended for Windows users).
2. [Docker Compose](https://docs.docker.com/compose/install/) ([Docker Desktop](https://docs.docker.com/desktop/) recommended for non-Linux users)

## Setup/Installation

From a bash terminal,

1. Clone this repo

```bash
git clone https://github.com/alhacky/devsecops-kali-workspace.git
```

2. Change directory into `devsecops-kali-workspace`.

```bash
cd devsecops-kali-workspace
```

3. Pull the workspace image from DockerHub, using docker-compose (Note: Linux users may need to prepend this command with `sudo`):

```bash
docker-compose pull
```

## Using the image locally

Once pulled, the image can be run locally on port 6901 using docker-compose.

- **Starting the image locally:** Run `docker-compose up`
- **Stopping the image locally:** Use keyboard shortcut **Ctrl+C**

When running locally, the workspace can be accessed at https://localhost:6901 with
- **User:** `kasm_user`
- **Passwordd:** `password`
