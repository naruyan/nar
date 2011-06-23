" vimrc
" nar
" ---------------------------------------------------------------------------
" 

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
set clipboard+=unnamed " Share windows clipboard
set backspace=indent,eol,start " Normal backspace behaviour
set noerrorbells " Disable error sounds
set novisualbell " Disable error blinking

let mapleader = "\\" " Ensure leader is \

filetype on " Enable filetype specific config

" Windows Settings {{{2
if s:win 
    set runtimepath=$HOME/.vim,$VIMRUNTIME " Unify vimfiles location 
                                           " on Linux and Windows
endif
" }}}2

" External Sources {{{2
source $VIMRUNTIME/mswin.vim " Enable windows bindings
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
map <Home> ^
imap <Home> <Esc>^i
" }}}2

" External Sources {{{2
runtime macros/matchit.vim " Extend % bracket matching
" }}}2
" }}}1

" UI {{{1
set background=dark " Use dark background settings
color zenburn " Zenburn color theme
set number " Line numbers
set cursorline " Highlight current line
set laststatus=2 " Always disable the status line

" GUI Settings {{{2
set guioptions+=b " Enable horizontal scroll bar

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
" }}}2
" }}}1

" Files {{{1
set noautoread " Do not automatically reload files
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
" Sudo write
cmap w!! %!sudo tee > /dev/null %
" Create scratch file
nmap <Leader>tmp <Esc>:setlocal buftype=nofile<CR>:setlocal bufhidden=hide<CR>:setlocal noswapfile<CR>
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
" Setup {{{1
call pathogen#runtime_append_all_bundles() " Load all plugin bundles

helptags $HOME/.vim/doc " Tag all help files
call pathogen#helptags() " Tag all plugin bundle help files

" Autocommands {{{2
au! BufWritePost .vimrc source % " Reload vimrc on write
" }}}2
" }}}1

" ---------------------------------------------------------------------------
" Plugins {{{1
" IDE {{{2
    " Mapping {{{3
    nmap <Leader>ide <Esc>:TlistToggle<CR>:NERDTreeToggle<CR><C-W>K<C-W>j<C-W>H<C-W>l<C-W>=:vertical res 24<CR><C-W>h:SrcExplToggle<CR><C-W>j<C-W>v<C-W>l<C-W>r:cope<CR>:set nobuflisted<CR><C-W>k<C-W>c<C-W>j:res 8<CR><C-W>k
    nmap <leader>txt <Esc>:TlistToggle<CR>:NERDTreeToggle<CR>:SrcExplToggle<CR>
    nmap <leader>min <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 1<CR>:exe bufwinnr("Source_Explorer") . "wincmd w"<CR>:res 1<CR><C-W>t
    nmap <leader>max <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 24<CR>:exe bufwinnr("Source_Explorer") . "wincmd w"<CR>:res 8<CR><C-W>t
    " }}}3
" }}}2

" Project {{{2
if filereadable("~/.vim/projects/projects.vim")
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
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_isUpdateTags = 0

    " Mapping {{{3
    nmap <Leader>exp <Esc>:SrcExplToggle<CR>
    " }}}3
" }}}2

" NERDTree {{{2
let g:NERDTreeWinSize = 24
let g:NERDTreeWinPos = "right" 
let g:NERDTreeAutoCenter = 0

    " Mapping {{{3
    nmap <Leader>nerd <Esc>:NERDTreeToggle<CR>
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
    nmap <Leader>uf <Esc>:call NEKOGetWindow()<CR>:Unite file<CR>
    nmap <Leader>uc <Esc>:call NEKOGetWindow()<CR>:Unite file_rec<CR>
    nmap <leader>uv <Esc>:call NEKOGetWindow()<CR>:Unite buffer file_rec<CR>
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
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_min_syntax_length = 3

let g:neocomplcache_enable_ignore_case = 1 " Ignore case when completing
let g:neocomplcache_enable_smart_case = 1 " Selectively ignore case

let g:neocomplcache_enable_auto_select = 1 " Auto select the first canidate
let g:neocomplcache_enable_auto_delimiter = 1 " Insert delimiters automatically

" Enable abbreviation completions
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" Use dictionary for autocompletion caches
let g:neocomplcache_dictionary_filetype_lists = {}

" Disable select mode mappings
let g:neocomplcache_disable_select_mode_mappings = 1

" Enable heavy omni completion.
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
    nmap <leader>ctags <Esc>:!ctags --sort=foldcase -R -I --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
    " }}}3
" }}}2

" Cscope {{{2
if has('cscope')
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
    endif
endif

    " Mapping {{{3
        " Windows Mapping {{{4
        if s:win
            nmap <leader>asmscope :!dir *.c *.cpp *.h *.hpp *.asm /s /b > cscope > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>cscope :!dir *.c *.cpp *.h *.hpp /s /b > cscope > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>phpscope :!dir *.php *.phtml *.ini *.inc /s /b > cscope > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
        endif
        " }}}4
        " Linux Mapping {{{4
        if s:nix
            nmap <leader>asmscope :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' -o -iname '*.asm' > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>cscope :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
            nmap <leader>phpscope :!find . -iname '*.php' -o -iname '*.phtml' -o -iname '*.ini' -o -iname '*.inc' > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
        endif
        " }}}4
    " }}}3

    " Abbreviations {{{3
    cnoreabbrev <expr> csa
                \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
    cnoreabbrev <expr> csf
                \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
    " }}}3
" }}}2
" }}}1

