{ pkgs, urxvtnotify }:
{
  enable = true;
  interactiveShellInit = ''
    # Commands to run in interactive sessions can go here
    set fish_greeting
    fish_config theme choose 'fish default'
    fish_add_path "$HOME/bin"
    set -gx LOCALE_ARCHIVE_2_27 "${pkgs.glibcLocales}/lib/locale/locale-archive"
    set -gx EDITOR vim
    set -gx VISUAL vim
    set -gx LC_ALL en_US.UTF-8
    set -gx LANGUAGE en
    set -gx PYTHONIOENCODING UTF-8
    set -gx NIX_IGNORE_SYMLINK_STORE 1
    set -gx PYTHONSTARTUP $HOME/.pystartup
    set -gx XAUTHORITY $HOME/.Xauthority
    set -gx RUST_SRC_PATH /usr/src/rust/src
    set -gx SYSTEMD_PAGER ""
    set -gx fish_color_autosuggestion 777777
    set -U __done_min_cmd_duration 3000
    set -U __done_notification_command "${urxvtnotify} \$title \$message"
    set -U __done_allow_nongraphical 1
    set --prepend fish_function_path ${pkgs.fzf}/share/fish/vendor_functions.d
    fzf_key_bindings
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
    bind \cx\ce edit_command_buffer
    bind -k f10 omnibuild
    if test -e "$HOME/.fishrc.local"
        source "$HOME/.fishrc.local"
    end
  '';
  plugins = [
    { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
  ];
}
