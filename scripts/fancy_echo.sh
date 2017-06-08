#!/bin/bash

function fancy_echo() {
  echo $'\e[32;1m'$1$'\e[0m'
}

function fancy_echo_red() {
  echo $'\e[31;1m'$1$'\e[0m'
}
