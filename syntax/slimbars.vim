" Vim syntax file
" Language: slimbars
" Maintainer: Andrew Stone <andy@stonean.com>
" Version:  1
" Last Change:  2010 Sep 25
" TODO: Feedback is welcomed.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'slimbars'
endif

" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @slimbarsRubyTop syntax/ruby.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @slimbarsHaml syntax/haml.vim
unlet! b:current_syntax

syn match slimbarsBegin  "^\s*\(&[^= ]\)\@!" nextgroup=slimbarsTag,slimbarsClassChar,slimbarsIdChar,slimbarsRuby

syn region  rubyCurlyBlock start="{" end="}" contains=@slimbarsRubyTop contained
syn cluster slimbarsRubyTop    add=rubyCurlyBlock

syn cluster slimbarsComponent contains=slimbarsClassChar,slimbarsIdChar,slimbarsWrappedAttrs,slimbarsRuby,slimbarsAttr,slimbarsInlineTagChar

syn keyword slimbarsDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   slimbarsDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=slimbarsDocType

syn keyword slimbarsTodo        FIXME TODO NOTE OPTIMIZE XXX contained
syn keyword htmlTagName     contained script

syn match slimbarsTag           "\w\+[><]*"         contained contains=htmlTagName nextgroup=@slimbarsComponent
syn match slimbarsIdChar        "#{\@!"        contained nextgroup=slimbarsId
syn match slimbarsId            "\%(\w\|-\)\+" contained nextgroup=@slimbarsComponent
syn match slimbarsClassChar     "\."           contained nextgroup=slimbarsClass
syn match slimbarsClass         "\%(\w\|-\)\+" contained nextgroup=@slimbarsComponent
syn match slimbarsInlineTagChar "\s*:\s*"      contained nextgroup=slimbarsTag,slimbarsClassChar,slimbarsIdChar

syn region slimbarsWrappedAttrs matchgroup=slimbarsWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=slimbarsAttr nextgroup=slimbarsRuby
syn region slimbarsWrappedAttrs matchgroup=slimbarsWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=slimbarsAttr nextgroup=slimbarsRuby
syn region slimbarsWrappedAttrs matchgroup=slimbarsWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=slimbarsAttr nextgroup=slimbarsRuby

syn match slimbarsAttr "\s*\%(\w\|-\)\+\s*" contained contains=htmlArg nextgroup=slimbarsAttrAssignment
syn match slimbarsAttrAssignment "\s*=\s*" contained nextgroup=slimbarsWrappedAttrValue,slimbarsAttrString

syn region slimbarsWrappedAttrValue matchgroup=slimbarsWrappedAttrValueDelimiter start="{" end="}" contained contains=slimbarsAttrString,@slimbarsRubyTop nextgroup=slimbarsAttr,slimbarsRuby,slimbarsInlineTagChar
syn region slimbarsWrappedAttrValue matchgroup=slimbarsWrappedAttrValueDelimiter start="\[" end="\]" contained contains=slimbarsAttrString,@slimbarsRubyTop nextgroup=slimbarsAttr,slimbarsRuby,slimbarsInlineTagChar
syn region slimbarsWrappedAttrValue matchgroup=slimbarsWrappedAttrValueDelimiter start="(" end=")" contained contains=slimbarsAttrString,@slimbarsRubyTop nextgroup=slimbarsAttr,slimbarsRuby,slimbarsInlineTagChar

syn region slimbarsAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimbarsInterpolation,slimbarsInterpolationEscape nextgroup=slimbarsAttr,slimbarsRuby,slimbarsInlineTagChar
syn region slimbarsAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimbarsInterpolation,slimbarsInterpolationEscape nextgroup=slimbarsAttr,slimbarsRuby,slimbarsInlineTagChar

syn region slimbarsInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slimbarsInterpolation,slimbarsInterpolationEscape nextgroup=slimbarsAttr
syn region slimbarsInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slimbarsInterpolation,slimbarsInterpolationEscape nextgroup=slimbarsAttr

syn region slimbarsInterpolation matchgroup=slimbarsInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,slimbarsWrappedAttrs
syn region slimbarsInterpolation matchgroup=slimbarsInterpolationDelimiter start="#{{" end="}}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,slimbarsWrappedAttrs
syn match  slimbarsInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region slimbarsRuby matchgroup=slimbarsRubyOutputChar start="\s*[=]\==[']\=" skip=",\s*$" end="$" contained contains=@slimbarsRubyTop keepend
syn region slimbarsRuby matchgroup=slimbarsRubyChar       start="\s*-"           skip=",\s*$" end="$" contained contains=@slimbarsRubyTop keepend

syn match slimbarsComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=slimbarsTodo
syn match slimbarsText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/

syn match slimbarsFilter /\s*\w\+:\s*/                            contained
syn match slimbarsHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@slimbarsHaml,slimbarsFilter

syn match slimbarsIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=slimbarsComment

hi def link slimbarsAttrString                String
hi def link slimbarsBegin                     String
hi def link slimbarsClass                     Type
hi def link slimbarsAttr                      Type
hi def link slimbarsClassChar                 Type
hi def link slimbarsComment                   Comment
hi def link slimbarsDocType                   Identifier
hi def link slimbarsDocTypeKeyword            Keyword
hi def link slimbarsFilter                    Keyword
hi def link slimbarsIEConditional             SpecialComment
hi def link slimbarsId                        Identifier
hi def link slimbarsIdChar                    Identifier
hi def link slimbarsInnerAttrString           String
hi def link slimbarsInterpolationDelimiter    Delimiter
hi def link slimbarsRubyChar                  Special
hi def link slimbarsRubyOutputChar            Special
hi def link slimbarsText                      String
hi def link slimbarsTodo                      Todo
hi def link slimbarsWrappedAttrValueDelimiter Delimiter
hi def link slimbarsWrappedAttrsDelimiter     Delimiter
hi def link slimbarsInlineTagChar             Delimiter

let b:current_syntax = "slimbars"
