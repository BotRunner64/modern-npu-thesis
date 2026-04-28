#import "../utils/style.typ": 字号, 字体

// 西北工业大学摘要页
#let abstract(
  keywords: (),
  keyword-label: "关键词",
  keyword-weight: "regular",
  keyword-sep: "；",
  keyword-indent: 2em,
  outline-title: "摘　要",
  outlined: true,
  keywords-above: 1em,
  heading-metadata: false,
  funding: none,
  body,
) = {
  if heading-metadata {
    [
      #metadata(none) <__nwpu_master_abstract_en_heading_start__>
      #heading(level: 1, outlined: outlined, outline-title)
      #metadata(none) <__nwpu_master_abstract_en_heading_end__>
    ]
  } else {
    heading(level: 1, outlined: outlined, outline-title)
  }

  body

  [
    #set par(first-line-indent: 0pt)
    #v(keywords-above)
    #if keyword-weight == "bold" [
      #text(font: 字体.黑体, weight: "bold")[#keyword-label：]
    ] else [
      #h(keyword-indent)#text(font: 字体.黑体)[#keyword-label]：
    ]
    #(("",) + keywords.intersperse(keyword-sep)).sum()
  ]

  if funding != none [
    #v(1fr)
    #set par(leading: 1.4em)
    #text(font: 字体.宋体, size: 字号.五号)[#funding]
  ]
}
