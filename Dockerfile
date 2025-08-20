FROM alpine:3.22.1
RUN apk add --no-cache chromium-swiftshader

# With this setup running in jenkins docker image, chrome is executed
# as the jenkins user, which doesn't have a home directory.
# This causes chromium to crash because it tries to create some
# config files and fails.
# These env variables give chromium a dummy directory where it can write into.
ENV XDG_CONFIG_HOME=/tmp/.chromium
ENV XDG_CACHE_HOME=/tmp/.chromium
