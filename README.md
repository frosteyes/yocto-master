Yocto Project used when I do Yocto master work
=============================================
This repository provides examples used when I work with yocto master.
It uses core-image-sato / core-image-minimal for a virtual x86-64
and ARM64 qemu machine to be able to test and show the results.

Before trying to use this, please see Yocto project quick build for setting up
a native Linux host for building the image.

Below guide expect that your host machine is setup for Yocto build.

Background
---------------
This repo is provided as is. Mostly for my test work on yocto master.
All of the recipes in this git repo is released under MIT.

Getting Started
---------------
**1.  Clone this repo.**

    $ git clone --recurse-submodules https://github.com/frosteyes/yocto-master.git

**2.  Setup yocto.**

Source the setup script. Optional select a build folder. If no build folder is 
selected a standard folder named *build* is created. Select target x86-64 
*setup_qemux86-64* or *setup_qemuarm64*:

    $ cd yocto-master
    $ source setup_qemuarm64 build_arm64

After you have sourced the setup, please look into the *conf/local.conf* file.
Specifically the variables **DL_DIR** and **SSTATE_DIR** is relevant to save
downloads for later, and prebuild in sstate cache.

**3.  Build image.**

Run bitbake - here we just selet the basic image:

    $ bitbake core-image-sato

First time it takes significant time, as it need to download all the source 
code, compile the host tools and next the complete linux image.

**4.  Run the image in QEMU.**

When the build is done, it is just to run qemu:

    $ runqemu
