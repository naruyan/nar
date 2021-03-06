" vimrc
" nar
"  
" ---------------------------------------------------------------------------
" 

" Todo {{{1
" Add controls for Vimfiler/Unite-ssh possibly
" Add more controls for neocomplcache, espesically snippets
" Vimproc autobuild? Probably not
" More use on: quickrun, surround, fugitive, nerdcommenter
" More configuration on powerline?
" Syntastic configuration
" }}}1

" Initialization {{{1
" 
" vim: set foldenable, foldmethod=marker, foldlevel=0
let s:win = has('win32') || has('win64')
let s:nix = has("unix")
let s:otheros = !s:win && !s:nix
" }}}1

" ---------------------------------------------------------------------------
" General {{{1
set nocompatible " Ensure vim mode
set noexrc " Disable local directory .*rc file sourcing
set secure " Ensure secure parsing of .*rc files if local reading is enabled
set viminfo= " Disable viminfo generation
set cpoptions=aABceFs " Ensure default Compatible Options
set hidden " Allow buffers to exist in the background
set wildmenu " Command line completion
set wildmode=list:longest " Shell style command line completion
set showcmd " Show current command being typed
set clipboard= " Only explicitly fill the windows clipboard
set backspace=indent,eol,start " Normal backspace behaviour
set noerrorbells " Disable error sounds
set novisualbell " Disable error blinking
set cmdwinheight=4 " Set command window height
set selectmode=mouse " select model when selecting with mouse
set selection=old " Do not allow selecting past the current line
set whichwrap=b,s,<,>,[,] " Allow arrow keys to move up and down lines

let mapleader = "\\" " Ensure leader is \

filetype on " Enable filetype specific config

" Windows Settings {{{2
if s:win 
    set runtimepath=$HOME/.vim,$VIMRUNTIME " Unify vimfiles location 
                                           " on Linux and Windows
endif
" }}}2

" Mapping {{{2
" Remap Q Commands
nnoremap q <NOP>

cnoremap <C-F> <C-F>i
noremap q: <NOP>
noremap q/ <NOP>
noremap q? <NOP> 

" Pasting
map <C-V> "+gP
cmap <C-V> <C-R>+
if exists('paste#paste_cmd')
    exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
    exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
else
    inoremap <C-V> <Esc>"+gPa
endif

" Undo/Redo
noremap <C-Z> u
inoremap <C-Z> <C-O>u
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Select All
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG
" }}}2

" }}}1

" Formatting {{{1
filetype indent on " Enable filetype specific indenting
set tabstop=4 " Tab size is 4
set expandtab " Use soft tabs
set shiftwidth=4 " Indent size is 4
set softtabstop=4 " Soft tab size is 4
set linespace=0 " No extra lines between rows

" Mapping {{{2
" Visual Mode Windows Mode
vnoremap <BS> d
vnoremap <C-X> "+x
vnoremap <C-C> "+y
noremap <C-Q> <C-V>

" Block tabbing
xmap <Tab> >gv
xmap <S-Tab> <gv
smap <Tab> <C-g>>gv<C-g>
smap <S-Tab> <C-g><gv<C-g>
" }}}2
" }}}1

" Navigation {{{1
set scrolljump=3 " Give at least 3 lines running off the end
set scrolloff=3 " Give 3 lines of context when scrolling
set ruler " Show cursor position

" Mapping {{{2
" Home goes to first non-whitespace character
nmap <Home> ^
imap <Home> <Esc>^i
" }}}2

" External Sources {{{2
runtime macros/matchit.vim " Extend % bracket matching
" }}}2
" }}}1

" UI {{{1
set background=dark " Use dark background settings
set number " Line numbers
set numberwidth=4 " Line number support up to 4 digits
set cursorline " Highlight current line
set laststatus=2 " Always disable the status line

" GUI Settings {{{2
if has("gui_running")
    set guioptions=rLb " Enable horizontal scroll bar, Disable Menu

    " Startup Only Settings {{{3
    if has('vim_starting')
        set columns=84 " 80 columns + line numbers
        set lines=24
    endif
    " }}}3

    " Linux Settings {{{3
    if s:nix
        set guifont=Inconsolata-dz\ 10 " Inconsolata Straight Quotes
    endif
    " }}}3

    " Windows Settings {{{3
    if s:win
        set guifont=Inconsolata:h12 " Inconsolata Hinted
    endif
    " }}}3

    " Other OS Settings {{{3
    if s:otheros
        set guifont=* " Prompt for font
    endif
    " }}}3
endif
" }}}2
" }}}1

" Files {{{1
set autoread " Automatically reload files
set fileformats=unix,dos,mac " Support all EOL formats
if exists("+autochdir")
    set noautochdir " Do not automatically cd to current file
endif

" Vim 7.3 Settings {{{2
if version >= 703
    set cryptmethod=blowfish
endif
" }}}2

" Mapping {{{2
" Windows Saving
noremap <C-S> :update <CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Sudo write
if s:nix
    cmap w!! %!sudo tee > /dev/null %
endif

" Create scratch file
nmap <C-N> <Esc>:new<CR>:only<CR>:setlocal buftype=nofile<CR>
nmap <Leader>tmp <Esc>:setlocal buftype=nofile<CR>

" Save a scratch file
command! -nargs=1  -complete=file -bang Persist setlocal buftype= | saveas<bang> <args>

cnoreabbrev <expr> pers
            \ ((getcmdtype() == ':' && getcmdpos() <= 5)? 'Pers' : 'pers')
cnoreabbrev <expr> persist
            \ ((getcmdtype() == ':' && getcmdpos() <= 8)? 'Persist' : 'persist')

" cd to current file
nmap <Leader>cd <Esc>:cd %:p:h<CR>
" }}}2
" }}}1

" Searching {{{1
set nohlsearch " Don't highlight search terms
set noincsearch " Don't start searching until the full term is entered
set wrapscan " Search wraps around the end of file
set ignorecase " Ignore case when searching
set smartcase " Selectively re-enable case sensitivity when searching
" }}}1

" Encoding {{{1
set encoding=utf-8 " UTF-8 Encoding
" }}}1

" Syntax {{{1
syntax on " Syntax highlighting
filetype plugin on " Filetype specific plugins
set showmatch " Highlight matching bracket
set matchtime=5 " Flash matching bracket for 0.5 seconds

" Autocompletion {{{2
set completeopt=menuone,menu " Autocomplete Settings:
                             " - Always display menu
                             " - Show preview window with

    " Autocommands {{{3
    " All included omnicompletion functions
    autocmd FileType ada setlocal omnifunc=adacomplete#Complete
    "autocmd FileType c setlocal omnifunc=ccomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType * if &l:omnifunc == '' | setlocal omnifunc=syntaxcomplete#Complete | endif
    " }}}3
" }}}2
" }}}1

" Folding {{{1
if has("folding")
    set foldenable " Enable folding
    set foldmethod=marker " Use markers to specify folds

" Mapping {{{2
    " Use Syntax Folding
    nmap <Leader>fs <Esc>:set foldmethod=syntax<CR>
    " Use Marker Folding
    nmap <Leader>fm <Esc>:set foldmethod=marker<CR>
" }}}2
endif
" }}}1

" Diffs {{{1
" Commands {{{2
" Diff with original file
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}2
" }}}1

" Backups {{{1
set nobackup " Do not make backups
set directory=$HOME/.vim/swp// " Store all swp files in swp dir 
                               " with full paths with % instead of /
" }}}1

" ---------------------------------------------------------------------------
" Plugin Setup {{{1

if filereadable(expand('~/.vim/bundle/neobundle.vim/autoload/neobundle.vim'))
    if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim " Place neobundle on load path
    endif

    call neobundle#rc(expand('~/.vim/bundle/')) " Run neobundle
    
    " Neobundle
    NeoBundle 'Shougo/neobundle.vim'

    " Unite
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'naruyan/unite-outline', {'depends' : 'Shougo/unite.vim'}
    NeoBundle 'Shougo/vimfiler', {'depends' : 'Shougo/unite.vim'}
    NeoBundle 'Shougo/unite-ssh', {'depends' : 'Shougo/unite.vim'}
    NeoBundle 'tsukkee/unite-help', {'depends' : 'Shougo/unite.vim'}
    NeoBundle 'tsukkee/unite-tag', {'depends' : 'Shougo/unite.vim'}
    NeoBundle 'thinca/vim-ref'

    " Neocomplcache
    NeoBundle 'Shougo/neocomplcache'

    " Misc Github
    NeoBundle 'Shougo/vimshell', {'depends' : 'Shougo/vimproc'}
    NeoBundle 'Shougo/vinarise'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'wesleyche/SrcExpl'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'Lokaltog/vim-powerline'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'scrooloose/nerdcommenter'
    NeoBundle 'mikewest/vimroom'

    " Misc vim-scripts
    NeoBundle 'DirDiff.vim'
    NeoBundle 'OmniCppComplete'
    NeoBundle 'sessionman.vim'
    NeoBundle 'taglist.vim'

    " Local bundles
    execute 'NeoBundleLocal' '~/.vim/localbundle' 
endif

" Autocommands {{{2
" au! BufWritePost .vimrc source % " Reload vimrc on write
" }}}2
" }}}1

" ---------------------------------------------------------------------------
" Plugins {{{1

" Zenburn Colorscheme {{{2
color zenburn " Zenburn color theme
" }}}2

" IDE {{{2
    " Mapping {{{3
    nmap <Leader>ide <Esc>:TlistOpen<CR>:vertical res 24<CR>:SrcExplClose<CR>:SrcExpl<CR>:exe g:SrcExpl_GetWin() "wincmd w"<CR><C-W>v<C-W>l<C-W>r:cope<CR>:set nobuflisted<CR><C-W>k<C-W>c:exe g:SrcExpl_GetWin() "wincmd w"<CR>:res 8<CR><C-W>k
    nmap <leader>txt <Esc>:TlistClose<CR>:SrcExplClose<CR>:cclose<CR>
    nmap <leader>min <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 1<CR>:exe g:SrcExpl_GetWin() "wincmd w"<CR>:res 1<CR><C-W>t
    nmap <leader>max <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 24<CR>:exe g:SrcExpl_GetWin() "wincmd w"<CR>:res 8<CR><C-W>t
    " }}}3
" }}}2

" Project {{{2
if filereadable(expand("~/.vim/projects/projects.vim"))
    source ~/.vim/projects/projects.vim
endif
" }}}2

" Tag List {{{2
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let g:Tlist_WinWidth = 24
let g:Tlist_Compact_Format = 1

    " Mapping {{{3
    nmap <Leader>tag <Esc>:TlistToggle<CR>
    " }}}3
" }}}2

" Source Explorer {{{2
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 1
let g:SrcExpl_pluginList = [
            \ "__Tag_List__",
            \ "NERD_tree_1",
            \ "Source_Explorer",
            \ "*unite*"
            \ ] 
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 0
let g:SrcExpl_isUpdateTags = 0

    " Mapping {{{3
    nmap <Leader>exp <Esc>:SrcExplToggle<CR>
    " }}}3
" }}}2

" OmniCppComplete {{{2
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_LocalSearchDecl = 1
let OmniCppSelectFirstItem = 2
" }}}2

" Session Manager {{{2
let sessionman_save_on_exit = 0

    " Mapping {{{3
    nmap <Leader>session <Esc>:SessionList<CR>
    nmap <Leader>proj <Leader>session
    " }}}3
" }}}2

" Unite {{{2
let g:unite_enable_start_insert = 1

    " Mapping {{{3
    nmap <Leader>ub <Esc>:call NEKOGetWindow()<CR>:Unite buffer<CR>
    nmap <Leader>uf <Esc>:call NEKOGetWindow()<CR>:Unite file file/new<CR>
    nmap <Leader>uc <Esc>:call NEKOGetWindow()<CR>:Unite file_rec<CR>
    nmap <leader>uv <Esc>:call NEKOGetWindow()<CR>:Unite buffer file_rec<CR>

    imap <C-F> <Esc>:call NEKOGetWindow()<CR>:Unite buffer file_rec<CR>
    nmap <C-F> <Esc>:call NEKOGetWindow()<CR>:Unite buffer file_rec<CR>

    imap <C-B> <Esc>:call NEKOGetWindow()<CR>:Unite source<CR>
    nmap <C-B> <Esc>:call NEKOGetWindow()<CR>:Unite source<CR>

    imap <C-B><C-B> <Esc>:call NEKOGetWindow()<CR>:Unite buffer<CR>
    nmap <C-B><C-B> <Esc>:call NEKOGetWindow()<CR>:Unite buffer<CR>

    imap <C-B><C-F> <Esc>:call NEKOGetWindow()<CR>:Unite file file/new<CR>
    nmap <C-B><C-F> <Esc>:call NEKOGetWindow()<CR>:Unite file file/new<CR>

    imap <C-B><C-C> <Esc>:call NEKOGetWindow()<CR>:Unite outline<CR>
    nmap <C-B><C-C> <Esc>:call NEKOGetWindow()<CR>:Unite outline<CR>
    " }}}3

    " Abbreviations {{{3
    cnoreabbrev <expr> unite
                \ ((getcmdtype() == ':' && getcmdpos() <= 6)? 'Unite' : 'unite')
    " }}}3

    " Functions {{{3
    function! NEKOGetWindow()
        let fwin_num = 0
        let first_usable_win = 0

        let curwin = winnr()
        let curbuf = winbufnr(curwin)
        if getbufvar(curbuf, '&buftype') == '' &&
                    \ !getwinvar(curwin, '&previewwindow')
            return
        endif

        let i = 1
        let bnum = winbufnr(i)
        while bnum != -1
            if getbufvar(bnum, '&buftype') == '' &&
                        \ !getwinvar(i, '&previewwindow')
                let fwin_num = i
                break
            endif
            let i = i + 1
            let bnum = winbufnr(i)
        endwhile

        if fwin_num != 0
            exe fwin_num . "wincmd w"
        endif
    endfunction
    " }}}3
" }}}2

" DirDiff {{{2
let g:DirDiffExcludes = "*.class, *.exe, *.swp, .*, ~*"
let g:DirDiffIgnoreCase = 1
" }}}2

" NeoComplCache {{{2
let g:neocomplcache_enable_at_startup = 1 " Enable neocomplcache

" Autocomplete at 3 letters
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_min_syntax_length = 3

let g:neocomplcache_enable_ignore_case = 1 " Ignore case when completing
let g:neocomplcache_enable_smart_case = 1 " Selectively ignore case

let g:neocomplcache_enable_auto_select = 0 " Do Not Auto select the first canidate
let g:neocomplcache_enable_auto_delimiter = 1 " Insert delimiters automatically

" Enable abbreviation completions
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" Use dictionary for autocompletion caches
let g:neocomplcache_dictionary_filetype_lists = {}

" Disable select mode mappings
let g:neocomplcache_disable_select_mode_mappings = 1

" Enable heavy omni completion for all default disabled completions
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    " Mapping {{{3
    " <C-h>, <BS>: close popup and delete backword char.
"    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"    inoremap <expr><C-y>  neocomplcache#close_popup()
"    inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " }}}3

" }}}2

" Ctags {{{2
    " Mapping {{{3
    nmap <leader>ctags <Esc>:!ctags --sort=foldcase -R --c++-kinds=+pl --python-kinds=-i --java-kinds=+l --fields=+iaS --extra=+q <C-R>=getcwd()<CR><CR>
    " }}}3
" }}}2

" Cscope {{{2
if has('cscope')
    set cscopetag cscopeverbose

    if executable('mlcscope')
        set cscopeprg=mlcscope " Use mlcscope if it exists
    endif

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
    endif
endif

    " Mapping {{{3
        " Windows Mapping {{{4
        if s:win
            nmap <leader>csc :!dir *.c *.cpp *.h *.hpp *.asm *.s /s /b > cscope.files<CR>
            nmap <leader>csphp :!dir *.php *.phtml *.ini *.inc /s /b > cscope.files<CR>
            nmap <leader>csjava :!dir *.java /s /b > cscope.files<CR>
            nmap <leader>cspy :!dir *.py /s /b > cscope.files<CR>

            nmap <leader>csac :!dir *.c *.cpp *.h *.hpp *.asm *.s /s /b >> cscope.files<CR>
            nmap <leader>csaphp :!dir *.php *.phtml *.ini *.inc /s /b >> cscope.files<CR>
            nmap <leader>csajava :!dir *.java /s /b >> cscope.files<CR>
            nmap <leader>csapy :!dir *.py /s /b >> cscope.files<CR>
        endif
        " }}}4
        " Linux Mapping {{{4
        if s:nix
            nmap <leader>csc :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.asm' -o -iname '*.s' > cscope.files<CR>
            nmap <leader>csphp :!find . -iname '*.php' -o -iname '*.phtml' -o -iname '*.ini' -o -iname '*.inc' > cscope.files<CR>
            nmap <leader>csjava :!find . -iname '*.java' > cscope.files<CR>
            nmap <leader>cspy :!find . -iname '*.py' > cscope.files<CR>


            nmap <leader>csac :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.asm' -o -iname '*.s' >> cscope.files<CR>
            nmap <leader>csaphp :!find . -iname '*.php' -o -iname '*.phtml' -o -iname '*.ini' -o -iname '*.inc' >> cscope.files<CR>
            nmap <leader>csajava :!find . -iname '*.java' >> cscope.files<CR>
            nmap <leader>csapy :!find . -iname '*.py' >> cscope.files<CR>

        endif
        " }}}4

        if executable('mlcscope')
            nmap <leader>cscope :!mlcscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>cppscope :!mlcscope -b -i cscope.files -f cscope.out -m c++<CR>:cs reset<CR>
            nmap <leader>javascope :!mlcscope -b -i cscope.files -f cscope.out -m java<CR>:cs reset<CR>
        else
            nmap <leader>cscope :!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>cppscope <leader>cscope<CR>
            nmap <leader>javascope <leader>cscope<CR>
        endif
    " }}}3

    " Abbreviations {{{3
    cnoreabbrev <expr> csa
                \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
    cnoreabbrev <expr> csf
                \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
    " }}}3
" }}}2

" Powerline {{{2
let g:Powerline_symbols = 'unicode' " Use unicode symbols instead of patched fonts

let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'zenburn'
let g:Powerline_stl_path_style = 'relative'
" }}}2

" Vimfiler {{{2
let g:vimfiler_as_default_explorer = 1
" }}}2

" Vinarise {{{2
let g:vinarise_enable_auto_detect = 1
" }}}2

" Vimroom {{{2
let g:vimroom_guibackground = "#3f3f3f"
let g:vimroom_width = 120
" }}}2

" Vimshell {{{2
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_enable_smart_case = 1

" Windows Settings
if s:win
    let g:vimshell_prompt = $USERNAME. "% "
endif
" Linux Settings
if s:nix
    let g:vimshell_prompt = $USER . "% "
endif

" }}}2
" }}}1

