#let darkred = rgb("#540808")
#let darkyellow = rgb("#fcba03")
#let dnd = smallcaps("Dungeons & Dragons")

#let infinityPage = (width: 600pt, height: auto)

#let rpgstory(title: "", 
              author: "", 
              subtitle: "", 
              cover: none,
              font_size: 12pt,
              paper: none,
              pageSize: infinityPage,
              fancy_author: false,
  body) = {
  set document(title: title)
  
  show heading: it => text(
    size: 1.5em,
    fill: darkred,
    weight: "regular",
    // style: "italic",
    smallcaps(it.body)
  )

  show heading.where(
    level: 2
  ): it => text(
    size: 1.5em,
    
    fill: darkred,
    weight: "regular",
    
  )[
    #box(width: 100%, inset: (bottom: 4pt), stroke: (bottom: 1pt + darkyellow))[#smallcaps(it.body)]  
  ]

  // Page settings
  set page(
    paper: paper,
    flipped: false,
    margin: (left: 25mm, right: 15mm, top: 20mm, bottom: 30mm),
    numbering: "1",
    number-align: start,
    background: image("images/background.jpg", width: 110%),
    footer: context {
      if here().page() > 1 {
        place(left+bottom, image("images/footer.svg", width: 100%))
        align(center)[#here().position().page]
      }}
  ) if paper != none

  set page(
    width: pageSize.width,
    height: pageSize.height,
    flipped: false,
    margin: (left: 25mm, right: 15mm, top: 20mm, bottom: 30mm),
    numbering: "1",
    number-align: start,
    background: image("images/background.jpg", width: 110%, height: 110%),
    footer: context {
      if here().page() > 1 {
        place(left+bottom, image("images/footer.svg", width: 100%))
        if pageSize.height != infinityPage.height {
          align(center)[#here().position().page]
        }
      }}
  ) if pageSize != none
  
  if subtitle.len() > 0 {
    subtitle = subtitle + "\n"
  }
  
  // FRONT PAGE
  page(
    margin: (x: 0pt, y: 0pt),
    width: pageSize.width,
    height: auto,
    columns: 1)[

    #if cover != none {
      cover
    }

    #place(
      top + center,
      box(fill: rgb("#00000066"), inset: 10%, text(fill: white, size: 60pt, weight: 800, upper(title)))
    )

    #if subtitle.len() > 0 {
    place(
      bottom + center,
      dy: -0.2cm,
      box(width: 80%, fill: rgb("#00000066"), inset: (left:10pt, right:10pt, top:10pt, bottom: 10pt), text(fill: white, size:20pt)[#subtitle #if not fancy_author {"by " + author}]
    ))}

    #if fancy_author {
      place(dx: -10%, dy: 73%, image("images/fire_splash.svg", width: 60%))
      place(dx: -10% + 0.7cm, dy: 73% + 0.7cm)[#text(size: 18pt, fill: white, weight: 700)[by #author]]
    }
  ]
  
  set text(size: font_size, lang: "en", fill: black)

  set quote(block: true, quotes: true)
  show quote: set text(style: "italic")

  body
  
}

#let key(anchor: none, content) = text(fill: blue, size: 1.1em)[
  #if anchor != none [
    #link(anchor)[#content]
  ] else [
    #content
  ]
]


// #let dndtab(name, columns: (1fr, 4fr), ..contents) = [
//   *#smallcaps(text(size: 1.3em)[#name])*
//   #v(-1em)
//   #table(
//   columns: columns,
//   align: (col, row) =>
//    if col == 0 { center }
//     else { left },
//   fill: (col, row) => if calc.odd(row+1) { rgb("#aaaaaa00") } else { rgb("#aaffaa33") },
//   inset: 10pt,
//   stroke: none,
//   // align: horizon,
//   ..contents
//   )
// ]
// #let marginset(where) = {
//    if where == top {
//      (top: -10pt)
//    } else {
//      (bottom: -10pt)
//    }
// }
// #let pagewithfig(where, figure, contents) = [
//     #set page(columns: 1, margin: marginset(where))  
//     #pagebreak()
//     #place(where+center, float: true, figure)
//     #block[#columns(2)[#contents]]
// ]

#let breakoutbox(title, contents) = [
  #box(inset: 10pt, width: 100%, stroke: (top: 1pt, bottom: 1pt), fill: rgb("#cee4ce"))[
    #if title.len() > 0 {
      align(left, smallcaps[*#title*])
    }
    #align(left)[#contents]
  ]
]

#let scene(content) = [== #content]
#let subscene(content) = [==== #content]
// #let bonus(i) = {
//   let b = ""
//   if i >= 10 {
//     b = "+"
//   }
//   b + str(int((i - 10)/2))
// }

// #let stat-to-str(a) = {
//   (str(a) + " (" + bonus(int(a)) + ")")
// }

// #let stats-table(stats) = {
//   let content = ()
//   for k in stats.keys() {
//     content.push([#text(fill: darkred, weight: 700, k)])
//   }
//   for k in stats.values() {
//     content.push([#text(fill: black, stat-to-str(k))])
//   }
//   table(stroke: none, columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr), inset: 0pt, row-gutter: 5pt, align: center, ..content)
// }

// #let statbox(stats) = [
//   #box(inset: 12pt, fill: white, stroke: 1pt, width: 100%)[
//     #show par: set block(spacing: .6em)
//     #set text(size: 10pt) 
//     #heading(outlined: false, level: 3, stats.name)
    
//     _ #stats.description _

//     #line(stroke: 2pt + darkred, length: 100%)
//     #text(fill: darkred)[*Armor Class*] #stats.ac\
//     #text(fill: darkred)[*Hit Points*] #stats.hp\
//     #text(fill: darkred)[*Speed*] #stats.speed\
    
//     #line(stroke: 2pt + darkred, length: 100%)
//     #stats-table(stats.stats)
//     #line(stroke: 2pt + darkred, length: 100%)

//     #for skill in stats.skillblock {
//       [#text(fill: darkred)[*#skill.at(0)*] #skill.at(1)\ ]
//     }
//     #line(stroke: 2pt + darkred, length: 100%)
//     #for trait in stats.traits {
//       [ _*#trait.at(0).*_ #trait.at(1)]
//     }
    
//     #let sections = ("Actions", "Reactions", "Limited Usage", "Equipment", "Legendary Actions")
    
//     #for section in sections {
//       if section in stats.keys() {
//         block[
//           #show par: set block(spacing: 1em)
//           #text(size: 1.3em, fill: darkred)[#box(width:100%, inset: (bottom: 3pt), stroke: (bottom: 1pt+darkyellow))[#smallcaps(section)]]
//           #for action in stats.at(section) {
//             [_*#action.at(0).*_ #action.at(1) \ ]
//           }
//        ]
//      }
//    }
//  ]   
// ]

// #let spell(spl) = [
//   #show par: set block(spacing: .6em)
//   #heading(outlined: false, level: 3, spl.name)

//   _#spl.spell_type _
//   #v(0.5em)
//   #for prop in spl.properties {

//        [*#prop.at(0):* #prop.at(1) \ ]

       
//       }
//   #v(0.5em)
//   #spl.description
  
// ]

// #let trademarks = text(size: 0.9em, style: "italic")[
//   #dnd D&D, Wizards of the Coast, Forgotten Realms, Ravenloft, Eberron, the dragon ampersand, Ravnica and all other Wizards of the Coast product names, and their respective logos are trademarks of Wizards of the Coast in the USA and other countries.

// This work contains material that is copyright Wizards of the Coast and/or other authors. Such material is used with permission under the Community Content Agreement for Dungeon Masters Guild.

// All other original material in this work is copyright 2023 by the author and published under the Community Content Agreement for Dungeon Masters Guild.
// ]