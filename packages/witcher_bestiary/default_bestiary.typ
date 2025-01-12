#import "@preview/muchpdf:0.1.0": muchpdf

#let show_default_beast(source) = grid(
      inset: 5pt,
      columns: (50%, 50%),
      [#muchpdf( read(source, encoding: none), pages: 1)], [#muchpdf( read(source, encoding: none), pages: 0)]
)

#let robber() = show_default_beast("resources/robbers.pdf")
#let nakers() = show_default_beast("resources/nakers.pdf")
#let trolls() = show_default_beast("resources/trolls.pdf")