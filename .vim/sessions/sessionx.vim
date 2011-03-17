NERDTreeToggle 
close
wincmd j
let g:SrcExpl_Window = winnr()
SrcExplToggle
if exists('$' . toupper(expand("%:t:r")[:-2]) . '_DIR')
    cd '$' . toupper(expand("%:t:r")[:-2]) . '_DIR'
endif
cs add cscope.out
