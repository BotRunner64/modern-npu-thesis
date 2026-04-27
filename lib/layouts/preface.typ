#import "../utils/style.typ": 字体, 字号
#import "../utils/header.typ": bachelor-header-render, graduate-header-title, header-render
#import "../utils/custom-heading.typ": active-heading, heading-display
#import "../format.typ": body-format, heading-format, header-format

// ============================================
// 一级标题统一配置
// 用于摘要、目录、致谢、正文章节等所有页面
// 所有数值来自 format.typ，修改格式请编辑该文件
// ============================================

#let heading-above = heading-format.graduate.above.first()
#let heading-below = heading-format.graduate.below.first()
#let graduate-heading-leading = heading-format.graduate.leading.first()
#let graduate-body-leading = body-format.graduate.leading
#let graduate-body-spacing = body-format.graduate.spacing
#let graduate-body-first-line-indent = body-format.graduate.first-line-indent
#let bachelor-body-first-line-indent = body-format.bachelor.first-line-indent
#let graduate-keywords-above = body-format.graduate.keywords-above

// 兼容旧名称的别名
#let preface-heading-above = heading-above
#let preface-heading-below = heading-below
#let preface-heading-leading = graduate-heading-leading
#let preface-body-leading = graduate-body-leading
#let preface-body-spacing = graduate-body-spacing
#let preface-body-first-line-indent = graduate-body-first-line-indent
#let preface-keywords-above = graduate-keywords-above

// 标题字体配置
#let preface-heading-font = fonts => fonts.黑体
#let preface-heading-size = heading-format.graduate.size.first()
#let preface-heading-weight = heading-format.graduate.weight.first()

// 标题样式函数 - 供各页面调用
#let preface-heading-style(
  it,
  fonts,
  centered: true,
  font: auto,
  size: preface-heading-size,
  weight: preface-heading-weight,
  leading: graduate-heading-leading,
  above: 0pt,
  below: preface-heading-below,
) = {
  set text(
    font: if font == auto { preface-heading-font(fonts) } else { font },
    size: size,
    weight: weight,
  )
  set par(leading: leading, spacing: 0pt)
  set block(above: above, below: below)
  if centered {
    set align(center)
    it
  } else { it }
}

// 前言
#let preface(
  twoside: false,
  doctype: "master",
  fonts: (:),
  display-header: true,
  graduate_headsep: header-format.graduate.headsep,
  graduate_headrule_offset: header-format.graduate.headrule-offset,
  graduate_headrule_thick: header-format.graduate.headrule-thick,
  graduate_headrule_thin: header-format.graduate.headrule-thin,
  graduate_headrule_gap: header-format.graduate.headrule-gap,
  ..args,
  it,
) = {
  fonts = 字体 + fonts

  // 1. 设置页码逻辑
  // 注意：pagebreak 放在 set page 之前
  pagebreak(weak: true, to: if twoside { "odd" })
  counter(page).update(1)

  // 2. 页面全局设置
  set page(
    footer: context align(center)[
      #set text(size: 字号.小五)
      #counter(page).display("I")
    ],
  )

  // 3. 页眉设置
  show: it => {
    set page(
      header: context {
        if not display-header { return none }

        let loc = here()
        let is-graduate = (doctype == "master" or doctype == "doctor")

        let header-content = heading-display(active-heading(level: 1, prev: false))

        if twoside and calc.rem(loc.page(), 2) == 0 and is-graduate {
          header-content = graduate-header-title(doctype)
        }

        if is-graduate {
          header-render(
            header-content,
            fonts: fonts,
            graduate_headsep: graduate_headsep,
            graduate_headrule_offset: graduate_headrule_offset,
            graduate_headrule_thick: graduate_headrule_thick,
            graduate_headrule_thin: graduate_headrule_thin,
            graduate_headrule_gap: graduate_headrule_gap,
          )
        } else {
          bachelor-header-render(offset: header-format.bachelor.offset)
        }
      },
    )
    it
  }

  // 4. 统一控制前置部分一级标题的间距
  if doctype != "bachelor" {
    show heading.where(level: 1, numbering: none): set block(
      above: preface-heading-above,
      below: preface-heading-below,
    )
    show heading.where(level: 1, numbering: none): set par(
      leading: preface-heading-leading,
      spacing: 0pt,
    )
  }

  it
}
