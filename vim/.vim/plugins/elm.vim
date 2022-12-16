augroup elm
  autocmd!
  autocmd BufWritePost *.elm !elm-format --yes %
augroup END

setl autoread
