if has("win32")
    set runtimepath=$HOME/.vim,$VIMRUNTIME
endif
set bg=dark
color zenburn
if has("win32")
    set guifont=Inconsolata:h12
elseif has("unix")
    set guifont=Inconsolata-dz\ 10
else
    set guifont=*
endif
syntax on
filetype on
filetype plugin on
filetype indent on
set nohlsearch
set incsearch
set wrapscan
set number
set hidden
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set scrolloff=3
set guioptions+=b
set cursorline
set showmatch
set completeopt=menuone,menu,longest
set noautochdir
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set ruler
set foldenable
set foldmethod=marker
set viminfo=
set showcmd
set autoread
set laststatus=2
source $VIMRUNTIME/mswin.vim

if filereadable("~/.vim/projects/projects.vim")
    source ~/.vim/projects/projects.vim
endif

if version >= 703
    set cryptmethod=blowfish
endif

let mapleader = "\\"

let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let g:Tlist_WinWidth = 24
let g:Tlist_Compact_Format = 1

call pathogen#runtime_append_all_bundles()

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

let g:NERDTreeWinSize = 24
let g:NERDTreeWinPos = "right" 
let g:NERDTreeAutoCenter = 0

let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_LocalSearchDecl = 1
let OmniCppSelectFirstItem = 2

let sessionman_save_on_exit = 0

let g:unite_enable_start_insert = 1

let g:DirDiffExcludes = "*.class, *.exe, *.swp, .*, ~*"
let g:DirDiffIgnoreCase = 1

let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_auto_delimiter = 1

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

map <Home> ^
imap <Home> <Esc>^i
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
xmap <Tab> >gv
xmap <S-Tab> <gv
smap <Tab> <C-g>>gv<C-g>
smap <S-Tab> <C-g><gv<C-g>

cmap w!! %!sudo tee > /dev/null %

nmap <Leader>tmp <Esc>:setlocal buftype=nofile<CR>:setlocal bufhidden=hide<CR>:setlocal noswapfile<CR>
nmap <Leader>cd <Esc>:cd %:p:h<CR>

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

nmap <Leader>tag <Esc>:TlistToggle<CR>
nmap <Leader>nerd <Esc>:NERDTreeToggle<CR>
nmap <Leader>exp <Esc>:SrcExplToggle<CR>

nmap <Leader>ide <Esc>:TlistToggle<CR>:NERDTreeToggle<CR><C-W>K<C-W>j<C-W>H<C-W>l<C-W>=:vertical res 24<CR><C-W>h:SrcExplToggle<CR><C-W>j<C-W>v<C-W>l<C-W>r:cope<CR>:set nobuflisted<CR><C-W>k<C-W>c<C-W>j:res 8<CR><C-W>k
nmap <leader>txt <Esc>:TlistToggle<CR>:NERDTreeToggle<CR>:SrcExplToggle<CR>
nmap <leader>min <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 1<CR>:exe bufwinnr("Source_Explorer") . "wincmd w"<CR>:res 1<CR><C-W>t
nmap <leader>max <Esc>:exe bufwinnr("__Tag_List__") . "wincmd w"<CR>:vertical res 24<CR>:exe bufwinnr("Source_Explorer") . "wincmd w"<CR>:res 8<CR><C-W>t

nmap <leader>ctags <Esc>:!ctags --sort=foldcase -R -I --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
if has("win32")
    nmap <leader>cscope :!dir *.c *.cpp *.h *.hpp /s /b > cscope > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
    nmap <leader>phpscope :!dir *.php *.phtml *.ini *.inc /s /b > cscope > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
else
    nmap <leader>cscope :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
    nmap <leader>phpscope :!find . -iname '*.php' -o -iname '*.phtml' -o -iname '*.ini' -o -iname '*.inc' > cscope.files<CR>:!cscope -b -i cscope.files -f cscope.out<CR>:cs reset<CR>
endif

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

nmap <Leader>ub <Esc>:call NEKOGetWindow()<CR>:Unite buffer<CR>
nmap <Leader>uf <Esc>:call NEKOGetWindow()<CR>:Unite file<CR>
nmap <Leader>uc <Esc>:call NEKOGetWindow()<CR>:Unite file_rec<CR>
nmap <leader>uv <Esc>:call NEKOGetWindow()<CR>:Unite buffer file_rec<CR>

cnoreabbrev <expr> unite
            \ ((getcmdtype() == ':' && getcmdpos() <= 6)? 'Unite' : 'unite')

if has('cscope')
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
    endif

    command! -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

cnoreabbrev <expr> csa
            \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
cnoreabbrev <expr> csf
            \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')

au! BufWritePost .vimrc source %
