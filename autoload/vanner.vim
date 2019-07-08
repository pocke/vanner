let s:defualt_option = {
\   "font": 1,
\ }

function! vanner#echo(string, option) abort
  echo vanner#string(a:string, a:option)

endfunction

function! vanner#string(string, option) abort
  let data = vanner#raw(a:string, a:option)

  if len(data) == 0 | return "" | endif

  let res = ""
  let max = len(data[0])
  let i = 0
  while i < max
    for ch in data
      let res .= ch[i]

      if i != max - 1
        let res .= '  '
      end
    endfor
    let res .= "\n"
    let i += 1
  endwhile

  return res
endfunction

function! vanner#raw(string, option) abort
  let option = extend(copy(s:defualt_option), a:option)
  let font = g:vanner#fonts#font{option["font"]}

  let res = []

  for ch in split(a:string, '\zs')
    if !has_key(font, ch) | continue | endif

    call add(res, font[ch])
  endfor

  return res
endfunction
