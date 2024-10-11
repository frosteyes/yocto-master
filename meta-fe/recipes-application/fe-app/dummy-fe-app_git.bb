# Dummy recipe - to be able to create SDK with all the dependencies for fe-app,
# without needing to be able to compile AMP itself.
SUMMARY = "Dummy version of fe-app"
HOMEPAGE = "https://github.com/frosteyes/fe-app"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

# Access the same dependencies as the normal fe-app.
require fe-app_dependencies.inc

SRC_URI = "file://${COMMON_LICENSE_DIR}/Apache-2.0 \
           file://info.txt \
          "
S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"

inherit cmake

do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -Dm 0644 ${S}/info.txt ${D}${datadir}/dummy-fe-app/info.txt
}

python package_depchains:append() {
    pn = d.getVar('PN')
    recommends = d.getVar('RRECOMMENDS:' + pn + '-dev' )

    # Append the recommends to the RDEPENDS, so it end in requires for the RPM
    d.appendVar('RDEPENDS:' + pn + '-dev', recommends)
}
