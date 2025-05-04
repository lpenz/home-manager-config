{ pkgs }:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  globals = {
    mapleader = " ";
  };
  opts = {
    autowriteall = true;
    expandtab = true;
    ignorecase = true;
    incsearch = false;
    makeprg = "omnibuild";
    mouse = "";
    shiftwidth = 4;
    swapfile = false;
    tabstop = 4;
    wrap = false;
  };
  colorschemes.gruvbox.enable = true;
  extraPlugins = [
    pkgs.vimPlugins.vim-dirdiff
    pkgs.vimPlugins.align
  ];
  keymaps = [
    {
      mode = "n";
      key = "<F2>";
      action = "<cmd>update!<CR>";
      options = { desc = "Save changed files."; silent = true; };
    }
    {
      mode = "n";
      key = "<F4>";
      action = "<cmd>cn<CR>";
      options = { desc = "Go to next error"; silent = true; };
    }
    {
      mode = "n";
      key = "<F9>";
      action = "<cmd>cw<CR>";
      options = { desc = "Open compilation window"; silent = true; };
    }
    {
      mode = "n";
      key = "<F10>";
      action = "<cmd>make<CR>";
      options = { desc = "Compile project."; silent = true; };
    }
    {
      mode = "n";
      key = "<leader><tab>";
      action = "<C-^>";
      options = { desc = "Go to alternate-file"; };
    }
    {
      mode = "n";
      key = "<C-C>";
      action = "<cmd>qa!<CR>";
      options = { desc = "Quit."; };
    }
  ];
  extraConfigLua = ''
    if vim.fn.executable('rg') then
        vim.opt.grepprg = 'rg --vimgrep -g "!/tags"'
    end
  '';
  plugins.airline = {
    enable = true;
    settings = {
      symbols_ascii = 1;
    };
  };
  plugins.web-devicons = {
    enable = true;
  };
  # plugins.treesitter = {
  #   enable = true;
  # };
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>b" = {
        action = "buffers";
        options.desc = "Navigate buffers with telescope";
      };
      "<leader>f" = {
        action = "find_files";
        options.desc = "Find files with telescope";
      };
      "<leader>/" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Fuzzy find in current buffer with telescope";
      };
      "<leader>es" = {
        action = "live_grep";
        options.desc = "Live grep/rg with telescope";
      };
      "<leader>q" = {
        action = "quickfix";
        options.desc = "Quickfix entries with telescope";
      };
    };
  };
}
