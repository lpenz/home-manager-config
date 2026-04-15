#!/bin/bash

set -e -x

home-manager switch -v -b bk
nix-collect-garbage -d
