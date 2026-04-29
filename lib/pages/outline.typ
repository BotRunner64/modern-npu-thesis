// 目录页
#let outline-page(
  title: "目　录",
  indent: (0pt, 24pt, 24pt),
  weight: none,
  fill: (repeat([.], gap: 0.15em),),
  title-weight: none,
  entry-spacing: none,
) = {
  [
    #if title-weight != none [
      #show heading.where(level: 1, numbering: none): it => {
        set text(weight: title-weight)
        it
      }
    ]
    #heading(level: 1, outlined: false, title)

    #set outline(indent: level => indent.slice(0, calc.min(level + 1, indent.len())).sum())
    #show outline.entry: entry => {
      let entry-page-number = counter(page).at(entry.element.location()).first()
      let in-mainmatter-or-later = query(
        selector(label("__nwpu_mainmatter_start__")).before(entry.element.location()),
      ).len() > 0
      let entry-page-display = if not in-mainmatter-or-later {
        numbering("I", entry-page-number)
      } else {
        numbering("1", entry-page-number)
      }
      let entry-content = link(
        entry.element.location(),
        entry.indented(
          none,
          {
            let inner = {
              if entry.prefix() not in (none, []) {
                entry.prefix()
                h(0.3em)
              }
              entry.body()
            }
            if weight != none {
              text(weight: weight.at(entry.level - 1, default: weight.last()), inner)
            } else {
              inner
            }
            box(width: 1fr, inset: (x: .25em), fill.at(entry.level - 1, default: fill.last()))
            entry-page-display
          },
        ),
      )
      if entry-spacing != none {
        block(
          above: if entry.level == 1 { entry-spacing.first() } else { entry-spacing.at(1) },
          entry-content,
        )
      } else {
        entry-content
      }
    }

    // 显示目录
    #outline(title: none, depth: 3)
  ]
}
