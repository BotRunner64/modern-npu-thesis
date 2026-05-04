#import "@preview/cap-able:0.0.2": captab-style, capfig-style
#import "../utils/custom-numbering.typ": show-equation-handler

// 附录布局
#let appendix(
  graduate: false,
  english-writing: false,
  it,
) = {
  let appendix-label = if english-writing {
    "Appendix "
  } else if not graduate {
    "附 录"
  } else {
    "附录"
  }

  set heading(numbering: (..nums) => {
    let nums = nums.pos()
    if nums.len() == 1 {
      if not graduate {
        [#appendix-label]
      } else {
        [#appendix-label#numbering("A", nums.at(0))]
      }
    } else if nums.len() <= 3 {
      numbering("A.1", ..nums)
    }
  })
  counter(heading).update(0)

  show: captab-style.with(numbering-format: "A-1")
  show: capfig-style.with(numbering-format: "A-1")
  show math.equation.where(block: true): show-equation-handler("A-1", graduate)

  it
}
