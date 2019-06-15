augroup usdconvert
    autocmd!
    autocmd BufReadPost,FileReadPost *.usd,*.usdc call vim_usd_create_auto_convert#initialize(expand('<afile>'))
    autocmd BufWritePost,FileWritePost *.usd,*.usdc call vim_usd_crate_auto_convert#compress(expand('<afile>'))

    autocmd FileAppendPre *.usd,*.usdc call vim_usd_create_auto_convert#initialize(expand('<afile>'))
    autocmd FileAppendPost *.usd,*.usdc call vim_usd_crate_auto_convert#compress(expand('<afile>'))
augroup END
