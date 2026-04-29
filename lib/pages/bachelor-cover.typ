#import "../utils/datetime-display.typ": datetime-year-month
#import "../utils/style.typ": 字号

// 本科生封面
#let bachelor-cover(
  anonymous: false,
  info: (:),
) = {
  let stroke-width = 0.5pt
  let line-width = 5.5cm
  let title-line-width = 8cm

  // 参数处理
  info.submit-date = datetime-year-month(info.submit-date)

  // 内置辅助函数
  let mask-value(body) = {
    if anonymous { "████████" } else { body }
  }

  let underline-field(label, body, width: line-width, label-size: 字号.四号, value-size: 字号.四号) = {
    align(center)[
      #text(size: label-size)[#label]
      #box(width: 0.2cm)
      #box(width: width)[
        #set par(leading: 0em, spacing: 0em)
        #align(center)[
          #text(size: value-size, bottom-edge: "descender")[#body]
        ]
        #line(length: 100%, stroke: stroke-width + black)
      ]
    ]
  }

  // 4.  正式渲染

  // 居中对齐
  set align(center)
  v(2.3cm)
  image("../../template/figures/nwpulogo.png", width: 10cm)
  v(1.3cm)

  // 论文类型标题
  text(size: 字号.小初, weight: "bold")[本科毕业设计（论文）]

  v(3.5cm)

  block(width: 100%)[
    #underline-field("题　　目", info.title, width: title-line-width, label-size: 字号.三号, value-size: 字号.三号)
    #v(1.5cm)
    #underline-field("专业名称", info.major)
    #v(0.8cm)
    #underline-field("学生姓名", mask-value(info.author))
    #v(0.8cm)
    #underline-field("指导教师", mask-value(info.supervisor.at(0)))
    #v(0.8cm)
    #underline-field("毕业时间", info.submit-date)
    #v(1fr)
  ]
}
