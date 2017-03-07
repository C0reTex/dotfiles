" General settings
set encoding=utf-8
set fileencoding=utf-8

" Filetype
filetype on
filetype plugin on
"filetype indent on

"  Plugins {{{
" --------------------
call plug#begin('~/.vim/plugged')

" Integration
Plug 'scrooloose/nerdtree'              " File Explorer
Plug 'scrooloose/nerdcommenter'         " NerdCommenter, comment stuff with style
Plug 'vim-scripts/TaskList.vim'         " Tasklist collects all TODO, FIXME and XXX in a handy list.
Plug 'vim-scripts/taglist.vim'          " Taglist gives an overview of source code (functions, ...)
Plug 'suan/vim-instant-markdown'        " Instant markdown preview
Plug 'rking/ag.vim'                     " ag adcanced searching utility

" Completion
"Plug 'ervandew/supertab'                " Allows <Tab> completion for YCM as well as Ultisnip
Plug 'Valloric/YouCompleteMe'           " Auto completion
Plug 'SirVer/ultisnips'                 " Ultisnips suggests snips by entry.
Plug 'honza/vim-snippets'               " Snippets are seperate from ultisnips

" Code Display
Plug 'bronson/vim-trailing-whitespace'  " Fix Whitespaces
Plug 'junegunn/vim-easy-align'          " Easy Align - select position, RETURN, line, SPACE
Plug 'ap/vim-css-color'                 " Preview colors in source code while editing.
Plug 'elzr/vim-json'                    " prettify JSON
Plug 'ehamberg/vim-cute-python'         " display unicode characters for python operators

" Language
Plug 'scrooloose/syntastic'             " syntax checker
Plug 'kchmck/vim-coffee-script'         " Adds CoffeeScript support to vim
Plug 'lervag/vimtex'                    " Latex editor
Plug 'bkad/CamelCaseMotion'             " Adds CamelCase movement to vim

" GIT
Plug 'airblade/vim-gitgutter'           " GIT
Plug 'tpope/vim-fugitive'

" Style

" not used
" Plug 'weynhamz/vim-plugin-minibufexpl'  " MinibufExpl makes buffers accessible to every new window in vim
" Plug 'hallettj/jslint.vim'              " JSlint for vim
" Plug 'lervag/vimtex'
" Plug 'tmux-plugins/vim-tmux'            " Proper syntax highlightning for tmux.conf
" Plug 'Shougo/vimproc.vim'               " Unite depends on vimproc
" Plug 'Shougo/unite.vim'                 " File explorer
" Plug 'majutsushi/tagbar'                " Tagbar, list tags, methods, variables,...
" Plug 'vim-scripts/simple-pairs'         " Simple-Paris, adds closing parenthesis, brackets, ...
" Plug 'wincent/command-t'                " Command-T, extremly fast opening of files and stuff
" Plug 'powerline/powerline'              " Powerline

call plug#end()
" ----------------
" End of Plugins }}}

" Plugin config {{{
" ----------------

" Easy align interactive
"""
vnoremap <silent> <Enter> :EasyAlign<cr>

" Syntastic
let g:syntastic_javascript_closurecompiler_path = '~/.vim/closure-compiler/compiler.jar' " JS Validator
" let g:syntastic_html_checkers                    = ['w3']                                 " HTML Validator
let g:syntastic_tex_chktex_showmsgs              = 1

" Disable some Ruby warnings
let g:syntastic_eruby_ruby_quiet_messages =
    \ {'regex': 'possibly useless use of a variable in void context'}

" Disable some warnings
let g:syntastic_quiet_messages =
    \ {'regex': 'possible unwanted space at \"{\"'}

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Word Count with no Latex Markup and stuff
:map <F3> :w !detex \| wc -w<CR>


"" Completion
""""

" YouCompleteMe
" https://github.com/Valloric/YouCompleteMe.
let g:ycm_key_list_select_completion   = ["<tab>", "<Down>"]
let g:ycm_key_list_previous_completion = ["<s-tab>", "<Up>"]

"" UltiSnips
" Snippets can be found here:
" https://github.com/honza/vim-snippets
let g:UltiSnipsSnippetsDir         = $HOME.'/.vim/plugged/vim-snippets/UltiSnips/'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
let g:UltiSnipsEditSplit           = "vertical"
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<M-j>"
let g:UltiSnipsJumpBackwardTrigger="<M-k>"


"" Vimtex
""""
let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf =  'pdflatex -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'


"" CamelCaseMotion
""""
map <silent> ,w <Plug>CamelCaseMotion_w
map <silent> ,b <Plug>CamelCaseMotion_b
map <silent> ,e <Plug>CamelCaseMotion_e
map <silent> ,ge <Plug>CamelCaseMotion_ge

omap <silent> ,iw <Plug>CamelCaseMotion_iw
xmap <silent> ,iw <Plug>CamelCaseMotion_iw
omap <silent> ,ib <Plug>CamelCaseMotion_ib
xmap <silent> ,ib <Plug>CamelCaseMotion_ib
omap <silent> ,ie <Plug>CamelCaseMotion_ie
xmap <silent> ,ie <Plug>CamelCaseMotion_ie

"" Instant Markdown
""""
" Disable autostart of instant markdown when .md file is opened.
" Enables :InstantMarkdownPreview command in vim.
let g:instant_markdown_autostart = 0

" --------------
" End of personal config }}}

" Keybindings {{{
" --------------------

" make backspace work like most other apps
set backspace=2

" --------------------
" END of Keybindings }}}

" Style related stuff {{{
" --------------------

" enables syntax highlightning
syntax enable

" Always display the status line
set laststatus=2

" Set line numbers
set number

" display ruler on the bottom left corner
" displays line numer, column number, virtual column number and relative
" position of the cursor
set ruler

" set colorscheme
colorscheme onedark
set background=dark

" Setup line length marker at 80 characters
if (exists('+colorcolumn'))
   set colorcolumn=80
   highlight ColorColumn ctermbg=darkgray
endif

" Highlightning of the current line
set cursorline                                    " highlight current line
" hi CursorLine term=none cterm=none ctermbg=4      " adjust coloset cul



" Display unprintable chars
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" --------------------
" END of Style related stuff }}}

" Identing {{{
" --------------------
set autoindent

" insert spaces instead of tabs
set softtabstop=4
set shiftwidth=4
set expandtab

" --------------------
" End of Identing }}}

" Search {{{
" --------------------
set hlsearch " highlight all search pattern matches
set incsearch " start searching as soon as you type the first character

" With ignorecase + smartcase a pattern is only case sensitive, if it contains
" an uppercase letter.
set ignorecase
set smartcase

" --------------------
" END of Search }}}

" Usability {{{
" --------------------

" Show maching brackets
set showmatch

" enable use of {{{ and }}} to mark foldings in code
set foldmethod=marker

"Auto cd in directory of the current file
set autochdir

" Disable auto commenting
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

"This shows what you are typing as a command
set showcmd

" set history limit
set history=300

" Keeping Backups and tmp files in one place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/backup/undos
set undofile
set bk

"Commandline completion
"ex: :color <Tab>
"will expand the command line vertically and list completion suggestions
set wildmenu
set wildmode=list:longest,full

"Enable mouse support
set mouse=a

"Remove the buffer, after closing tab
set nohidden

"Open URL in browser
function! Browser()
	let line = getline (".")
	let line = matchstr (line, "http[^   ]*")
	exec "!vivaldi-stable".line
endfunction

" --------------------
" END of Usability }}}

" Remap keys {{{
" --------------------

" Map 'W' on saving an already opened file without privileges
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"Remap jj to escape in insert mode. Totaly AWESOME
inoremap jj <ESC>

nnoremap JJJJ <Nop>


" mapping : to . for easy and fast access to command-line mode
" nore . :


" Copy with STRG + C
vnoremap <C-c> "*y

" insert with STRG + V
imap <c-v> <C-r><C-p>+


" increasing and decreasing numbers
function! AddSubtract(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
endfunction
nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>

" --------------------
" END Remap Keys }}}

" spellchecking {{{
" --------------------

" # Wann geladen wird              # Maske   # Aktivieren      # Zu
" verwendende Sprache
au BufNewFile,BufRead,BufEnter   *.wiki    setlocal spell    spelllang=en_us
au BufNewFile,BufRead,BufEnter   *.md      setlocal spell    spelllang=en_us
au BufNewFile,BufRead,BufEnter   *.txt     setlocal spell    spelllang=en_us
au BufNewFile,BufRead,BufEnter   README    setlocal spell    spelllang=en_us
au BufNewFile,BufRead,BufEnter   *.tex     setlocal spell    spelllang=en_us

" --------------------
" END of spellcheching }}}

" vim:ft=vim
