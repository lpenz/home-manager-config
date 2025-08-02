{ pkgs, urxvtnotify }:
{
  enable = true;
  interactiveShellInit = ''
    # Commands to run in interactive sessions can go here
    set fish_greeting
    # Install fundle
    if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
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
    set -U sponge_purge_only_on_exit true
    set --prepend fish_function_path ${pkgs.fzf}/share/fish/vendor_functions.d
    fzf_key_bindings
    direnv hook fish | source
    bind \eq fish-push-line
    bind \ed kill-bigword
    bind \e\x7f backward-kill-bigword
    bind \eb backward-bigword
    bind \cx\ce edit_command_buffer
    bind f10 fish-omnibuild
    bind \ew fish-full-path
    bind \e1 fish-sudo-line
    bind \e! fish-sudo-line
    bind \em fish-repeat-last-word
    bind \ei fish-pager-vim
    bind \eh fish-help-this
    if test -e "$HOME/.fishrc-local.fish"
        source "$HOME/.fishrc-local.fish"
    end
  '';
  functions = {
    fish-help-this.body = ''
      set cmd (commandline -b)
      if test -z "$cmd"
        return
      end
      eval "$cmd --help 2>&1 | vi -"
    '';
    fish-push-line.body = ''
      commandline -f kill-whole-line
      function restore_line --on-event fish_prompt
          commandline -f yank
          functions -e restore_line
      end
    '';
    fish-omnibuild.body = ''
      commandline -r omnibuild
      commandline -f execute
    '';
    fish-full-path.body = builtins.readFile ./fish-full-path.fish;
    fish-sudo-line.body = ''
      fish_commandline_prepend sudo
    '';
    fish-pager-vim.body = ''
      fish_commandline_append ' 2>&1 | vi -'
    '';
    fish-repeat-last-word.body = builtins.readFile ./fish-repeat-last-word.fish;
  };
  plugins = [
    { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    { name = "bang-bang"; src = pkgs.fishPlugins.bang-bang.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
  ];
}
