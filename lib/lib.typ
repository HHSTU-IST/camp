#import "@preview/qooklet:0.7.2": *
#import "@preview/subpar:0.2.2": grid as sgrid
#import "@preview/rexllent:0.4.1": xlsx-parser

#import "@preview/touying-quick:0.5.0": *
#import "@preview/keyle:0.4.0": kbd

#let info-skill = toml("info.toml").skill
#let info-paper = toml("info.toml").paper
#let info-tool = toml("info.toml").tool
#let info-know = toml("info.toml").knowledge
#let info-man = toml("info.toml").management

#let info-camp = toml("info.toml").camp
#let info-foreign = toml("info.toml").foreign

#let modtones = (
  (fill: rgb("#EAF2FF"), stroke: rgb("#BFD7FF")),
  (fill: rgb("#EAFBEA"), stroke: rgb("#A8E6A8")),
  (fill: rgb("#FFF6E0"), stroke: rgb("#FFE08A")),
  (fill: rgb("#FFEFEF"), stroke: rgb("#FFC2C2")),
  (fill: rgb("#F3EAFF"), stroke: rgb("#D6BBFF")),
)

#let modgrid(cards, inset: 8pt, radius: 16pt, width: 90%, size: 15pt) = grid(
  columns: (1fr,) * cards.len(),
  ..cards.enumerate().map(((i, card)) => {
    let tone = modtones.at(card.at("tone", default: i))
    block(
      fill: tone.fill,
      stroke: tone.stroke,
      inset: inset,
      radius: radius,
      width: width,
    )[
      #align(center)[
        *#card.title*\
        #set text(size: size)
        #card.topic \
        #card.note
      ]
    ]
  }),
)
