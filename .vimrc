" .vimrc - Vim configuration file.
"
" Copyright (c) 2010 Jeffy Du. All Rights Reserved.
"
" Maintainer: Jeffy Du <jeffy.du@gmail.com>
"    Created: 2010-01-01
" LastChange: 2010-04-22

" init vundle plugins for rust.vim
" call vim :PluginInstall to install plugins at first time
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim'

" use python install.py --racer-completer
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype on


" GENERAL SETTINGS: {{{1
" To use VIM settings, out of VI compatible mode.
set nocompatible
" Enable file type detection.
filetype plugin indent on
" Syntax highlighting.
syntax on
" Setting colorscheme
color mycolor
" Other settings.
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start
set nobackup
set   cindent
set   cinoptions=:0
set   cursorline
set   completeopt=longest,menuone
" set noexpandtab
set expandtab
    :retab!
set   sw=4
set   sts=4
set   fileencodings=utf-8,gb2312,gbk,gb18030
set   fileformat=unix
set   foldenable
set   foldmethod=marker
set   guioptions-=T
set   guioptions-=m
set   guioptions-=r
set   guioptions-=l
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch
set   ignorecase
set   incsearch
set   laststatus=2
set   mouse=a
set   number
set   pumheight=10
set   ruler
set   scrolloff=5
set   shiftwidth=4
set   showcmd
set   smartindent
set   smartcase
set   tabstop=4
set   termencoding=utf-8
set   textwidth=80
set   whichwrap=h,l
set   wildignore=*.bak,*.o,*.e,*~
set   wildmenu
set   wildmode=list:longest,full
set nowrap

" AUTO COMMANDS: {{{1
" auto expand tab to blanks
"autocmd FileType c,cpp set expandtab
" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" SHORTCUT SETTINGS: {{{1
" Set mapleader
let mapleader=","
" Space to command mode.
nnoremap <space> :
vnoremap <space> :
" Switching between buffers.
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l
" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>

" PLUGIN SETTINGS: {{{1
" taglist.vim
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1
let g:Tlist_Show_One_File=1
let g:Tlist_WinWidth=25
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
" NERDTree.vim
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
" cscope.vim
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif
" OmniCppComplete.vim
"set nocp 
"filetype plugin on 
let g:OmniCpp_DefaultNamespaces=["std"]
let g:OmniCpp_MayCompleteScope=1
let g:OmniCpp_SelectFirstItem=2

" VimGDB.vim
if has("gdb")
	set asm=0
	let g:vimgdb_debug_file=""
	run macros/gdb_mappings.vim
endif
" LookupFile setting
let g:LookupFile_TagExpr='"./tags.filename"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0
" Man.vim
source $VIMRUNTIME/ftplugin/man.vim
" snipMate
let g:snips_author="Du Jianfeng"
let g:snips_email="cmdxiaoha@163.com"
let g:snips_copyright="SicMicro, Inc"
" plugin shortcuts
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction
nmap  <F2> :TlistToggle<cr>
nmap  <F3> :NERDTreeToggle<cr>
nmap  <F4> :MRU<cr>
nmap  <F5> <Plug>LookupFile<cr>
nmap  <F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:cw<cr>
nmap  <F9> :call RunShell("Generate tags", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")<cr>
nmap <F10> :call HLUDSync()<cr>
nmap <F11> :call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")<cr>
nmap <F12> :call RunShell("Generate cscope", "cscope -Rb")<cr>:cs add cscope.out<cr>
nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>
nmap <leader>zz <C-w>o
nmap <leader>gs :GetScripts<cr>

let Tlist_Show_One_File=0
set noswapfile
set tags+=/usr/include/tags
set tags+=./tags
map ta :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,makefile,*.mk,*.sh exec ":call SetTitle()"

func SetComment()
     call setline(1,          "/*************************************************************")
     call append(line("."),   " *   Copyright (C) ".strftime("%Y")." All rights reserved.")
     call append(line(".")+1, " *   ")
     call append(line(".")+2, " *   Descraption: TODO")
     call append(line(".")+3, " *                ")

     call append(line(".")+4, " *   FileName  : ".expand("%:t"))
     call append(line(".")+5, " *   Author    : lelongz")
     call append(line(".")+6, " *   Create    : ".strftime("%Y-%m-%d"))
     call append(line(".")+7, " *   Version   : V0.1.0")
     call append(line(".")+8, " *")
     call append(line(".")+9, "**************************************************************/")
endfunc

func SetTitle()
        if &filetype == 'make'
                "call SetComment()
                call append(line(".")+10, "")

        elseif &filetype == 'sh'
                "call SetComment()
                call append(line(".")+10,"#!/usr/bin/env sh")

        else
             call SetComment()
             if expand("%:e") == 'hpp'
              call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
              call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
              call append(line(".")+12, "#ifdef __cplusplus")
              call append(line(".")+13, "extern \"C\"")
              call append(line(".")+14, "{")
              call append(line(".")+15, "#endif")
              call append(line(".")+16, "")
              call append(line(".")+17, "#ifdef __cplusplus")
              call append(line(".")+18, "}")
              call append(line(".")+19, "#endif")
              call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

             elseif expand("%:e") == 'h'
                call append(line(".")+10, "#pragma once")
             elseif &filetype == 'c'
                      call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
             elseif &filetype == 'cpp'
                      call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
             endif
        endif
endfunc

func SetFunComment()
    call append(line("."),   "/**")
    call append(line(".")+1, " *   @brief  -")
    call append(line(".")+2, " *           -")
    call append(line(".")+3, " *   @param  -")
    call append(line(".")+4, " *   @retval -")
    call append(line(".")+5, " *   @note   none")
    call append(line(".")+6, " */")

endfunc
nmap <F7> :call SetFunComment()<cr>j<cr>o



" rust vim configure
let g:rustfmt_autosave = 1
" let g:racer_cmd = ""
set hidden
" set racer command path
let g:racer_cmd = "<path-to-racer>/target/release/racer"
" set rust src env
let $RUST_SRC_PATH="<path-to-rust-srcdir>/src/"

"set mouse-=a
