# Class for handling depends for a dummy-package
#
# Copyright (c) Claus Stovgaard - All rights reserverd
# SPDX-License-Identifier: MIT
#
# A dummy-package is used for generating a SDK / image with all needed DEPENDS
# for a specific recipe - without needing to build the recipe itself.
# Yocto automatically adds runtime dependencies meaning that you often don't
# add packages from DEPENDS to RDEPENDS.
# See https://docs.yoctoproject.org/overview-manual/concepts.html#automatically-added-runtime-dependencies
# There exist three automatic machanisms (shlibdeps, pcdeps and depchains)
# * With shlibdeps all executable and shared libraries are inspected for what
#   shared libraries they are linked against, and the packages providing the
#   needed libraries is added to the RDEPENDS
# * For pcdeps - it is based on pkg-config.
# * For depchains it handle -dev and -dbg packages.
#
# This class adds to this, by direct convert elements from DEPENDS to 
# RDEPENDS:${PN} and warn if DEPENDS contains a elements not directly able
# to be mapped to a package
#
# Author(s)
#   Claus Stovgaard - claus@stovgaard.com

python __anonymous () {
    pn = d.getVar('PN')

    rdepends = bb.utils.explode_deps(d.getVar('RDEPENDS:' + pn) or "")
    depends = bb.utils.explode_deps(d.getVar('DEPENDS') or "")

    for dep in depends:
        if dep.find('-native') != -1 or dep.find('-cross') != -1 or dep.startswith('virtual/'):
            # bb.note("Skipping %s" % dep)
            continue

        # Verify a -dev package exist, or skip and warn that it need special handling        
        recipename = oe.packagedata.recipename(dep + '-dev', d)
        if not recipename:
            bb.warn("dummy-package: %s (Skipping DEPENDS: %s - needs customs handling, no %s-dev exist)" % (pn, dep, dep) )
            continue
        
        if dep not in rdepends:
            rdepends.append(' ' + dep)

    d.setVar('RDEPENDS:' + pn, ' '.join(rdepends))
}

# For dummy packages, there is nothing to compile
do_patch[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"
