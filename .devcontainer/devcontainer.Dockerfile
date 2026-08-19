#
# Dockerfile for vscode integration of prevas/yocto-dev
#
# Copyright (c) Claus Stovgaard - All rights reserved
# SPDX-License-Identifier: MIT
#
# Image for using prevas/yocto-dev with vscode
#
# * vs-yocto-dev - main image
#
# Author(s)
#   Claus Stovgaard - claus.stovgaard@prevas.dk
#

FROM prevas/yocto-dev:20250702 AS vs-yocto-dev

# Default values
ARG UNAME=vs
ARG UID=1000
ARG GID=100

# The auto-uid feature from prevas/yocto-dev collide with the vscode way of
# handling docker user / gid. As part of the startup it uses getent to detect
# user in passwd file - before the auto-uid has created it. Meaning the vscode
# devcontainer fails to start.
# To work around it - remove the prevas auto-uid, and add a user "vs" and use
# the vscode way for uid / gid handling.
RUN rm /usr/libexec/auto-uid-entry.py

# Create the user for vs
# -l to not fill lastlog / faillog. The reason is that they can get big with high UID / GID
# Also see https://github.com/sagemathinc/cocalc/issues/2287
RUN useradd -m -l -u $UID -g $GID -s /bin/bash $UNAME

# Make the user a sudo user
RUN usermod -a -G sudo $UNAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Beside running bitbake, we also use the container for shellcheck and shfmt
# This integrate with the bash-ide-vscode plugin
# To install with apt we need to update locale cache first - else it will fail
# when upstream has updated shellcheck / shfmt
RUN apt update
RUN apt-get install -y shellcheck shfmt
