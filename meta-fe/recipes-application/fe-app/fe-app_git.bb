SUMMARY = "fe-app - FrostEyes test app"
HOMEPAGE = "https://github.com/frosteyes/fe-app"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"


BRANCH = "master"
SRC_URI = "git://github.com/frosteyes/fe-app.git;branch=master;protocol=https"
SRCREV = "9f04dde87c11b9a45fee504ecc0c85d54dbe98a0"

inherit cmake

# We have dependencies in seperate file - also used by dummy recipe
require fe-app_dependencies.inc

S = "${WORKDIR}/git"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${B}/fe-test ${D}${bindir}/
}
