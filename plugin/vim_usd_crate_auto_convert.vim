augroup usdconvert
    autocmd!
    autocmd BufReadPost,FileReadPost *.usd,*.usdc call s:initialize(expand('<afile>'))
    autocmd BufWritePost,FileWritePost *.usd,*.usdc call s:compress(expand('<afile>'))

    autocmd FileAppendPre *.usd,*.usdc call s:initialize(expand('<afile>'))
    autocmd FileAppendPost *.usd,*.usdc call s:compress(expand('<afile>'))
augroup END
