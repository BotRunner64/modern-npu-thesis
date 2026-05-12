#import "../deps.typ": cap-style, i-figured, zh

// 统一编号格式状态：正文 "1-1"，附录 "A-1"
#let numbering-format = state("nwpu-numbering-format", "1-1")

#let with-numbering-format(format, it) = {
  numbering-format.update(format)
  show: cap-style.with(numbering-format: format)
  it
}

// 公式编号处理：研究生用半角括号 (1-1)，本科用全角括号 （1-1）
// 格式从 numbering-format 状态读取，附录自动切换
#let show-equation-handler(is-graduate) = {
  if is-graduate {
    i-figured.show-equation.with(
      numbering: (..nums) => context {
        numbering("(" + numbering-format.get() + ")", ..nums)
      },
    )
  } else {
    i-figured.show-equation.with(
      numbering: (..nums) => context {
        [（#numbering(numbering-format.get(), ..nums)）]
      },
    )
  }
}
