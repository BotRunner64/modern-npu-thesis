#import "../utils/style.typ": 字体, 字号

// 研究生目录页
#let graduate-outline(
  // documentclass 传入参数
  english-writing: false,
  // 其他参数
  depth: 3,
  title: auto,
  outlined: false,
  // 目录条目缩进
  indent: (0pt, 24pt, 24pt),
  // 默认引导符
  fill: auto,
  gap: .3em,
) = {
  // 标题默认值
  if title == auto {
    title = if english-writing { "Contents" } else { "目　录" }
  }
  if fill == auto {
    fill = (repeat([.], gap: 0.15em),)
  }

  [
    // 目录标题
    #heading(level: 1, outlined: outlined, title)

    // 目录样式
    #set outline(indent: level => indent.slice(0, calc.min(level + 1, indent.len())).sum())
    #show outline.entry: entry => {
      let in-mainmatter-or-later = query(
        selector(label("__nwpu_mainmatter_start__")).before(entry.element.location()),
      ).len() > 0
      let entry-page-number = counter(page).at(entry.element.location()).first()
      let entry-page-display = if not in-mainmatter-or-later {
        numbering("I", entry-page-number)
      } else {
        numbering("1", entry-page-number)
      }
      let is-master-abstract-en-entry = (
        query(selector(label("__nwpu_master_abstract_en_heading_start__")).before(entry.element.location())).len()
        > query(selector(label("__nwpu_master_abstract_en_heading_end__")).before(entry.element.location())).len()
      )
      let entry-content = link(
        entry.element.location(),
        entry.indented(
          none,
          {
            if entry.prefix() not in (none, []) {
              entry.prefix()
              h(gap)
            }
            if is-master-abstract-en-entry {
              [ABSTRACT]
            } else {
              entry.body()
            }
            box(width: 1fr, inset: (x: .25em), fill.at(entry.level - 1, default: fill.last()))
            entry-page-display
          },
          gap: 0pt,
        ),
      )
      entry-content
    }

    // 显示目录
    #outline(title: none, depth: depth)
  ]
}
