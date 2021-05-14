#!/usr/bin/env bash

for i in {1..1000}
do
./pessoas -i "Pessoa $i" $((i%80))
done
