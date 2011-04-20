if exists("current_compiler")
  finish
endif

let current_compiler = "jslint"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

let s:runner_cmd = 'java -jar "' . expand('<sfile>:p:h') . '/jslint/jslint4java/jslint4java-1.4.7.jar" '
let s:makeprg_str = 'CompilerSet makeprg=' . escape(s:runner_cmd . '"%:p"', ' "')
execute s:makeprg_str

"CompilerSet makeprg=jslint.bat\ \"%:p\"

CompilerSet errorformat=jslint:%f:%l:%c:%m

let &cpo = s:cpo_save
unlet s:cpo_save

