# Docker image for exercise linux command

Container image based on **[rockylinux/rockylinux:9.5](https://hub.docker.com/layers/rockylinux/rockylinux/9.5/images/sha256-767f30c94a9a43e46719408f877fb4eb91cea98401dd76a23abfc345ae5cb4ad)**

Exercise codes are from **[O'REILLY](https://resources.oreilly.com/examples/0636920601098.git)** and **[gilbut IT book](https://github.com/gilbutITbook/080342.git)**

Docker file source [Github](https://github.com/c4fiber/linux-cli-prac/blob/master/Dockerfile)

# how can I use it?

## account info

default account is `myuser`:`password`

you can change password by `$ echo "myuser:new_password" | chpasswd`

## run container and connect again

you can change container name (default name is "lets-practice-linux-command")

```bash
docker pull hayanbada/linux-cli-prac:latest
docker run -it --name lets-practice-linux-command hayanbada/linux-cli-prac:latest
```

After exit shell, container will be stopped

But you can start container without create new container again

```bash
docker start -ai lets-practice-linux-command
```

# Why did you build this image?

I'm reading an efficient linux at the command. 

I was working on gitbash on windows, zshon macbook, and uvuntu bash on virtual machine, and I wanted to build a docker container and run the container whenever I needed it.

