#!/usr/bin/env zsh

local ZSH_DVM_DIR=${0:a:h}

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
    false
  fi
fi

local comp_dir="$ZSH_DVM_DIR/completions"
local comp_file="$comp_dir/_dvm"

if [[ -f $exe ]]; then
  export PATH="$dvm_dir:$PATH"
  if [[ ! -f $comp_file ]]; then
    mkdir -p $comp_dir
    if ! ((${fpath[(Ie)$comp_dir]})); then
      fpath=($comp_dir $fpath)
    fi
    dvm completions zsh > $comp_file
  fi
fi

true
