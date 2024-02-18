{ pkgs }:
''
  #!${pkgs.bash}/bin/bash

  ${pkgs.coreutils}/bin/head -n $(($(${pkgs.ncurses}/bin/tput lines) - 4)) "$@"
''
