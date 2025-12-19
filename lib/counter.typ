#let chap-counter = counter("chap-counter")

#let extract-heading(depth, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }
  let nums = chap-counter.at(loc)
  while nums.len() < depth { nums.push(0) }
  numbering(outline, ..nums.slice(0, depth))
}

#let generate-counter(counter-depth, it, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }
  let s = if type(it) != str and type(it) != content { str(it) } else { it }

  if counter-depth == 3 {
    extract-heading(2, outline: outline, loc: loc) + "." + s
  } else if counter-depth == 2 {
    extract-heading(1, outline: outline, loc: loc) + "." + s
  } else {
    s
  }
}
