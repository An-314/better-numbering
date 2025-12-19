#let chap-counter = counter("chap-counter")

// Format the chapter/section prefix taken from `chap-counter` at `loc`.
#let extract-heading(depth, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }
  numbering(outline, ..chap-counter.at(loc).slice(0, depth))
}

// Prefix `it` with the current (or provided) chapter/section prefix, depending on `counter-depth`.
//
// counter-depth semantics (same as your original code):
// - 3: use 1.2.3 style when both level-1 and level-2 headings exist
// - 2: use 1.3 style when level-1 headings exist
// - otherwise: show `it` only
#let generate-counter(counter-depth, it, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }

  let has-h1 = query(heading.where(level: 1)).len() != 0
  let has-h2 = query(heading.where(level: 2)).len() != 0

  let strit = if type(it) != str and type(it) != content { str(it) } else { it }

  if has-h1 and has-h2 and counter-depth == 3 {
    extract-heading(2, outline: outline, loc: loc) + "." + strit
  } else if has-h1 and (counter-depth == 3 or counter-depth == 2) {
    extract-heading(1, outline: outline, loc: loc) + "." + strit
  } else {
    strit
  }
}
