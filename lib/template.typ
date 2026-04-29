#import "layouts/doc.typ": doc
#import "utils/algorithm.typ": algorithm, algorithm-ref, indent, no-number, pseudocode-list, with-english-writing
#import "utils/equation-note.typ": equation-note
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/appendix.typ": appendix as appendix-layout
#import "utils/header.typ": graduate-header-title, header-render
#import "pages/bachelor-cover.typ": bachelor-cover
#import "pages/graduate-cover.typ": master-cover
#import "pages/abstract.typ": abstract as abstract-page
#import "pages/outline.typ": outline-page
#import "pages/backmatter-page.typ": backmatter-page
#import "@preview/gb7714-bilingual:0.2.3": init-gb7714, multicite
#import "utils/bilingual-bibliography.typ": bilingual-bibliography
#import "utils/custom-heading.typ": active-heading, heading-display
#import "@preview/i-figured:0.2.4": show-equation, show-figure
#import "@preview/cap-able:0.0.2": capfig, capfig-style, capsubfig, captab, captab-style, captnote
#import "utils/style.typ": 字体, 字号
#import "format.typ": body-format, header-format, heading-format

#let appendix(title: auto, body) = (
  title: title,
  body: body,
)
#let appendices(..items) = items.pos()
#let bachelor-first-level-value(value) = if type(value) == array {
  value.at(0, default: value.last())
} else {
  value
}

#let normalize-graduate-appendix-items(legacy-appendix: none, appendices: none) = {
  if appendices != none {
    if type(appendices) == array {
      appendices
    } else {
      (appendices,)
    }
  } else if legacy-appendix != none {
    ((title: auto, body: legacy-appendix),)
  } else {
    ()
  }
}

#let render-graduate-appendices(legacy-appendix: none, appendices: none) = {
  let items = normalize-graduate-appendix-items(legacy-appendix: legacy-appendix, appendices: appendices)
  items
    .map(item => {
      let appendix-title = auto
      let appendix-body = item
      if type(item) == dictionary {
        appendix-title = item.at("title", default: auto)
        appendix-body = item.at("body", default: [])
      }

      [
        #heading(level: 1)[
          #if appendix-title != auto {
            appendix-title
          }
        ]
        #appendix-body
      ]
    })
    .join()
}

#let default-bibliography(doctype) = {
  if doctype == "bachelor" {
    "../template/bib/bachelor.bib"
  } else {
    "../template/bib/graduate.bib"
  }
}

// 主配置函数
#let nwpu-thesis(
  // 文档类型
  doctype: "bachelor", // "bachelor" | "master" | "doctor"
  degree: "academic", // "academic" | "professional"
  anonymous: false,
  english-writing: false,
  colored-cover: false,
  // 基本信息（本科 & 研究生共用）
  title: ("基于 Typst 的", "西北工业大学学位论文"),
  author: "张三",
  major: "某专业",
  supervisor: ("李四", "教授"),
  submit-date: datetime.today(),
  // 研究生额外信息
  title-en: "NPU Thesis Template for Typst",
  student-id: "1234567890",
  class-no: "O643.12",
  author-en: "Zhang San",
  department: "某学院",
  major-en: "XX",
  supervisor-en: "Li Si",
  secret-level: "公开",
  school-code: "10699",
  reviewers: (
    (name: "", title: "", unit: ""),
    (name: "", title: "", unit: ""),
  ),
  defence-committee: (
    date: datetime.today(),
    chairman: (name: "", title: "", unit: ""),
    members: (
      (name: "", title: "", unit: ""),
      (name: "", title: "", unit: ""),
      (name: "", title: "", unit: ""),
      (name: "", title: "", unit: ""),
    ),
    secretary: (name: "", title: "", unit: ""),
  ),
  // 页面内容
  abstract: none,
  keywords: (),
  funding: none,
  abstract-en: none,
  keywords-en: (),
  funding-en: none,
  acknowledgement: none,
  academic-achievements: none,
  appendix: none,
  appendices: none,
  scan-declaration: none,
  design_summary: none,
  bibliography: none,
  info: (:),
  // 文档正文
  body,
) = {
  if bibliography == none {
    bibliography = default-bibliography(doctype)
  }

  let effective_twoside = doctype != "bachelor"
  let is-graduate = doctype == "master" or doctype == "doctor"
  let graduate-appendix-items = normalize-graduate-appendix-items(
    legacy-appendix: appendix,
    appendices: appendices,
  )
  let has-graduate-appendices = graduate-appendix-items.len() > 0
  // 默认参数
  info = (
    (
      title: title,
      title-en: title-en,
      student-id: student-id,
      class-no: class-no,
      author: author,
      author-en: author-en,
      department: department,
      major: major,
      major-en: major-en,
      supervisor: supervisor,
      supervisor-en: supervisor-en,
      submit-date: if type(submit-date) == dictionary {
        datetime(year: submit-date.year, month: submit-date.month, day: 1)
      } else {
        submit-date
      },
      secret-level: secret-level,
      school-code: school-code,
      degree: auto,
      reviewers: reviewers,
      defence-committee: defence-committee,
    )
      + info
  )

  // 1. 文稿设置
  show: doc.with(doctype: doctype, graduate_header_ascent: header-format.graduate.ascent)

  // 2. 封面
  if is-graduate {
    master-cover(
      doctype: doctype,
      degree: degree,
      colored-cover: colored-cover,
      anonymous: anonymous,
      info: info,
    )
  } else {
    bachelor-cover(
      anonymous: anonymous,
      info: info,
    )
  }

  show: init-gb7714.with(read(bibliography), style: "numeric", version: "2015")

  // 3. mainmatter 包裹所有后续内容（前置 + 正文 + 后置）
  show: mainmatter.with(
    twoside: effective_twoside,
    doctype: doctype,
    english-writing: english-writing,
    heading-pagebreak: (true, false, false),
    leading: if is-graduate { body-format.graduate.leading } else { body-format.bachelor.leading },
    spacing: if is-graduate { body-format.graduate.spacing } else { body-format.bachelor.spacing },
    heading_leading: if is-graduate { heading-format.graduate.leading } else { heading-format.bachelor.leading },
    heading-above: if is-graduate { heading-format.graduate.above } else { heading-format.bachelor.above },
    heading-below: if is-graduate { heading-format.graduate.below } else { heading-format.bachelor.below },
    graduate_headsep: header-format.graduate.headsep,
    graduate_headrule_offset: header-format.graduate.headrule-offset,
    graduate_headrule_thick: header-format.graduate.headrule-thick,
    graduate_headrule_thin: header-format.graduate.headrule-thin,
    graduate_headrule_gap: header-format.graduate.headrule-gap,
    display-header: true,
  )

  // 4. 前置部分（摘要、目录）：覆盖页码和标题编号
  [
    #set page(footer: context align(center)[
      #set text(size: 字号.小五)
      #counter(page).display("I")
    ])
    #set heading(numbering: none)
    #counter(page).update(1)
    #if abstract != none {
      if is-graduate {
        abstract-page(
          keywords: keywords,
          funding: funding,
          keywords-above: body-format.graduate.keywords-above,
        )[#abstract]
      } else {
        abstract-page(
          keywords: keywords,
          keyword-label: "关键词",
          keyword-sep: "，",
          keyword-indent: 0pt,
          outline-title: "摘 要",
          outlined: false,
          funding: none,
        )[#abstract]
      }
    }
    #if abstract-en != none {
      if is-graduate {
        abstract-page(
          keywords: keywords-en,
          funding: funding-en,
          keywords-above: body-format.graduate.keywords-above,
          keyword-label: "Key words",
          keyword-weight: "bold",
          keyword-sep: "; ",
          outline-title: "ABSTRACT",
        )[#abstract-en]
      } else {
        abstract-page(
          keywords: keywords-en,
          keyword-label: "KEY WORDS",
          keyword-weight: "bold",
          keyword-sep: ", ",
          keyword-indent: 0pt,
          outline-title: "ABSTRACT",
          outlined: false,
          funding: none,
        )[#abstract-en]
      }
    }

    #if is-graduate {
      outline-page(title: if english-writing { "Contents" } else { "目　录" })
    } else {
      outline-page(
        title: if english-writing { "Contents" } else { "目 录" },
        indent: (0pt, 24pt, 18pt),
        weight: ("bold", "regular", "regular"),
        fill: (repeat([#move(dy: -0.1em, text(size: 0.4em)[·])], gap: -0.1em),),
        title-weight: "bold",
        entry-spacing: (1.5em, 1em, 0.1em),
      )
    }

    #if effective_twoside {
      pagebreak(weak: true, to: "odd")
    }
  ]

  [#metadata(none) <__nwpu_mainmatter_start__>]
  counter(page).update(1)

  // 5. 正文
  with-english-writing(english-writing, body)

  // 6. 后置部分
  if bibliography != none {
    bilingual-bibliography(
      doctype: doctype,
      english-writing: english-writing,
      fonts: (:),
    )
  }

  if is-graduate {
    if has-graduate-appendices {
      show: appendix-layout.with(
        twoside: effective_twoside,
        doctype: doctype,
        english-writing: english-writing,
        body-font: 字体.宋体,
        body-size: 字号.小四,
        leading: body-format.graduate.leading,
        spacing: body-format.graduate.spacing,
      )
      render-graduate-appendices(legacy-appendix: appendix, appendices: appendices)
    }

    if acknowledgement != none {
      backmatter-page(title: if english-writing { "Acknowledgements" } else { "致　谢" })[#acknowledgement]
    }

    if academic-achievements != none {
      backmatter-page(
        title: if english-writing {
          "Academic Achievements and Research Experience"
        } else {
          "在学期间取得的学术成果和参加科研情况"
        },
      )[#academic-achievements]
    }
  } else {
    if acknowledgement != none {
      backmatter-page(title: if english-writing { "Acknowledgements" } else { "致 谢" })[#acknowledgement]
    }

    if design_summary != none {
      backmatter-page(
        title: if english-writing { "Design Summary" } else { "毕业设计小结" },
      )[#design_summary]
    }

    if appendix != none {
      show: appendix-layout.with(
        twoside: effective_twoside,
        doctype: doctype,
        english-writing: english-writing,
        body-font: 字体.宋体,
        body-size: 字号.小四,
        leading: body-format.bachelor.leading,
        spacing: body-format.bachelor.spacing,
      )
      [
        #heading(level: 1)[]
        #appendix
      ]
    }
  }

  if effective_twoside {
    pagebreak(weak: true, to: "odd")
  }

  if scan-declaration != none and is-graduate {
    page(
      margin: 0pt,
      header: none,
      footer: none,
    )[
      #scan-declaration
      #box(width: 0pt, height: 0pt)
    ]
  }

  if colored-cover and is-graduate {
    let bg = if doctype == "doctor" {
      "../template/figures/博士论文封底.jpg"
    } else if degree == "professional" {
      "../template/figures/专硕论文封底.jpg"
    } else {
      "../template/figures/学硕论文封底.jpg"
    }
    page(
      margin: 0pt,
      header: none,
      footer: none,
    )[
      #box(width: 0pt, height: 0pt)
    ]
    page(
      margin: 0pt,
      background: image(bg, width: 100%, height: 100%),
      header: none,
      footer: none,
    )[
      #box(width: 1pt, height: 1pt)
    ]
  }
}
