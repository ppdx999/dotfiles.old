setlocal regexpengine=2

:setl autoread
command! Fix :!npx eslint --fix %
