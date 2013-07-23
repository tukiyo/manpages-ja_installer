#!/bin/sh

jman_installer() {
    set -x
    brew tap homebrew/dupes
    brew install groff
    curl http://linuxjm.sourceforge.jp/man-pages-ja-20130715.tar.gz | tar x -
    sudo patch /etc/man.conf < patches/man.conf.patch
    patch man-pages-ja-20130715/script/configure.perl < patches/configure.perl.patch
    cd man-pages-ja-20130715
    make > /dev/null
    make install > /dev/null
    echo "[info] man installed /usr/local/share/man/ja_JP.UTF-8/"
    echo "done."
    set +x
}
if [ "`uname -s`" != "Darwin" ];then
    echo "[warn] only mac supported."
    exit 0
fi

if [ ! -e "/usr/local/bin/brew" ];then
    echo "[warn] /usr/local/bin/brew not found."
    echo "  you need install 'brew' => http://mxcl.github.io/homebrew/"
    exit 0
fi

jman_installer
