#import "../utils/style.typ": 字号, 字体
#import "../format.typ": body-format

// 后置部分通用页面（致谢、毕业设计小结、学术成果等）
// 根据 doctype 自动选择对应的 format 默认值
// 换页和标题样式全部由 mainmatter heading show rule 统一处理
#let backmatter-page(
  twoside: false,
  doctype: "bachelor",
  english-writing: false,
  leading: auto,
  spacing: auto,
  body-font: auto,
  body-size: auto,
  fonts: (:),
  title: auto,
  outlined: true,
  body,
) = {
  fonts = 字体 + fonts
  if body-font == auto { body-font = fonts.宋体 }
  if body-size == auto { body-size = 字号.小四 }

  let fmt = if doctype == "bachelor" { body-format.bachelor } else { body-format.graduate }
  if leading == auto { leading = fmt.leading }
  if spacing == auto { spacing = fmt.spacing }

  [
    #set text(font: body-font, size: body-size)
    #set par(
      leading: leading,
      spacing: spacing,
      justify: true,
    )

    #heading(level: 1, numbering: none, outlined: outlined, title)

    #[
      #set par(first-line-indent: fmt.first-line-indent)
      #body
    ]
  ]
}
