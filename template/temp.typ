#let styraw(font: font.raw, body) = {
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
    radius: 5pt,
  )
  show raw.where(block: true): set par(leading: 0.7em)
  show raw: set text(font: (font, "simsun"), size: 10pt)
  body
}
