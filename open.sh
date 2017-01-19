#!/bin/sh

# some literals with ANSI escape sequences for switching colours
red='\033[0;31m'
grn='\033[0;32m'
gry='\033[0;37m'
yel='\033[1;33m'
whi='\033[1;37m'

if [ `whoami` != 'root' ]
  then
    echo -e "${yel}Insufficient privileges."
    echo -e "${gry}Unable to cast the ${red}open${gry} spell. Maybe try this:"
    echo -e "   ${whi}sudo${gry} ./fordintysa-ci/open.sh"
    exit
fi
if [ $# -lt 1 ]
  then
    echo -e "${yel}Required parameter missing.${gry}"
    echo "Open what, Ali Baba? Available files:"
    ls -1
    exit
fi
if [ ! -r $1 ]
  then
    echo -e "${yel}$1: file or directory not found.${gry}"
    echo "Open what, Ali Baba? Available files:"
    ls -1
    exit
fi
echo ""
echo "O===O  __  __  ___       __  ___ __  __      ___  __  O===O"
echo " [ ]  /  \|  \|   |  |  /   |   /   /  \|  ||    |  |  [ ]"
echo " [ ]  |  ||__/|__ |\ |  \__ |__ \__ |__||\/||__   \/   [ ]"
echo " [ ]  |  ||   |   | \|     \|      \|  ||  ||     __   [ ]"
echo " [ ]  \__/|   |___|  |   __/|___ __/|  ||  ||___  \/   [ ]"
echo "O===O                                                 O===O"
echo ""

## install docker-compose (if not done already)
if [ -r /usr/local/bin/docker-compose ]
  then
    echo "docker-compose already installed"
  else
    echo "installing docker-compose ..."
    curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# run docker-compose
docker-compose -f=$1 up -d
