{ pkgs, urxvtnotify }:
{
  enable = true;
  interactiveShellInit = ''
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set -Ux LOCALE_ARCHIVE_2_27 $HOME/.nix-profile/lib/locale/locale-archive
    set -gx EDITOR vim
    set -gx VISUAL vim
    set -gx LC_ALL en_US.UTF-8
    set -gx LANGUAGE en
    set -gx PYTHONIOENCODING UTF-8
    set -gx NIX_IGNORE_SYMLINK_STORE 1
    set -gx PYTHONSTARTUP $HOME/.pystartup
    set -gx XAUTHORITY $HOME/.Xauthority
    set -gx RUST_SRC_PATH /usr/src/rust/src
    set -U __done_min_cmd_duration 3000
    set -U __done_notification_command "${urxvtnotify} \$title \$message"
    set -U __done_allow_nongraphical 1
    fzf_configure_bindings --directory=\ct
    fzf_configure_bindings --variables=
    direnv hook fish | source
    function push-line
        commandline -f kill-whole-line
        function restore_line --on-event fish_prompt
            commandline -f yank
            functions -e restore_line
        end
    end
    bind \eq push-line
    bind \ed kill-bigword
    bind \e\x7f backward-kill-bigword
    bind \eb backward-bigword
    '';
  plugins = [
    { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
  ];
}
