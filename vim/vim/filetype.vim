augroup filetypedetect
    au BufNewFile,BufRead *.glsl    setf glsl
    au BufNewFile,BufRead *CMakeLists.txt setf cmake
augroup END
