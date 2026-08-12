#!/usr/bin/env bash

# Open directories in the file manager.
xdg-mime default org.gnome.Nautilus.desktop inode/directory

# Route web links and HTML through the smart browser opener.
xdg-settings set default-web-browser smart-browser.desktop
xdg-mime default smart-browser.desktop x-scheme-handler/http
xdg-mime default smart-browser.desktop x-scheme-handler/https
xdg-mime default smart-browser.desktop text/html
xdg-mime default smart-browser.desktop application/xhtml+xml

# Open PDFs with Papers.
xdg-mime default org.gnome.Papers.desktop application/pdf

# Open images with imv.
for mime_type in \
    image/avif \
    image/bmp \
    image/gif \
    image/heic \
    image/heif \
    image/jpeg \
    image/png \
    image/svg+xml \
    image/tiff \
    image/vnd.microsoft.icon \
    image/webp
do
    xdg-mime default imv.desktop "$mime_type"
done

# Open videos with MPV.
for mime_type in \
    video/mp4 \
    video/x-msvideo \
    video/x-matroska \
    video/x-flv \
    video/x-ms-wmv \
    video/mpeg \
    video/ogg \
    video/webm \
    video/quicktime \
    video/3gpp \
    video/3gpp2 \
    video/x-ms-asf \
    video/x-ogm+ogg \
    video/x-theora+ogg \
    application/ogg
do
    xdg-mime default mpv.desktop "$mime_type"
done

# Open audio with MPV.
for mime_type in \
    audio/aac \
    audio/flac \
    audio/m4a \
    audio/mp4 \
    audio/mpeg \
    audio/ogg \
    audio/opus \
    audio/vnd.wave \
    audio/wav \
    audio/webm \
    audio/x-m4a \
    audio/x-mpegurl \
    audio/x-ms-wma \
    audio/x-scpls \
    audio/x-wav \
    application/vnd.apple.mpegurl \
    application/x-mpegurl
do
    xdg-mime default mpv.desktop "$mime_type"
done

# Open text, source, structured text, and shell scripts with Neovim.
for mime_type in \
    text/plain \
    text/english \
    text/x-makefile \
    text/x-c++hdr \
    text/x-c++src \
    text/x-chdr \
    text/x-csrc \
    text/x-java \
    text/x-moc \
    text/x-pascal \
    text/x-tcl \
    text/x-tex \
    text/x-c \
    text/x-c++ \
    text/x-go \
    text/x-python \
    text/x-script.python \
    text/rust \
    text/javascript \
    text/markdown \
    text/x-markdown \
    text/xml \
    application/javascript \
    application/json \
    application/toml \
    application/xml \
    application/x-shellscript \
    application/x-typescript \
    application/yaml
do
    xdg-mime default nvim.desktop "$mime_type"
done
