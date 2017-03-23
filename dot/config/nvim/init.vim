set clipboard=unnamed,unnamedplus
if !&compatible
  set nocompatible
endif

" Tab
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Cursor
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap gj j
nnoremap gk k

" python
let g:python3_host_prog = expand('/usr/bin/python3')

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" installing dein itself
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath . "," . '~/.config/nvim/rplugin/python'
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}



"" Colorscheme
colorscheme wombat
syntax on

"" mouse
set mouse=v

"" Ctrl+C to ESC
inoremap <C-c> <ESC>

" QuickFix
map <C-n> :cn<CR>
map <C-p> :cp<CR>
""" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }

"" Unite
"let g:unite_enable_start_insert=1
"let g:unite_source_history_yank_enable =1
"let g:unite_source_file_mru_limit = 200

nnoremap [denite] <Nop>
nmap <space> [denite]
"nnoremap <silent> [denite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [denite]f :<C-u>:VimFiler -split -simple -winwidth=35 -no-quit<CR>
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [denite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [denite]m :<C-u>Denite file_mru<CR>
nnoremap <silent> [denite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [denite]g :<C-u>Denite grep<CR>

nnoremap <silent> [denite]a :<C-u>UniteBookmarkAdd<CR>
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings()"{{{
"   nmap <buffer> <ESC> <Plug>(denite_exit)
"   imap <buffer> jj <Plug>(denite_insert_leave)
"   imap <buffer> <C-w> <Plug>(denite_delete_backward_path)
"   nnoremap <silent> <buffer> <expr> <C-j> denite#do_action('split')
"   inoremap <silent> <buffer> <expr> <C-j> denite#do_action('split')
" 
"   nnoremap <silent> <buffer> <expr> <C-l> denite#do_action('vsplit')
"   inoremap <silent> <buffer> <expr> <C-l> denite#do_action('vsplit')
" 
"   nnoremap <silent> <buffer> <expr> <C-o> denite#do_action('open')
"   inoremap <silent> <buffer> <expr> <C-o> denite#do_action('open')
" endfunction"}}}

" easymotion
nmap s <Plug>(easymotion-s2)
nmap [denite]j <Plug>(easymotion-j)
nmap [denite]k <Plug>(easymotion-k)


"Snippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory='~/.config/nvim/snippets/'


" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown

" Auto Save
let g:auto_save = 1

" Copy
function! s:ClipWorkPut() range
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call system('echo "'. selected . '" | ~/lib/clipwork/bin/cput')
endfunction

command! -range Cput :call s:ClipWorkPut()


function! s:ClipWorkGet()
  read ! ~/lib/clipwork/bin/cget
endfunction

command! -range Cget :call s:ClipWorkGet()

" terminal
tnoremap <silent> <ESC> <C-\><C-n>
set hidden


function! Arch()
  terminal
  file arch
endfunction

command! Arch :call Arch()

function! Base()
  terminal
  file base
  call feedkeys("ssh base\<CR>")
endfunction

command! Base :call Base()

function! Ns()
  terminal
  file lab_n
  call feedkeys("ssh n1\<CR>")
endfunction

command! Ns :call Ns()

function! Task()
  terminal
  file task
  call feedkeys("taskshell\<CR>")
endfunction

command! Task :call Task()
