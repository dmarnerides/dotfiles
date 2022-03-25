if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "configfile"

syntax match bdComment "\v#.*$"
highlight link bdComment Comment

syntax match bdKey "^\s*\w\+"
highlight link bdKey Identifier
