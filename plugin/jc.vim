if exists('g:loaded_jc_nvim') | finish | endif

let g:loaded_jc_nvim = v:true

let g:JavaComplete_Home = fnamemodify(expand('<sfile>'), ':p:h:h:gs?\\?'. g:utils#FILE_SEP. '?')

autocmd FileType java call jc#Autoload()
autocmd! BufReadCmd jdt://*
autocmd! BufReadCmd *.class
autocmd BufReadCmd,FileReadCmd,SourceCmd jdt://* lua require('jc.jdtls').read_class_content(vim.fn.expand("<amatch>"))

command! JCimportsOrganizeSmart lua require('jc.jdtls').organize_imports(true)
command! JCimportsOrganize lua require('jc.jdtls').organize_imports(false)
command! JCgenerateToString lua require('jc.jdtls').generate_toString()
command! JCgenerateHashCodeAndEquals lua require('jc.jdtls').generate_hashCodeAndEquals()
command! JCgenerateAccessors lua require('jc.jdtls').generate_accessors()
command! JCgenerateAccessorGetter lua require('jc.jdtls').generate_accessor('g')
command! JCgenerateAccessorSetter lua require('jc.jdtls').generate_accessor('s')
command! JCgenerateAccessorSetterGetter lua require('jc.jdtls').generate_accessor('sg')
command! JCgenerateConstructorDefault lua require('jc.jdtls').generate_constructor(nil, nil, {default = true})
command! JCgenerateConstructor lua require('jc.jdtls').generate_constructor(nil, nil, {default = false})
command! JCgenerateAbstractMethods lua require('jc.jdtls').generate_abstractMethods()
command! JCgenerateClass lua require('jc.class_generator').generate_class()
command! JCtoggleAutoformat call jc#toggleAutoformat() 

if luaeval("pcall(require, 'jdtls')")
  command! JCrefactorExtractVar lua require('jdtls').extract_variable()
  command! -range=% JCrefactorExtractMethod lua require('jdtls').extract_method(true)

else
  echom "Install nvim-jdtls to have additional commands"
endif
