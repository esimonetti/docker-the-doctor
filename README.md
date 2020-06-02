# docker-the-doctor
Docker wrapper for The Doctor https://github.com/CloudElementsOpenLabs/the-doctor

## Disclaimer
This tool has been built to help me get up and running with The Doctor tool. It has been shared to help others as well in the process. Use at your own risk :)

## Requirements
* Docker
* Built on OSX's bash, it should work just fine on Linux as well

## Installation
* `git clone <repo> <dir>`
* `cd <dir>`
* `./doctor.sh "accounts list"` and then follow the prompts to complete the setup

## Other notes
The tool will create two directories within the repo clone:
* `./workdir`
* `./homedir`

### workdir
`./workdir` contains the installed node module(s) and all the exports you might choose to export there as well, so that you can get them locally. The `./workdir` is supposed to be your export/import directory of choice to bridge your local environment with the node container. Inside the container the directory can be found on `/workdir`

### homedir
`./homedir` contains the api secrets within `./homedir/.doctor/`

## Cleanup
If you wish to wipe your images, containers and node modules, execute the `./cleanup.sh` command. You can then delete the cloned repo and more importantly the `homedir` directory within it as it contains your api secrets
