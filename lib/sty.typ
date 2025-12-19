#import "counter.typ": *

#let styfigure(counter-depth: 2, fig-outline: "1.1", figure-kinds: (image, table, raw), body) = {
  let sels = figure-kinds.map(k => figure.where(kind: k))
  if sels.len() > 0 {
    show selector.or(..sels): set figure(numbering: n => generate-counter(counter-depth, n, outline: fig-outline))
    body
  } else {
    body
  }
}

#let stymatheq(counter-depth: 2, eq-outline: "1.1", body) = {
  set math.equation(numbering: n => { "(" + generate-counter(counter-depth, n, outline: eq-outline) + ")" })
  body
}

// --- Heading backbone ---------------------------------------------------------

// Install chapter counter stepping + counter resets on outlined headings.
// This is the "numbering backbone": it keeps `chap-counter` in sync with headings,
// and resets figure/equation counters when entering a new chapter/section.
//
// Parameters:
// - counter-depth: same meaning as generate-counter (controls when to reset figures)
// - matheq-depth: same meaning as generate-counter (controls when to reset equations)
// - offset: starting chapter number offset (e.g., 0 for normal, -1, 1, etc.)
#let heading-counters(
  counter-depth: 2,
  matheq-depth: 2,
  offset: 0,
  reset-figure-kinds: (image, table, raw),
  body,
) = {
  // Initialize chap-counter to (offset,0,0)
  chap-counter.update((x, ..y) => (offset, 0, 0))

  show heading.where(level: 1, outlined: true): it => {
    if matheq-depth == 2 or matheq-depth == 3 { counter(math.equation).update(0) }
    if counter-depth == 2 or counter-depth == 3 {
      for k in reset-figure-kinds { counter(figure.where(kind: k)).update(0) }
    }
    chap-counter.step(level: 1)
    chap-counter.update((x, ..y) => (x, 0, 0))
    it
  }

  show heading.where(level: 2, outlined: true): it => {
    if matheq-depth == 3 { counter(math.equation).update(0) }
    if counter-depth == 3 {
      for k in reset-figure-kinds { counter(figure.where(kind: k)).update(0) }
    }
    chap-counter.step(level: 2)
    chap-counter.update((x, y, ..z) => (x, y, 0))
    it
  }

  show heading.where(level: 3, outlined: true): it => {
    chap-counter.step(level: 3)
    it
  }

  body
}
