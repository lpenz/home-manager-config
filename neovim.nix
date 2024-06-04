{ pkgs }:
{
  enable = true;
  extraConfig = ''
    let g:mapleader=' '

    set expandtab tabstop=4 shiftwidth=4
    set autowriteall
    set noswapfile
    set nowrap

    nnoremap <silent> <F2> :update!<CR>
    set makeprg=omnibuild
    nnoremap <silent> <F10> :make<CR>

    nnoremap <silent> <C-C> :qa!<CR>

    " visual search
    xnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
    xnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

    if executable('rg')
       set grepprg=rg\ --vimgrep\ -g\ '!/tags'
    endif
  '';
}
