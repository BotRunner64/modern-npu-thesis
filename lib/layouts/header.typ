#import "../deps.typ": zh

// ============================================
// 页眉统一配置
// ============================================

// 页码渲染函数
#let page-footer(fmt) = context align(center)[
  #set text(size: zh(5.5))
  #counter(page).display(fmt)
]

// 研究生页眉渲染函数
#let header-render(content) = {
  [
    #set par(leading: 0pt, spacing: 0pt)
    #set text(size: zh(5.5))
    #align(center)[#content]
    #v(0.5em)
    #line(length: 100%, stroke: 3.2pt + black)
    #v(0.32em)
    #line(length: 100%, stroke: 0.6pt + black)
  ]
}

#let graduate-header-title(degree) = {
  if degree == "doctor" {
    "西北工业大学博士学位论文"
  } else {
    "西北工业大学硕士学位论文"
  }
}

#let bachelor-header-render() = {
  [
    #v(1.5cm)
    #set par(leading: 0pt, spacing: 0pt)
    #pad(left: 110pt)[
      #image("../assets/nwpu-header.png", width: 7.5cm)
    ]
    #v(0.04cm)
    #line(length: 100%, stroke: 0.8pt + black)
  ]
}
