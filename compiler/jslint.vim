if exists("current_compiler")
  finish
endif

let current_compiler = "jslint"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

if executable('node')
  let s:runner_cmd = 'node "' . expand('<sfile>:p:h') . '/jslint/node_jslint.js" '
  CompilerSet errorformat=%f:%l:%c:%m
else
  let s:runner_cmd = 'java -jar "' . expand('<sfile>:p:h') . '/jslint/jslint4java/jslint4java-2.0.0.jar" '
  CompilerSet errorformat=jslint:%f:%l:%c:%m
endif
let s:makeprg_str = 'CompilerSet makeprg=' . escape(s:runner_cmd . '"%:p"', ' "')
execute s:makeprg_str

let &cpo = s:cpo_save
unlet s:cpo_save

