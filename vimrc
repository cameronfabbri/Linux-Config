" Cameron Fabbri
" vimrc

" Template to autofill a new file with a .py extension
autocmd FileType python call PythonTemplate()
fu! PythonTemplate()
    if line("$") == 1
        call append(0, "\"\"\"")
        call append(1, "\"\"\"")
        call append(2, "")
        call append(3, "import sys")
        call append(4, "import argparse")
        call append(5, "")
        call append(6, "")
        call append(7, "def main(argv):")
        call append(8, "")
        call append(9, "    args = parse(argv)")
        call append(10, "")
        call append(11, "")
        call append(12, "def parse(argv):")
        call append(13, "    parser = argparse.ArgumentParser(argv)")
        call append(14, "    parser.add_argument(")
        call append(15, "        '--seed', required=False, type=int, default=124,")
        call append(16, "        help='')")
        call append(17, "")
        call append(18, "    return parser.parse_args(argv[1:])")
        call append(19, "")
        call append(20, "")
        call append(21, "if __name__ == '__main__':")
        call append(22, "    main(sys.argv)")
    endif
endfu

" Create plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
" Colors for python
Plug 'vim-python/python-syntax'
" Automatically sorts imports
Plug 'tweekmonster/impsort.vim'
call plug#end()

" Pathogen plugin manager
execute pathogen#infect()

let g:syntastic_python_checkers=['flake8']

" Remove whitespace at the end of lines
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Run above function whenever file is saved
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Sort imports whenever file is saved
autocmd BufWritePre *.py ImpSort!

colorscheme gruvbox
syntax enable
set background=dark

if (has("termguicolors"))
 set termguicolors
endif

let g:impsort_highlight_imported = 1
let g:python_highlight_all = 1

" no auto indenting when typing
let b:did_indent = 1

" Toggel fullscreen
map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

set colorcolumn=80
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set number
set showmatch
set hlsearch
set autoindent
set smartindent
set noswapfile
set backspace=2
set backspace=indent,eol,start
set ai
set si

" double press i to enter/exit escape mode
:imap ii <Esc>

" remap typos
:command Tabp tabp
:command Tabn tabn
:command Tabe tabe
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command! Noh noh

set noerrorbells visualbell t_vb= " disable bell
autocmd GUIEnter * set visualbell t_vb=
