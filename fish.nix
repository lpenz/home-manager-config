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
    bind \eq fish-push-line
    bind \ed kill-bigword
    bind \e\x7f backward-kill-bigword
    bind \eb backward-bigword
    bind \cx\ce edit_command_buffer
    bind f10 fish-omnibuild
    bind \ew fish-append-cwd
    bind \e1 fish-sudo-line
    bind \e! fish-sudo-line
    bind \em fish-repeat-last-word
    if test -e "$HOME/.fishrc-local.fish"
        source "$HOME/.fishrc-local.fish"
    end
    bind \ei fish-pager-vim
  '';
  functions = {
    fish-push-line.body = ''
      commandline -f kill-whole-line
      function restore_line --on-event fish_prompt
          commandline -f yank
          functions -e restore_line
      end
    '';
    fish-omnibuild = ''
      commandline -r omnibuild
      commandline -f execute
    '';
    fish-append-cwd = ''
      commandline -i {$PWD}/
    '';
    fish-sudo-line = ''
      fish_commandline_prepend sudo
    '';
    fish-pager-vim = ''
      fish_commandline_append ' 2>&1 | vi -'
    '';
    fish-repeat-last-word = ''
      set -l cmdline (commandline)
      set -l cursor_pos (commandline -C)

      # Move cursor to the end of the current word if inside a word
      set -l end_of_word_pos (string match -r -i '[^ ]*$' -- (string sub -s $cursor_pos -- $cmdline) | string length)
      if test $end_of_word_pos -gt 0
          set cursor_pos (math $cursor_pos + $end_of_word_pos - 0)
      end

      set -l left_part (string sub -l $cursor_pos -- $cmdline)
      set -l right_part (string sub -s (math $cursor_pos + 1) -- $cmdline)

      set -l words_in_left (string split " " -- $left_part)
      set -l last_word

      # Iterate over the words in reverse to find the last non-empty word
      for word in (seq (count $words_in_left) -1 1)
          set -l current_word (string trim -c ' ' -- $words_in_left[$word])
          if test -n "$current_word"
              set last_word $current_word
              break
          end
      end

      # Duplicate the word if found
      if test -n "$last_word"
          commandline -r -- "$left_part $last_word$right_part"
          commandline -C (math $cursor_pos + (string length -- $last_word) + 1)
      end
    '';
  };
  plugins = [
    { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    { name = "bang-bang"; src = pkgs.fishPlugins.bang-bang.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
  ];
}
