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
    makeprg = "omnibuild";
    shiftwidth = 4;
    swapfile = false;
    tabstop = 4;
    wrap = false;
  };
  keymaps = [
    {
      mode = "n";
      key = "<F2>";
      action = "<cmd>update!<CR>";
      options = { desc = "Save changed files."; silent = true; };
    }
    {
      mode = "n";
      key = "<F10>";
      action = "<cmd>make<CR>";
      options = { desc = "Compile project."; silent = true; };
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
  plugins.treesitter = {
    enable = true;
  };
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
