#!/bin/bash

echo "Construyendo módulo Flutter como AAR..."

# Limpiar

flutter clean

# Dependencias

flutter pub get

# Construir AAR solo release (optimizado)

flutter build aar --no-debug --no-profile

# Crear output

mkdir -p output

# Copiar resultados

if [ -d "build/host/outputs/repo" ]; then

cp -r build/host/outputs/repo/* output/

echo "AAR generado en output/"

# Mostrar archivos generados

find output -name "*.aar" -type f | while read file; do

size=$(du -h "$file" | cut -f1)

echo "$(basename "$file") ($size)"

done

else

echo "Error generando AAR"

exit 1

fi
