# `brushdojo/drawpile-srv`

A custom `drawpile-srv` image built for BrushDojo's Drawpile servers

**Website:** https://brushdojo.com  
**Discord:** https://discord.gg/Ysvv4pY


## Table of Contents

- [Requirements](#requirements)
- [Get Started](#get-started)
- [Configuration](#configuration)
  - [Configuring `drawpile-srv`](#configuring-drawpile-srv)
  - [Configuring Session Templates](#configuring-session-templates)
  - [Configuring Secrets](#configuring-secrets)
- [Build](#build)
- [Deployment](#deployment)


## Requirements

In order to work with this image, you will need 
[Git](https://git-scm.com/), 
[Docker](https://www.docker.com/), 
[Docker Compose](https://docs.docker.com/compose/), 
and 
[Drawpile](https://drawpile.net/).


## Get Started

To get started, use `git` to clone this repository:

```sh
git clone https://github.com/brushdojo/drawpile-srv.git
```

This command will automatically create a new folder in the current working 
directory called `drawpile-srv`.

Interact with and make changes to this directory's contents to build your own 
Drawpile server.


## Configuration


### Configuring `drawpile-srv`

To configure `drawpile-srv` directly, make changes to its runtime arguments or 
to its configuration database.

Change the runtime arguments by setting a custom `command` in the 
`docker-compose.yml` file:

```yml
command: [
  # ...
]
```

Change the configuration database using SQLite or the server's built-in 
[Web Admin API](https://github.com/drawpile/Drawpile/blob/master/doc/server-api.md).


### Configuring Session Templates

This image uses 
[session templates](https://github.com/drawpile/website/blob/master/templates/pages/help/server.html#L320) 
to run customized drawing sessions on the Drawpile server.

> **What are Session Templates?**
>
> Session templates control how a Drawpile server creates and manages drawing 
sessions. The templates themselves are either session recordings (`.dprec` 
files) or hand-written `.dptxt` files.
>
> Hand-written session templates use a special 
[recording text format](https://github.com/drawpile/Drawpile/blob/master/doc/textloader.md) 
to represent how they affect a drawing session. This text format is quite 
complicated, but is easier to understand after viewing some examples.
>
> To generate an example `.dptxt` file, use the `dprectool` binary that ships 
with Drawpile to convert a session recording (`.dprec` file) to a `.dptxt` file.

This repository's session templates are stored in the `session-templates` 
directory. During the build process, the contents of this directory are 
automatically copied into the image.

Edit the session templates in this directory to change how sessions behave on 
the server.

### Configuring Secrets

This image uses the `--web-admin-auth` flag to supply a sensitive username and 
password combination to `drawpile-srv`. 

These credentials are used by the `drawpile-srv` to guard against unprotected 
access of its
[Web Admin API](https://github.com/drawpile/Drawpile/blob/master/doc/server-api.md).

At runtime, a secret located in `secrets/web-admin-credentials` is securely 
mounted into the container and read by `drawpile-srv`.

This secret is not backed to source control because it contains sensitive data 
-- it does not exist after cloning the repository. So, for this reason, the 
secret must be recreated locally.

Use the following command to recreate the secret:

```sh
mkdir secrets && echo "username:password" > secrets/web-admin-credentials
```

Substitute `username:password` with your desired username and password 
combination.

## Build

Before building this image, make sure it is fully configured!  Read the 
[#configuration](#configuration) section of this guide for more information.

To build this image, run the following command in the project root:

```sh
docker-compose build
```

This command will automatically build and tag the image as 
`brushdojo/drawpile-srv`.

## Deployment

To deploy this image, run the following command:

```sh
docker-compose up
```

This image can be run independently, or as part of a stack. Reference 
`docker-compose.yml` when attempting to integrate this image into a stack; 
it contains useful information about this image's dependencies.
