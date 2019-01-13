augroup filetypedetect
    au BufNewFile,BufRead *.glsl    setf glsl
    au BufNewFile,BufRead *CMakeLists.txt setf cmake
    au BufNewFile,BufRead Jenkinsfile setf jdp
augroup END
