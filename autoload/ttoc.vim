" @Author:      Tom Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Last Change: 2015-11-06.
" @Revision:    143

" call tlog#Log('Load: '. expand('<sfile>')) " vimtlib-sfile


" Markers as used by vim and other editors. Can be also buffer-local. 
" This rx is added to the filetype-specific rx.
" Values:
"   0      ... disable
"   1      ... use &foldmarker
"   2      ... use &foldmarker only if &foldmethod == marker
"   string ... use as rx
TLet g:ttoc_markers = 1

" By default, assume that everything at the first column is important.
TLet g:ttoc_rx = '^\w.*'

" TLet g:ttoc_markers = '.\{-}{{{.*'


" Filetype-specific rx "{{{2

" :doc:
" Some filetype-specific regexps. If you don't like the default values, 
" set these variables in ~/.vimrc.

TLet g:ttoc_rx_bib    = '^@\w\+\s*{\s*\zs\S\{-}\ze\s*,'
TLet g:ttoc_rx_c      = '^[[:alnum:]#].*'
TLet g:ttoc_rx_cpp    = g:ttoc_rx_c
TLet g:ttoc_rx_help   = '^\(.\{-}\~\|\s*\*.\{-}\*\s*\)$'
TLet g:ttoc_rx_html   = '\(<h\d.\{-}</h\d>\|<\(html\|head\|body\|div\|script\|a\s\+name=\).\{-}>\|<.\{-}\<id=.\{-}>\)'
TLet g:ttoc_rx_java   = '^\s*\(\(package\|import\|private\|public\|protected\|void\|int\|boolean\)\s\+\|\u\).*'
TLet g:ttoc_rx_javascript = '^\(var\s\+.\{-}\|\s*\w\+\s*:\s*\S.\{-}[,{]\)\s*$'
TLet g:ttoc_rx_markdown = '\(^.*\ze\n[-=]\+$\|^#\+\s\+.*\)'
TLet g:ttoc_rx_perl   = '^\([$%@]\|\s*\(use\|sub\)\>\).*'
TLet g:ttoc_rx_php    = '^\(\w\|\s*\(class\|function\|var\|require\w*\|include\w*\)\>\).*'
TLet g:ttoc_rx_python = '^\s*\(import\|class\|def\)\>.*'
TLet g:ttoc_rx_rd     = '^\(=\+\|:\w\+:\).*'
TLet g:ttoc_rx_ruby   = '\C^\(if\>\|\s*\(class\|module\|def\|require\|private\|public\|protected\|module_functon\|alias\|attr\(_reader\|_writer\|_accessor\)\?\)\>\|\s*[[:upper:]_]\+\s*=\).*'
TLet g:ttoc_rx_scheme = '^\s*(define.*'
TLet g:ttoc_rx_sh     = '^\s*\(\(export\|function\|while\|case\|if\)\>\|\w\+\s*()\s*{\).*'
TLet g:ttoc_rx_sql    = '^\c\(select\|create\|if\)\>.*'
TLet g:ttoc_rx_tcl    = '^\s*\(source\|proc\)\>.*'
TLet g:ttoc_rx_tex    = '\C\\\(label\|\(sub\)*\(section\|paragraph\|part\)\)\>.*'
TLet g:ttoc_rx_viki   = '^\(\*\+\|\s*#\l\).*'
TLet g:ttoc_rx_vim    = '\C^\(\s*fu\%[nction]!\?\|\s*com\%[mand]!\?\|if\|wh\%[ile]\)\>.*'

" TLet g:ttoc_rx_vim    = '\C^\(\(fu\|if\|wh\).*\|.\{-}\ze\("\s*\)\?{{{.*\)'
" TLet g:ttoc_rx_ocaml  = '^\(let\|module\|\s*let .\{-}function\).*'


" :nodefault:
" ttoc-specific |tlib#input#ListD| configuration.
" Customizations should be done in ~/.vimrc/after/plugin/ttoc.vim
" E.g. in order to split horizontally, use: >
"     let g:ttoc_world.scratch_vertical = 0
TLet g:ttoc_world = {
                \ 'type': 'm',
                \ 'query': 'Select entry',
                \ 'pick_last_item': 0,
                \ 'scratch': '__ttoc:%s__',
                \ 'retrieve_eval': 'ttoc#Collect(world, 0)',
                \ 'return_agent': 'ttoc#GotoLine',
                \ 'key_handlers': [
                    \ {'key': 16, 'agent': 'tlib#agent#PreviewLine',  'key_name': '<c-p>', 'help': 'Preview'},
                    \ {'key':  7, 'agent': 'ttoc#GotoLine',     'key_name': '<c-g>', 'help': 'Jump (don''t close the TOC window)'},
                    \ {'key': 60, 'agent': 'ttoc#GotoLine',     'key_name': '<',     'help': 'Jump (don''t close the TOC window)'},
                    \ {'key':  5, 'agent': 'tlib#agent#DoAtLine',     'key_name': '<c-e>', 'help': 'Run a command on selected lines'},
                    \ {'key': "\<c-insert>", 'agent': 'ttoc#SetFollowCursor', 'key_name': '<c-ins>', 'help': 'Toggle trace cursor'},
                    \ {'key': 28, 'agent': 'tlib#agent#ToggleStickyList',       'key_name': '<c-\>', 'help': 'Toggle sticky'},
                \ ],
            \ }
            " \ {'key': 19, 'agent': 'ttoc#ChangeSortOrder', 'key_name': '<c-s>', 'help': 'Change sort order'},
            " \ 'scratch_vertical': (&lines > &co),


" If true, split vertical.
TLet g:ttoc_vertical = '&lines < &co'
" TLet g:ttoc_vertical = -1
" TLet g:ttoc_vertical = 0

" Vim code that evaluates to the desired window width/heigth.
TLet g:ttoc_win_size = 'min([60, ((&lines > &co) ? &lines : &co) / 2])'
" TLet g:ttoc_win_size = '((&lines > &co) ? winheight(0) : winwidth(0)) / 2'

" Events in the source buffer that result in a |:bwipeout| of the 
" respective ttoc buffer.
TLet g:ttoc#scratch#wipeout = 'BufDelete,BufWipeout' . (&hidden ? '' : ',BufHidden')

" function! TToC_GetLine_vim(lnum, acc) "{{{3
"     let l = a:lnum
"     while 1
"         let l -= 1
"         let t = getline(l)
"         if !empty(t) && t =~ '^\s*"'
"             let t = matchstr(t, '"\s*\zs.*')
"             TLogVAR t
"             call insert(a:acc, t, 1)
"         else
"             break
"         endif
"     endwh
"     return l
" endf


function! TToC_GetLine_viki(lnum, acc) "{{{3
    let l = a:lnum
    while 1
        let l += 1
        let t = getline(l)
        if !empty(t)
            if t[0] == '#'
                call add(a:acc, t)
            elseif t =~ '\s\+::\s\+'
                call add(a:acc, t)
            else
                break
            end
        else
            break
        endif
    endwh
    return l
endf


function! TToC_GetLine_bib(lnum, acc) "{{{3
    for l in range(a:lnum + tlib#string#Count(a:acc[0], '\n'), a:lnum + 4)
        let t = getline(l)
        if !empty(t)
            call add(a:acc, t)
        endif
    endfor
    return a:lnum + 5
endf


augroup TToC
    autocmd!
augroup END



" :def: function! ttoc#Collect(world, return_index, ?additional_lines=0)
function! ttoc#Collect(world, return_index, ...) "{{{3
    TVarArg ['additional_lines', 0]
    " TLogVAR additional_lines
    let pos = getpos('.')
    " let view = winsaveview()
    let s:accum = []
    let s:table  = []
    let s:current_line = line('.')
    let s:line_format  = '%0'. len(line('$')) .'d'
    let s:current_index = 0
    let s:additional_lines = additional_lines
    let s:rx = a:world.ttoc_rx
    let rs  = @/
    let s:next_line = 1
    let s:multiline = a:world.ttoc_rx =~ '\\\@<!\\\(_\.\|n\)'
    let s:world = a:world

    try
        if !empty(a:world.ttoc_expr)
            let expr_result = eval(a:world.ttoc_expr)
            if type(expr_result) == type('')
                let line_numbers = split(expr_result, "\n")
            else
                let line_numbers = expr_result
            endif
            if s:multiline
                for l in line_numbers
                    exec 'keepjumps' l 'call s:ProcessLine(line("."))'
                endfor
            else
                for l in line_numbers
                    call s:ProcessLine(l)
                endfor
            endif
        else
            exec 'keepjumps g /'. escape(a:world.ttoc_rx, '/') .'/call s:ProcessLine(line("."))'
        end
    finally
        let @/ = rs
    endtry

    call setpos('.', pos)
    " call winrestview(view)
    " let a:world.index_table = s:table
    if a:return_index
        return [s:accum, s:current_index]
    else
        return s:accum
    endif
endf


function! s:ProcessLine(lnum) "{{{3
    " TLogVAR a:lnum
    if a:lnum >= s:next_line

        let linesplus = 1
        " call TLogDBG("s:multiline=". s:multiline)
        if s:multiline
            let pos = getpos('.')
            " let view = winsaveview()
            keepjumps let endline = search(s:world.ttoc_rx, 'ceW')
            " TLogVAR endline
            if endline == 0
                " shouldn't be here
                let t = matchstr(getline(a:lnum)
            else
                let t = [join(getline(a:lnum, endline), "\n")]
                let linesplus += (endline - a:lnum)
            endif
            call setpos('.', pos)
            " call winrestview(view)
        else
            let t = [matchstr(getline(a:lnum), s:rx)]
        endif
        " TLogVAR t
        let s:next_line = a:lnum + linesplus
        if exists('*TToC_GetLine_'.&filetype)
            let next_line = TToC_GetLine_{&filetype}(a:lnum, t)
            if next_line > s:next_line
                let s:next_line = next_line
            endif
        endif

        if s:additional_lines > 0
            let next_line = s:next_line + s:additional_lines
            for i in range(s:next_line, next_line - 1)
                " TLogVAR i
                let lt = getline(i)
                if lt =~ '\S'
                    call add(t, lt)
                endif
            endfor
            let s:next_line = next_line
        endif

        let i = printf(s:line_format, a:lnum) .': '. substitute(join(t, ' | '), repeat('\s', &sw), ' ', 'g')
        " TLogVAR i
        " let i = substitute(join(t, ' | '), '\s\+', ' ', 'g')
        call add(s:accum, i)
        " call add(s:table, a:lnum)
        if a:lnum <= s:current_line
            let s:current_index += 1
        endif

    endif
    " call TLogDBG("s:next_line=". s:next_line)
endf


function! ttoc#GotoLine(world, selected) "{{{3
    " TLogVAR a:selected
    if empty(a:selected)
        call a:world.RestoreOrigin()
        return a:world
    else
        " call a:world.SetOrigin()
        return tlib#agent#GotoLine(a:world, a:selected)
    endif
endf


" :def: function! ttoc#View(rx, ?partial_rx=0, ?v_count=0, ?p_count=0, ?background=0)
function! ttoc#View(rx, ...) "{{{3
    " TLogVAR a:rx
    TVarArg ['partial_rx', 0], ['v_count', 0], ['p_count', 0], ['background', 0]
    let additional_lines = v_count ? v_count : p_count ? p_count : 0
    " TLogVAR partial_rx, additional_lines, v_count, p_count
    let ft = &filetype

    if empty(a:rx)
        let expr = s:DefaultExpr(ft)
        if empty(expr)
            let rx = s:DefaultRx(ft)
        else
            let rx = '\s*.*'
        endif
    else
        let expr = ''
        let rx = a:rx
        if partial_rx
            let rx = '^.\{-}'. rx .'.*$'
        end
    endif
    " TLogVAR rx

    if empty(rx)
        echoerr 'TToC: No regexp given'
    else
        " TLogVAR ac
        let w = copy(g:ttoc_world)
        if w.scratch =~ '%s'
            " let w.scratch = printf(w.scratch, pathshorten(expand('%:p')))
            let w.scratch = substitute(printf(w.scratch, expand('%:p')), '\W', '_', 'g')
            exec 'autocmd TToC' g:ttoc#scratch#wipeout '<buffer> call s:DeleteBuffer(bufnr(expand("<abuf>")),'. string(w.scratch) .')'
        endif
        if exists('g:ttoc_world_'. ft)
            for [key, val] in items(g:ttoc_world_{ft})
                if has_key(w, key)
                    if type(val) == 3
                        let w[key] += val
                    elseif type(val) == 4
                        let w[key] = extend(w[key], val)
                    else
                        let w[key] = copy(val)
                    endif
                else
                    let w[key] = copy(val)
                endif
            endfor
        endif
        let w.ttoc_rx = rx
        let w.ttoc_expr = expr
        let [ac, ii] = ttoc#Collect(w, 1, additional_lines)
        " TLogVAR ac
        let acc = []
        let bn  = bufnr('%')
        let i = 1
        for item in ac
            call add(acc, {'bufnr': bn, 'lnum': matchstr(item, '^0*\zs\d\+'), 'text': i .': '. rx})
            let i += 1
        endfor
        call setloclist(winnr(), acc)
        let w.initial_index = ii
        let w.base = ac
        let win_size = tlib#var#Get('ttoc_win_size', 'wbg')
        if !empty(win_size)
            " TLogDBG tlib#cmd#UseVertical('TToC')
            " TLogVAR win_size, g:ttoc_vertical
            let use_vertical = eval(g:ttoc_vertical)
            if use_vertical == 1 || (use_vertical == -1 && tlib#cmd#UseVertical('TToC'))
                let w.scratch_vertical = 1
                if get(w, 'resize_vertical', 0) == 0
                    let w.resize_vertical = eval(win_size)
                endif
            else
                if get(w, 'resize', 0) == 0
                    let w.resize = eval(win_size)
                endif
            endif
        endif
        " TLogVAR w.resize_vertical, w.resize
        " let world = tlib#World#New(a:dict)
        if partial_rx && !empty(a:rx)
            " call world.SetInitialFilter(a:rx)
            let w.tlib_UseInputListScratch = '2match IncSearch /'. escape(a:rx, '/') .'/'
        endif
        if background
            let w.next_state = 'suspend'
        endif
        " call tlib#input#ListW(world)
        call tlib#input#ListD(w)
    endif
endf


function! s:DeleteBuffer(bufnr, scratch) "{{{3
    silent! exec 'bwipeout' bufnr(a:scratch)
    silent! exec 'autocmd! TToC' g:ttoc#scratch#wipeout '<buffer='. a:bufnr .'>'
endf


function! s:DefaultRx(filetype) "{{{3
    let rx = tlib#var#Get('ttoc_rx_'. a:filetype, 'wbg')
    if empty(rx)
        let rx = tlib#var#Get('ttoc_rx', 'wbg')
    endif
    let marker = tlib#var#Get('ttoc_markers', 'wbg')
    if !empty(marker)
        if type(marker) == 0
            if marker == 1 || (marker == 2 && &foldmethod == 'marker')
                let [open, close] = split(&foldmarker, ',', 1)
                if !empty(open)
                    let rx  = printf('\(%s\|.\{-}%s.*\)', rx, tlib#rx#Escape(open))
                endif
            endif
        else
            let rx = printf('\(%s\|%s\)', rx, marker)
        endif
    endif
    return rx
endf

function! s:DefaultExpr(filetype) "{{{3
    return tlib#var#Get('ttoc_expr_'. a:filetype, 'wbg')
endf


" If onoff is true, switch on auto-following of the word under cursor. 
" This has to be enabled for each buffer.
" If onoff is false, switch it off.
function! ttoc#Autoword(onoff) "{{{3
    let s:lword = ''
    if a:onoff
        autocmd TToC CursorMoved,CursorMovedI <buffer> let s:cword = expand('<cword>') | if s:cword != s:lword | let s:lword = s:cword | call ttoc#View(s:cword, 1, 0, 0, 1) | endif
    else
        autocmd! TToC
    endif
endf


function! ttoc#SetFollowCursor(world, selected) "{{{3
    if empty(a:world.follow_cursor)
        let a:world.follow_cursor = 'ttoc#FollowCursor'
    else
        let a:world.follow_cursor = ''
    endif
    let a:world.state = 'redisplay'
    return a:world
endf


function! ttoc#FollowCursor(world, selected) "{{{3
    let l = a:selected[0]
    " TLogVAR l
    call tlib#buffer#ViewLine(l)
    redraw
    let a:world.state = 'redisplay'
    return a:world
endf

