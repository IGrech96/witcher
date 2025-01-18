#let show_stats(
      name: "",
      imageSrc: "",
      common: none,
      parameters: none,
      skills: none,
      weapons: none,
      abilities: none
) = context { 


 box(inset: 12pt, stroke: (top: 1pt, bottom: 1pt), fill: rgb("#cee4ce"), width: 100%)[
    #set par(spacing: .6em)
    #set text(size: 10pt) 
    #show heading: set align(center)
    #show heading: it => box(stroke: (bottom: 2pt), inset: 2pt)[#text(
      size: 1.5em,
      fill: blue,
      smallcaps(it.body)
    )]

    #set table(
      fill: (x, y) => {
        if y == 0 {
          blue.lighten(40%)
        }
      },
      align: center
    )
    #heading(outlined: false, level: 2, name)

    #let paramTable = none
    #if parameters != none {

      let parametersCopy = parameters
      if "Скор" in parameters {
          parametersCopy.insert("Бег", parametersCopy.at("Скор")*3)
          parametersCopy.insert("Прж", int(parametersCopy.at("Бег")/5))
      }
      paramTable = table(
        columns: (70%, 30%),
        table.cell(colspan: 2)[Параметры],
        ..for (k, v) in parametersCopy {
          (k, str(v))
        }
      )
    }

    #let commonTable = none
    #if common != none {
        let commonCopy = common

        if parameters != none and "Воля" in parameters and "Инт" in parameters {
            commonCopy.insert("Реш", int((parameters.at("Воля") + parameters.at("Инт"))/2*5))
        }

        commonTable = table(
        columns: (70%, 30%),
        table.cell(colspan: 2)[Общее],
        ..for (k, v) in commonCopy {
          (k, str(v))
        }
      )
    }

    #let skillsTable = none
    #if skills != none {
        skillsTable = table(
        columns: (70%, 30%),
        table.cell(colspan: 2)[Навыки],
        ..for (k, v) in skills {
          (k, str(v))
        }
      )
    }

    #let weaponTable = none
    #if weapons != none {
        weaponTable = table(
        columns: (25%, 10%, 10%, 20%, 35%),
        table.cell(colspan: 5)[Оружие],
        [Название],[Урон],[Дист],[Попад],[Эффект],
        ..for (k, v) in weapons {
          (k, v.at(0), v.at(1), v.at(2), v.at(3))
        }
      )
    }

    #let abilitiesTable = none
    #if abilities != none {
      abilitiesTable = table(
        columns: (100%),
        [Способности],
        ..for (k, v) in abilities {
          ([*#k:* #v],[])
        }
      )
    }

    #grid(
        inset: 5pt,
        columns: (25%, 25%, 25%, 25%),
        // rows: (280pt, 230pt),
        [#commonTable],[#paramTable],[#skillsTable],[#abilitiesTable],
        grid.cell(colspan: 4)[#weaponTable],
    )
 ]
}