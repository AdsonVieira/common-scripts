#!/bin/bash

echo "======================================="
echo " Limpeza de ambiente Docker (LOCAL)"
echo "======================================="

echo ""
echo "Espaço antes da limpeza:"
docker system df

echo ""
read -p "Deseja continuar? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
  echo "Operação cancelada."
  exit 1
fi

echo ""
echo "Removendo containers parados..."
docker container prune -f

echo "Removendo imagens dangling..."
docker image prune -f

echo "Removendo networks não utilizadas..."
docker network prune -f

echo "Limpando cache de build..."
docker builder prune -f

echo ""
echo "Espaço após limpeza:"
docker system df

echo ""
echo "Limpeza finalizada!"
