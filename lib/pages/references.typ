#import "../gb7714-bilingual/lib.typ": gb7714-bibliography, format-authors

#let is-other-entry(entry) = {
  let raw-type = lower(str(entry.raw-entry-type))
  let fields = entry.fields
  let subtype = lower(str(fields.at("entrysubtype", default: "")))
  let note = lower(str(fields.at("note", default: "")))
  let mark = str(fields.at("mark", default: fields.at("usera", default: "")))
  let medium = str(fields.at("medium", default: ""))
  let url = str(fields.at("url", default: fields.at("howpublished", default: "")))

  (
    raw-type == "other"
      or subtype == "other"
      or note == "other"
      or (raw-type in ("misc", "unknown") and url != "" and mark == "" and medium == "")
  )
}

#let render-custom-patent(entry) = {
  let fields = entry.fields
  let owner = format-authors(entry.parsed-names, entry.lang)
  let title = fields.at("title", default: "")
  let country = fields.at("location", default: fields.at("address", default: ""))
  let patent-number = fields.at("number", default: fields.at("call-number", default: ""))
  let publish-date = fields.at("date", default: fields.at("issued", default: fields.at("year", default: "")))

  let body = []
  if owner != "" {
    body += [#owner. ]
  }
  body += [#title]
  body += [[P]. ]
  if country != "" {
    body += [#country: ]
  }
  if patent-number != "" {
    body += [#patent-number]
  }
  if patent-number != "" and publish-date != "" {
    body += [, ]
  }
  if publish-date != "" {
    body += [#publish-date]
  }
  body += [. #entry.ref-label]
  body
}

#let render-custom-conference(entry, graduate: false) = {
  let fields = entry.fields
  let lang = entry.lang
  let author = format-authors(entry.parsed-names, lang)
  let editor-names = entry.parsed-names.at("editor", default: ())
  let editor = if editor-names.len() > 0 { format-authors((author: (), editor: editor-names), lang) } else { "" }
  let title = fields.at("title", default: "")
  let proceedings-title = fields.at("booktitle", default: fields.at("titleaddon", default: ""))
  let location = fields.at("location", default: fields.at("address", default: ""))
  let publisher = fields.at("publisher", default: fields.at("institution", default: ""))
  let year = str(fields.at("year", default: fields.at("date", default: "")))
  let pages = str(fields.at("pages", default: "")).replace("--", "-")
  let in-prefix = if lang == "zh" { "见：" } else { "In: " }
  let pub-sep = if lang == "zh" { "：" } else { ": " }
  let year-sep = if lang == "zh" { "，" } else { ", " }

  let body = []
  if author != "" {
    body += [#author. ]
  }
  body += [#title]
  if graduate {
    body += [[C]. ]
  } else {
    body += [[A]. ]
    body += [#in-prefix]
    if editor != "" {
      body += [#editor. ]
    }
    if proceedings-title != "" {
      body += [#proceedings-title]
      body += [[C]. ]
    }
  }
  if location != "" {
    body += [#location#pub-sep]
  }
  if publisher != "" {
    body += [#publisher]
  }
  if publisher != "" and year != "" {
    body += [#year-sep]
  }
  if year != "" {
    body += [#year]
  }
  if pages != "" {
    if graduate {
      body += [: #pages. #entry.ref-label]
    } else {
      body += [. #pages. #entry.ref-label]
    }
  } else {
    body += [. #entry.ref-label]
  }
  body
}

#let render-custom-other(entry) = {
  let fields = entry.fields
  let lang = entry.lang
  let author = format-authors(entry.parsed-names, entry.lang)
  let title = fields.at("title", default: "")
  let publish-date = str(fields.at("date", default: fields.at("year", default: fields.at("issued", default: fields.at("updated", default: "")))))
  let cited-date = str(fields.at("urldate", default: fields.at("accessed", default: "")))
  let url = str(fields.at("url", default: fields.at("howpublished", default: "")))

  let body = []
  if author != "" {
    body += [#author. ]
  }
  if title != "" {
    body += [#title. ]
  }
  if publish-date != "" {
    body += [#publish-date]
    if cited-date != "" {
      body += [/#cited-date]
    }
    body += [. ]
  } else if cited-date != "" {
    body += [/#cited-date. ]
  }
  if url != "" {
    body += [#url. #entry.ref-label]
  } else {
    body += [#entry.ref-label]
  }
  body
}

#let render-custom-standard(entry) = {
  let fields = entry.fields
  let lang = entry.lang
  let drafter = format-authors(entry.parsed-names, lang, allow-anonymous: false)
  let standard-number = str(fields.at("number", default: fields.at("serial-number", default: "")))
  let title = fields.at("title", default: "")
  let location = fields.at("location", default: fields.at("address", default: ""))
  let publisher = fields.at("publisher", default: fields.at("institution", default: ""))
  let year = str(fields.at("year", default: fields.at("date", default: "")))

  let body = []
  if drafter != "" {
    body += [#drafter. ]
  }
  if standard-number != "" and title != "" {
    body += [#(standard-number + "，" + str(title))]
  } else if standard-number != "" {
    body += [#standard-number]
  } else if title != "" {
    body += [#title]
  }
  if location == "" and publisher == "" and year == "" {
    body += [[S]. #entry.ref-label]
    return body
  }

  body += [[S]. ]
  if location != "" {
    body += [#location]
    if publisher != "" {
      body += [：]
    } else if year != "" {
      body += [，]
    } else {
      body += [. #entry.ref-label]
      return body
    }
  }
  if publisher != "" {
    body += [#publisher]
    if year != "" {
      body += [，]
    } else {
      body += [. #entry.ref-label]
      return body
    }
  }
  if year != "" {
    body += [#year. #entry.ref-label]
  } else {
    body += [#entry.ref-label]
  }
  body
}

#let bilingual-bibliography(
  graduate: false,
  english-writing: false,
  title: auto,
  full: false,
) = {
  if title == auto {
    title = if english-writing { "References" } else { "参考文献" }
  }

  heading(level: 1, numbering: none, outlined: true)[#title]

  gb7714-bibliography(
    title: none,
    full: full,
    full-control: entries => {
      set par(
        hanging-indent: 0em,
        first-line-indent: if graduate { (amount: 2em, all: true) } else { (amount: 0em, all: true) },
      )
      for entry in entries {
        if entry.entry-type == "patent" {
          [[#entry.order]#h(0.5em)#render-custom-patent(entry)]
        } else if entry.entry-type == "inproceedings" or entry.entry-type == "conference" {
          [[#entry.order]#h(0.5em)#render-custom-conference(entry, graduate: graduate)]
        } else if is-other-entry(entry) {
          [[#entry.order]#h(0.5em)#render-custom-other(entry)]
        } else if entry.entry-type == "standard" {
          [[#entry.order]#h(0.5em)#render-custom-standard(entry)]
        } else {
          [[#entry.order]#h(0.5em)#entry.labeled-rendered]
        }
        parbreak()
      }
    },
  )
}
