Sugar.extend true

set-prop = (el, k, v) !-> switch
| k in <[content text]>
  el.inner-HTML = v
| _
  el[k] = v

el = (tag, props) ->
  $el = document.create-element tag
  if props
    for key, val of props
      set-prop $el, key, val
  $el

normalize-name = ->
  it
    .replace ' ' '-'
    .to-lower-case!

export {el, normalize-name}