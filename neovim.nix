{ pkgs }:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  extraConfigLua = ''
    vim.g.mapleader = ' '

    vim.opt.expandtab = true
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.autowriteall = true
    vim.opt.swapfile = false
    vim.opt.wrap = false
    vim.opt.makeprg = 'omnibuild'

    vim.keymap.set('n', '<F2>', ':update!<CR>')
    vim.keymap.set('n', '<F10>', ':make<CR>')
    vim.keymap.set('n', '<C-C>', ':qa!<CR>')

    if vim.fn.executable('rg') then
        vim.opt.grepprg = 'rg --vimgrep -g "!/tags"'
    end
  '';
}
