#import "../utils/style.typ": 字号, 字体
#import "../format.typ": body-format, heading-format
#import "../layouts/preface.typ": preface-heading-style

// 后置部分通用页面（致谢、毕业设计小结、学术成果等）
// 根据 doctype 自动选择对应的 format 默认值
#let backmatter-page(
  twoside: false,
  doctype: "bachelor",
  english-writing: false,
  leading: auto,
  spacing: auto,
  body-font: auto,
  body-size: auto,
  title-leading: auto,
  title-above: auto,
  title-below: auto,
  fonts: (:),
  title: auto,
  outlined: true,
  body,
) = {
  fonts = 字体 + fonts
  if body-font == auto { body-font = fonts.宋体 }
  if body-size == auto { body-size = 字号.小四 }

  let fmt = if doctype == "bachelor" { body-format.bachelor } else { body-format.graduate }
  let hfmt = if doctype == "bachelor" { heading-format.bachelor } else { heading-format.graduate }
  if title-leading == auto { title-leading = hfmt.leading.first() }
  if title-above == auto { title-above = hfmt.above.first() }
  if title-below == auto { title-below = hfmt.below.first() }
  if leading == auto { leading = fmt.leading }
  if spacing == auto { spacing = fmt.spacing }

  pagebreak(weak: true, to: if twoside { "odd" })
  [
    #set text(font: body-font, size: body-size)
    #set par(
      leading: leading,
      spacing: spacing,
      justify: true,
    )

    // 覆盖正文阶段遗留的 heading show 规则，避免无编号一级标题被重复叠加段前距
    #show heading: it => {
      if it.level == 1 and it.numbering == none {
        preface-heading-style(
          it,
          fonts,
          leading: title-leading,
          above: 0pt,
          below: title-below,
        )
      } else {
        it
      }
    }

    #v(title-above)
    #heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>

    #[
      #set par(first-line-indent: fmt.first-line-indent)
      #body
    ]
  ]
}
