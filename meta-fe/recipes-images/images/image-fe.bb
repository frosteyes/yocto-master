DESCRIPTION = "FrostEyes main image"

require image-fe-base.bb

# Remove dummy packages
IMAGE_INSTALL:remove = "dummy-fe-app"

# Add correct packages
IMAGE_INSTALL += "fe-app"
