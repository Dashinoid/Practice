#!/bin/bash

pwd
mkdir stage1
cd stage1
mkdir f1 f2 f3
cd f1
touch f1.txt f2.txt f3.txt f4.json f5.json
ls -la
cd ..
mv f1/f1.txt f1/f2.txt f2/
cp f1/f3.txt f1/f4.json f3/
find . -name "f1.txt"
date
