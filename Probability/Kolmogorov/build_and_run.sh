#!/usr/bin/env bash
#-- Compila cada ejemplo con los contratos activados (-gnata) y lo ejecuta.
#-- Termina con error si algun ejemplo falla.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p obj
for source in examples/*.adb; do
    name="$(basename "$source" .adb)"
    [ "$name" = "checks" ] && continue
    echo "=================================================== $name"
    gnatmake -q -gnata -gnatwa -gnat2012 -I. -Iexamples -D obj -o "obj/$name" "$source"
    "./obj/$name"
done
