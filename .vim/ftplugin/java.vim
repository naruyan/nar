if exists("b:java_ftplugin")
    finish
endif
let b:java_ftplugin = 1

let &makeprg='ant -s build.xml'
set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
