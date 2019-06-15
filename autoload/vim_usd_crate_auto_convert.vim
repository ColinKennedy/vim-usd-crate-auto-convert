" A file that converts USD crate files into ASCII files for editting.
"
" Reference:
"     `:help gzip-example`
"


" It looks as though USD crate files always begin with "PXR-USDC". So
" we search for this string whenever we load a .usd file. If it exists,
" then it must be a crate file. This is the fastest method of detecting
" a crate file (that I know of).
"
function! s:is_usd_file_binary()
    return getline(1) =~ 'PXR-USDC'
endfunction


" Tell Vim that the current buffer was originally a binary file and to
" make sure that it converts an ASCII text into USD's crate format any
" time the user saves.
"
function! s:set_buffer_binary()
    let b:is_usd_file_binary = s:is_usd_file_binary()
endfunction


" Create a temporary file, convert it to ASCII, replace the current buffer's
" contents with the ASCII text, and then delete the temporary file
"
function! s:uncompress(path)
    let l:temporary = s:make_temporary(a:path)

    " If `a:path` ends in ".usd" then we must add "--usdFormat usda" to let
    " USD know to use its ASCII representation
    "
    let l:command = ":'[,']!usdcat " . a:path . ' -o ' . l:temporary
    if l:temporary =~ '.usd$'
        let l:command .= ' --usdFormat usda'
    endif

    silent! execute l:command
        \ ' && cat ' . l:temporary
        \ ' && rm ' . l:temporary
endfunction


" Rename the given *.usd / *.usdc file into something that we will use
" as a temporary file.
"
function! s:make_temporary(path)
    let l:root = fnamemodify(a:path, ':p:h')
    let l:name = fnamemodify(a:path, ':t')
    let l:temporary_name = 'tmp_' . l:name
    let l:temporary = l:root . '/' . l:temporary_name

    if l:temporary =~ '.usdc'
        let l:temporary .= '.usd'
    endif

    return l:temporary
endfunction


" If the given `path` was originally a binary file then convert it back to binary.
function! vim_usd_crate_auto_convert#compress(path)
    if get(b:, 'is_usd_file_binary') == 0
        return
    endif

    let l:temporary = a:path

    if l:temporary =~ '.usdc$'
        let l:temporary = s:make_temporary(a:path)
        silent! execute ':!cp ' . a:path . ' "' . l:temporary . '"'
    endif

    " If `a:path` ends in ".usd" then we must add "--usdFormat usdc" to let
    " USD know to use its crate representation
    "
    let l:command = '!usdcat ' . l:temporary . ' -o ' . a:path
    if a:path =~ '.usd$'
        let l:command .= ' --usdFormat usdc'
    endif

    silent! execute l:command

    if l:temporary != a:path
        call delete(l:temporary)
    endif
endfunction


" Check if the given `path` is a USD binary crate file. If so, convert
" it to ASCII and load its contents into the current buffer.
"
function! vim_usd_crate_auto_convert#initialize(path)
    call s:set_buffer_binary()

    if get(b:, 'is_usd_file_binary') == 0
        return
    endif

    set bin
    call s:uncompress(a:path)
    set nobin
endfunction
