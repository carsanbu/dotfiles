" Normal mode                                    " guifg guibg ctermfg ctermbg
let s:N1 = [ '#000000' , '#57b2d9' , 250 , 97  ]
let s:N2 = [ '#000000' , '#9cff4d' , 170 , 239 ]
let s:N3 = [ '#c6c6c6' , '#000000' , 251 , 237 ]

" Insert mode
let s:I1 = [ '#000000' , '#9cff4d' , 253 , 35  ]
let s:I2 = [ '#000000' , '#f3e500' , 170 , 239 ]
let s:I3 = [ '#c6c6c6' , '#000000' , 251 , 237 ]

" Visual mode
let s:V1 = [ '#000000' , '#d84dff' , 52 , 205 ]

" Replace mode
let s:RE = [ '#c6c6c6' , '#ff0150' , 251, 168 ]

let g:airline#themes#tritium#palette = {}

let g:airline#themes#tritium#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#tritium#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#tritium#palette.insert_replace = {
            \ 'airline_a': [ s:RE[0]   , s:I1[1]   , s:RE[1]   , s:I1[3]   , ''     ] }

let g:airline#themes#tritium#palette.visual = {
            \ 'airline_a': [ s:V1[0]   , s:V1[1]   , s:V1[2]   , s:V1[3]   , ''     ] }

let g:airline#themes#tritium#palette.replace = copy(g:airline#themes#tritium#palette.normal)
let g:airline#themes#tritium#palette.replace.airline_a = [ s:RE[0] , s:RE[1] , s:RE[2] , s:RE[3] , '' ]

let s:IA = [ s:N1[1] , s:N3[1] , s:N1[3] , s:N3[3] , '']
let g:airline#themes#tritium#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

" Warnings
let g:airline#themes#tritium#palette.normal.airline_warning = s:I2

let g:airline#themes#tritium#palette.insert.airline_warning =
      \ g:airline#themes#tritium#palette.normal.airline_warning
"
let g:airline#themes#tritium#palette.visual.airline_warning =
      \ g:airline#themes#tritium#palette.normal.airline_warning

let g:airline#themes#tritium#palette.replace.airline_warning =
      \ g:airline#themes#tritium#palette.normal.airline_warning

" Errors
let g:airline#themes#tritium#palette.normal.airline_error = s:RE

let g:airline#themes#tritium#palette.insert.airline_error =
      \ g:airline#themes#tritium#palette.normal.airline_error

let g:airline#themes#tritium#palette.visual.airline_error =
      \ g:airline#themes#tritium#palette.normal.airline_error

let g:airline#themes#tritium#palette.replace.airline_error =
      \ g:airline#themes#tritium#palette.normal.airline_error
