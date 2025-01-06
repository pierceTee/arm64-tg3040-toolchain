# Toolchain Docker image
A plug and play docker container for building/running arm64 applications that can run on the TrimUI Brick. 

Based on the [union-tg3040-toolchain](https://github.com/shauninman/union-tg3040-toolchain) by shauninman (which is based on the [Trimui toolchain Docker image](https://git.crowdedwood.com/trimui-toolchain/) by neonloop :p) .

## Installation
With Docker installed and running, `make shell` builds the toolchain and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default. The toolchain is located at `/opt/` inside the container.

After building the first time, unless a dependency of the image has changed, `make shell` will skip building and drop into the shell.

## Workflow

1. On your host machine, clone whatever project you're working on a directory named `/workspace` (or change the `$WORKSPACE_DIR` env variable to your desired path in the makefile) and make changes as usual.
2a. Executing `make shell` will place you into the container with your `$WORKSPACE_DIR` mounted to `/root/workspace`. 
2b. If your application requires a GUI, build the dockerfile and setup a simple bash script to connect your display to the container like below

```
#!/bin/sh
xhost +local:root
docker run -it --privileged \
    -e DISPLAY=$DISPLAY \
    -e XDG_RUNTIME_DIR=/tmp \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $XAUTHORITY:/root/.Xauthority:rw \
    -v <PATH_TO_PROJECT_ON_HOST>:/root/workspace \
    --device /dev/dri \
    arm64-tg3040-toolchain
xhost -local:root
```

3. Once inside the container, you can build and run your application as usual. 

See [setup-env.sh](./support/setup-env.sh) for some useful vars for compiling that are exported automatically.

## Docker for Mac

Docker for Mac has a memory limit that can make the toolchain build fail. Follow [these instructions](https://docs.docker.com/docker-for-mac/) to increase the memory limit.
