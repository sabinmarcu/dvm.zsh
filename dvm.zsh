#!/usr/bin/env zsh

set -e 

local dvm_dir="${DVM_DIR:-$HOME/.dvm}"
local dvm_bin_dir="$dvm_dir/bin"
local exe="$dvm_bin_dir/dvm"

[[ -z $DVM_DIR ]] && export DVM_DIR=${dvm_dir}

if [[ ! -f $exe ]]; then 
  echo "\033[34mInstalling DVM\033[0m"
  if curl -fsSL https://dvm.deno.dev | sh; then 
    echo "\033[32mDone!\033[0m"
  else
    echo "\033[31mThere was an error installing DVM!\033[0m"
  fi
fi

if [[ -f $exe ]]; then
  export PATH="$dvm_dir:$PATH"
fi
