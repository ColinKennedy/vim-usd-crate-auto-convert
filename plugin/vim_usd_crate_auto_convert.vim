if get(g:, 'vim_usd_crate_auto_convert', 0) == 1
    finish
endif

let g:usdcat_command = get(g:, 'usdcat_command', 'usdcat')


" Set-up commands that will run whenever a USD file is loaded. These
" commands handle the crate-to-ASCII-and-back conversions for you.
"
augroup usdconvert
    autocmd!
    autocmd BufReadPost,FileReadPost *.usd,*.usdc call vim_usd_crate_auto_convert#initialize(expand('<afile>'))
    autocmd BufWritePost,FileWritePost *.usd,*.usdc call vim_usd_crate_auto_convert#compress(expand('<afile>'))

    autocmd FileAppendPre *.usd,*.usdc call vim_usd_crate_auto_convert#initialize(expand('<afile>'))
    autocmd FileAppendPost *.usd,*.usdc call vim_usd_crate_auto_convert#compress(expand('<afile>'))
augroup END


let g:vim_usd_crate_auto_convert = 1
