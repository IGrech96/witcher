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
              pageSize: none,
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
  
  if pageSize == none {
    pageSize = infinityPage
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
      box(inset: 10%, text(fill: black, size: 50pt,  weight: 800, upper(title), stroke:1pt+ white))
    )

    #if subtitle.len() > 0 {
    place(
      bottom + center,
      dy: -0.2cm,
      box(width: 80%, fill: rgb("#00000066"), inset: (left:10pt, right:10pt, top:10pt, bottom: 10pt), text(fill: white, size:20pt)[#subtitle #if not fancy_author {"by " + author}]
    ))}

    #if fancy_author {

      place(
        dx: 0cm,
        dy: -2cm,
        image("images/fire_splash.svg", width: 60%)
      )
      place(
        dx: 1cm,
        dy: -1cm,
        text(size: 18pt, fill: rgb("#fa9e9ecb"), weight: 700)[by #author]
      )
    }
  ]
  
  set text(size: font_size, lang: "en", fill: black)

  set quote(block: true, quotes: true)
  show quote: set text(style: "italic")

  body
  
}

#import emoji: chain
#let key(anchor: none, content) = text(fill: blue, size: 1.1em)[
  #if anchor != none [
    #link(anchor)[#text(size: 0.7em)[#chain]#content]
  ] else [
    #content
  ]
]

#let optional(content) = text(style: "italic", fill: rgb("#504b4b"))[\u{2E2E}
#content\u{2E2E}]

#let skill_check(name, param, value) = text(fill: red)[🎲 *#name (#param): #value * <skill_check>]

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

#let todo(content: "") = text(fill: red, size: 1.3em)[
*Дописать:*
#if content != none [
  *#content*
]
]


#let content_overview() = context {

  heading("В этом приключении", outlined: false)
  let chapters = query(
    heading.where(outlined: true)
  )

  let check_names = (:)
  let checks = query(<skill_check>)
  for check in checks {
    let check_name = str(check.body.children.at(0).text)
    let param_name = str(check.body.children.at(3).text)
    let name = check_name + " (" + param_name + ")"
    if name not in check_names {
      check_names.insert(name, name)
    }
  }

  grid(
    columns: (50%,10%, 40%),
    [
        #heading("Сцены \\ Локации", outlined: false, level: 2)

        #for chapter in chapters {
          let loc = chapter.location()
          let nr = numbering(
            loc.page-numbering(),
            ..counter(page).at(loc),
          )
          [#chapter.body #h(1fr) #nr \ ]
        }
    ],
    [],
    [
      #heading("Проверки", outlined: false, level: 2)

      #for check in check_names.keys() {
          [#check #h(1fr) \ ]
        }
    ]
  )
  
}