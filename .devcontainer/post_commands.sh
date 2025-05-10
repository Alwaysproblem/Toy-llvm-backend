#!/bin/bash

git config --global --add safe.directory '*'
git config --global user.name "Alwaysproblem"
git config --global user.email "reganyang0415@gmail.com"
/root/.local/bin/setup_new_user 1001 1000

wget https://github.com/clangd/clangd/releases/download/18.1.3/clangd-linux-18.1.3.zip
unzip clangd-linux-18.1.3.zip
mv clangd_18.1.3/bin/clangd /root/.local/bin/clangd
chmod +x /root/.local/bin/clangd
rm -rf clangd-linux-18.1.3.zip clangd_18.1.3
