#!/bin/bash

echo If you get errors, you may need ronn installed: gem install ronn

OUTPUT=$1

# This requires the installation of `ronn`: sudo gem install ronn
for f in cmd/*/README.md;do
    # Strtip off cmd/ then strip off README to get the man-file name.
    PKGNOCMD="${f#cmd/}"
    PKG="${PKGNOCMD%/README.md}"
    echo "Creating Man Page: ${f} -> ${OUTPUT}${PKG}.1.gz"
    ronn < "$f" | gzip -9 > "${OUTPUT}${PKG}.1.gz"
done
