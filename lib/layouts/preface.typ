#import "../utils/style.typ": 字体, 字号
#import "../utils/header.typ": bachelor-header-render, graduate-header-title, header-render
#import "../utils/custom-heading.typ": active-heading, heading-display
#import "../format.typ": preface-format, header-format

// ============================================
// 一级标题统一配置
// 用于摘要、目录、致谢、正文章节等所有页面
// 所有数值来自 format.typ，修改格式请编辑该文件
// ============================================

#let heading-above = preface-format.heading.above
#let heading-below = preface-format.heading.below
#let graduate-heading-leading = preface-format.heading.leading
#let graduate-body-leading = preface-format.body.leading
#let graduate-body-spacing = preface-format.body.spacing
#let graduate-body-first-line-indent = preface-format.body.first-line-indent
#let graduate-keywords-above = preface-format.keywords.above

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
#let preface-heading-size = preface-format.heading.size
#let preface-heading-weight = preface-format.heading.weight

// 标题样式函数 - 供各页面调用
#let preface-heading-style(
  it,
  fonts,
  centered: true,
  font: auto,
  size: preface-heading-size,
  weight: preface-heading-weight,
  leading: 2.4pt,
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
  // 我们直接在这里针对 it 应用 show rule，或者直接 set page
  show: it => {
    set page(
      header: context {
        if not display-header { return none }

        let loc = here()
        let is-graduate = (doctype == "master" or doctype == "doctor")

        // 默认显示当前章节
        let header-content = heading-display(active-heading(level: 1, prev: false))

        // 双面模式下的偶数页替换为校名
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
          bachelor-header-render()
        }
      },
    )
    it
  }

  // 4. 统一控制前置部分一级标题的间距
  // 使用 Typst 官方推荐的 block 方式，避免手动 v() 间距
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
