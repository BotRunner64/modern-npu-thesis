#import "../deps.typ": zh
#import "../utils.typ": 字体
#import "header-footer.typ": page-footer, page-header-footer
#import "floats.typ": setup-floats

#let mainmatter(
  graduate: false,
  degree: "master",
  english-writing: false,
  it,
) = {
  let leading = if graduate { 11.8pt } else { 11pt }
  let heading-above = if graduate { (13pt, 7pt, 5pt) } else { (20pt, 0pt, 0pt) }
  let heading-below = if graduate { (14pt, 0pt, 0pt) } else { (24pt, 2pt, 0pt) }
  let heading-numbering = (..nums) => {
    let nums = nums.pos()
    if nums.len() == 1 {
      if english-writing {
        [Chapter #nums.at(0)#h(0.7em)]
      } else if graduate {
        [第 #nums.at(0) 章#h(0.7em)]
      } else {
        numbering("第一章　", nums.at(0))
      }
    } else if nums.len() <= 3 {
      numbering("1.1", ..nums)
    }
  }

  // 图、表、公式、算法样式
  show: setup-floats.with(graduate: graduate, english-writing: english-writing)

  // 页眉页脚
  show: page-header-footer.with(graduate: graduate, degree: degree)

  // 文本和段落样式
  set align(left)
  set par(
    leading: leading,
    justify: true,
    first-line-indent: (amount: 2em, all: true),
    spacing: leading,
  )

  // 处理标题
  set heading(numbering: heading-numbering)
  show heading: set text(font: 字体.黑体)
  show heading: it => {
    if it.level == 1 {
      counter(figure.where(kind: "algorithm")).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
    }

    set text(
      size: (zh(3), zh(4), zh(4.5)).at(calc.min(it.level, 3) - 1),
      weight: "regular",
    )
    set par(first-line-indent: (amount: 0pt))

    let above-extra = heading-above.at(it.level - 1)
    let below-extra = heading-below.at(it.level - 1)

    // 一级标题统一换页并居中
    if it.level == 1 {
      pagebreak(weak: true, to: if graduate { "odd" })
      v(leading + above-extra)
      align(center, block(below: leading + below-extra, it))
    } else {
      block(above: leading + above-extra, below: leading + below-extra, it)
    }
  }

  it
}

// 前置部分（摘要、目录）：罗马数字页码 + 标题不编号
#let frontmatter(body) = {
  set page(footer: page-footer("I"))
  set heading(numbering: none)
  counter(page).update(1)
  body
}
