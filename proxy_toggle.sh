#!/bin/zsh

PROXY_HOST=proxy.uec.ac.jp
PROXY_PORT=8080

shellrc=$HOME/.zshenv
gitconfig=$HOME/.gitconfig

# Check no argument
if [ $# = 0 ]; then
    echo "Error: no args"
    exit 1
elif [ $1 != "on" ] && [ $1 != "off" ]; then
    echo "arg: 'on' or 'off'"
    exit 1
fi

# Generate URLs
proxy_url=http://$PROXY_HOST:$PROXY_PORT
no_proxy_url=127.0.0.1,localhost

# Set to $shellrc
shellrc_replace_list=("http_proxy" "HTTP_PROXY" "https_proxy" "HTTPS_PROXY" "ftp_proxy" "FTP_PROXY" "all_proxy" "ALL_PROXY")
if [ $1 = "on" ]; then
    echo "Turn on proxy in $shellrc"

    for i in $shellrc_replace_list; do sed -i -e '/^\(export\|unset\) '$i'/c\export '$i'='$proxy_url $shellrc; done
    sed -i -e '/^\(export\|unset\) no_proxy/c\export no_proxy='$no_proxy_url $shellrc
    sed -i -e '/^\(export\|unset\) NO_PROXY/c\export NO_PROXY='$no_proxy_url $shellrc
elif [ $1 = "off" ]; then
    echo "Turn off proxy in $shellrc"

    for i in $shellrc_replace_list; do sed -i -e '/^\(export\|unset\) '$i'/c\unset '$i $shellrc; done
    sed -i -e '/^\(export\|unset\) no_proxy/c\unset no_proxy' $shellrc
    sed -i -e '/^\(export\|unset\) NO_PROXY/c\unset NO_PROXY' $shellrc
fi
source $shellrc

# Set to $shellrc
if [ $1 = "on" ]; then
    echo "Turn on proxy in $gitconfig"

    git config --global http.proxy $proxy_url
    git config --global https.proxy $proxy_url
    git config --global url."https://".insteadOf git://
elif [ $1 = "off" ]; then
    echo "Turn off proxy in $gitconfig"

    git config --global --remove-section http
    git config --global --remove-section https
    git config --global --remove-section url."https://"
fi




