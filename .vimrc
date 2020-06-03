set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
filetype plugin indent on


" Show line numbers
set number
set relativenumber

set encoding=utf-8

"Highlight matching search patterns
set hlsearch

syntax on

set guifont=Consolas:h10
" Vim-plug
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Settings for UltiSnips
" The following directories are in ~/.vim, where ~ expands to the home
" direcotry of the current user in WSL if you are using WSL
" UltiSnips snippets are all over the place, the first one is for
" UltiSnipsEdit command, the second is where the plugin actually stores the
" default third party snippets.
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/UltiSnips", "UltiSnips"]
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" setting empty tex file to latex so that vim-snippets will recognize it
" check  https://github.com/honza/vim-snippets/issues/552
let g:tex_flavor="latex"

" Vimtex
" Plug 'lervag/vimtex'
" Fast fold
Plug 'konfekt/fastfold'
let g:tex_fold_enabled=1
" On-demand loading
Plug 'scrooloose/nerdtree'
", { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Darcula scheme
Plug 'dracula/vim', { 'as': 'dracula' }

" Jedi vim
Plug 'davidhalter/jedi-vim'

" Surround
Plug 'tpope/vim-surround'

" Unimpaired
Plug 'tpope/vim-unimpaired'

" Git
Plug 'tpope/vim-fugitive'
" diff changes
Plug 'vim-scripts/diffchanges.vim'

" Conda vim
Plug 'cjrh/vim-conda'

" Python format
Plug 'Chiel92/vim-autoformat'
" Initialize plugin system
call plug#end()

"auto start NerdTree
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
" set terminal to use gui colors
set tgc
colorscheme dracula

" statusline

function! ActiveStatus()
  let statusline=""
  let statusline.="%1*"
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
  let statusline.="%2*"
  let statusline.=""
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
  let statusline.="%3*"
  let statusline.=""
  let statusline.="%4*"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="%3*"
  let statusline.="\ "
  let statusline.="%2*"
  let statusline.=""
  let statusline.="%1*"
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ '}"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="\ \ "
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

set laststatus=2
set statusline=%!ActiveStatus()
hi User1 guibg=#afd700 guifg=#005f00
hi User2 guibg=#005f00 guifg=#afd700
hi User3 guibg=#222222 guifg=#005f00
hi User4 guibg=#222222 guifg=#d0d0d0

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
  autocmd ColorScheme kalisi if(&background=="dark") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  autocmd ColorScheme kalisi if(&background=="dark") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  autocmd ColorScheme kalisi if(&background=="dark") | hi User3 guibg=#222222 guifg=#005f00 | endif
  autocmd ColorScheme kalisi if(&background=="dark") | hi User4 guibg=#222222 guifg=#d0d0d0 | endif
  autocmd ColorScheme kalisi if(&background=="light") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  autocmd ColorScheme kalisi if(&background=="light") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  autocmd ColorScheme kalisi if(&background=="light") | hi User3 guibg=#707070 guifg=#005f00 | endif
  autocmd ColorScheme kalisi if(&background=="light") | hi User4 guibg=#707070 guifg=#d0d0d0 | endif
augroup END
" This tries to solve the missing nerd tree icon error
" let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Note this only works in linux because of the clear comman.
map <F9> <Esc>:w<CR>:!clear;python %<CR>

" Run auto format to format code.
noremap <F3> :Autoformat<CR>
" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F5> :!"/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "%"<CR>'
" Render latex files with Miktex
" for output directory, do not use %:p:h because :p will add /mnt/ to the
" path, which is not wanted
autocmd BufEnter *.tex exe 'noremap <F5> <Esc>:w<CR>:!"/mnt/c/Users/thoma/AppData/Local/Programs/MiKTeX 2.9/miktex/bin/x64/miktex-pdflatex.exe" -shell-escape "%" -output-directory="%:h" -aux-directory="%:h/tobedeleted"<CR> | imap <F5> <Esc>:w<CR><F5>'
" Remap <F5> in insert mode to <F5> in normal mode
" autocmd BufEnter *.tex exe 'imap <F5> <Esc>:w<CR><F5>'

" Let nerdtree show line numbers
let NERDTreeShowLineNumbers=1
" use relative line numbers in nerd tree
autocmd FileType nerdtree setlocal relativenumber

" Enable true color 启用终端24位色
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
