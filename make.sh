#!/bin/bash
mkdir ~/tmp/src
mkdir ~/tmp/bin
mkdir ~/tmp/debug
mkdir ~/tmp/glyphs
mkdir ~/tmp/obj
mkdir ~/tmp/dep

mv src ~/tmp/
mv bin ~/tmp/
mv debug ~/tmp/
mv *_app_iota.gif ~/tmp/
mv Makefile ~/tmp/
mv glyphs ~/tmp/
mv obj ~/tmp/
mv dep ~/tmp/

cd ~/tmp/

make load

mv ~/tmp/* ~/shared/blue-app-iota/
