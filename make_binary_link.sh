#!/bin/bash

# directory of original binary
source_dir="bin_source/*"
# directory where symbolic links are made
target_dir="target_binary_directory"
# boolean for install or uninstall
readonly is_uninstall=false

# get current direactories
cur_dir=$(cd $(dirname $0) && pwd)

# get all binary files
bins=`find $source_dir -maxdepth 0 -type f` 

# loop for all binary files
for bin in $bins;
do 
    if "${is_uninstall}"; then
        ### uninstall mode; unlink if there are linked binaries
        # echo "Uninstalling binaries"
        if [ -e "${target_dir}/${bin##*/}" ]; then
            echo "Unlinking ${target_dir}/${bin##*/}"
            unlink "${target_dir}/${bin##*/}"
        fi
    else
        ### install mode; link if there are no linked binaries
        # echo "Installing binaries"
        if [ -e "${target_dir}/${bin##*/}" ]; then
            echo "Skip linking for ${cur_dir}/${bin}"
        else
            echo "Linking ${cur_dir}/${bin} to ${target_dir}/${bin##*/}"
            ln -s "${cur_dir}/${bin}" "$target_dir/${bin##*/}"
        fi
    fi
done


