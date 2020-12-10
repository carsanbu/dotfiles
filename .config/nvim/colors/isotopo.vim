" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="isotopo"

if exists("g:isotopo_original")
    let s:isotopo_original = g:isotopo_original
else
    let s:isotopo_original = 0
endif

hi Boolean         guifg=#d84dff
hi Character       guifg=#f3e500
hi Number          guifg=#d84dff
hi String          guifg=#f3e500
hi Conditional     guifg=#ff4d4d               gui=bold
hi Constant        guifg=#d84dff               gui=bold
hi Cursor          guifg=#000000 guibg=#d0d0d0
hi iCursor         guifg=#000000 guibg=#d0d0d0
hi Debug           guifg=#d0d0d0               gui=bold
hi Define          guifg=#9cff4d
hi Delimiter       guifg=#1d2330
hi DiffAdd                       guibg=#9cff4d
hi DiffChange      guifg=#000000 guibg=#d0d0d0
hi DiffDelete      guifg=#ff4d4d guibg=#000000
hi DiffText                      guibg=#000000 gui=italic,bold

hi Directory       guifg=#9cff4d               gui=bold
hi Error           guifg=#f3e500 guibg=#1E0010
hi ErrorMsg        guifg=#ff4d4d guibg=#000000 gui=bold
hi Exception       guifg=#9cff4d               gui=bold
hi Float           guifg=#d84dff
hi FoldColumn      guifg=#4d91ff guibg=#000000
hi Folded          guifg=#4d91ff guibg=#000000
hi Function        guifg=#9cff4d
hi Identifier      guifg=#f3e500
hi Ignore          guifg=#1d2330 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#d84dff               gui=bold
hi Label           guifg=#f3e500               gui=none
hi Macro           guifg=#d0d0d0               gui=italic
hi SpecialKey      guifg=#1d2330               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#d84dff

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#9cff4d               gui=bold
hi PreProc         guifg=#9cff4d
hi Question        guifg=#66D9EF
hi Repeat          guifg=#d84dff               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
" marks
hi SignColumn      guifg=#9cff4d guibg=#232526
hi SpecialChar     guifg=#d84dff               gui=bold
hi SpecialComment  guifg=#1d2330               gui=bold
hi Special         guifg=#9cff4d guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#d84dff               gui=bold
hi StatusLine      guifg=#1d2330 guibg=fg
hi StatusLineNC    guifg=#1d2330 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#9cff4d
hi Tag             guifg=#d84dff               gui=italic
hi Title           guifg=#ff4d4d
hi Todo            guifg=#d0d0d0 guibg=bg      gui=bold

hi Typedef         guifg=#9cff4d
hi Type            guifg=#9cff4d               gui=none
hi Underlined      guifg=#1d2330               gui=underline

hi VertSplit       guifg=#1d2330 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#d0d0d0 guibg=#333333 gui=bold
hi WildMenu        guifg=#4d91ff guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

if s:isotopo_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#7E8E91
   hi CursorLine                    guibg=#293739
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#293739
   hi ColorColumn                   guibg=#232526
   hi LineNr          guifg=#465457 guibg=#232526
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
end

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
