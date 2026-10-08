#import "lib/lib.typ": *
#show: touying-quick.with(
  title: "Programming Thinking",
  subtitle: "Write it once, reuse it everywhere",
  info: info-skill,
  bgimg: bghexagon,
)

= Programming Thinking

== Opening Question

#align(center + horizon)[
  #set text(size: 32pt)

  You have been using computers for years.

  But who actually calls the shots — *you*, or the *machine*?
]

== What Is "Programming Thinking"

#columns()[
  #set text(size: 18pt)

  It is not "writing code all day"; it is a habit:

  - Anything you would do a second time, *automate* it
  - Put every parameter in a *file*, instead of tuning it by hand
  - *Track* every change as it happens, instead of trusting your memory

  #colbreak()

  In practice, it comes down to three things:

  - Toolchains are set up by *commands*, not by clicking
  - Software behavior is decided by *configuration files*
  - Every change is recorded by a *version control tool*
]
\

#align(center + horizon)[
  All of these principles point to one keyword: *reproducible*.
]

== Today's Roadmap: Four Modules

#align(center + horizon)[
  #grid(
    columns: (1fr,) * 4,
    block(fill: rgb("#EAF2FF"), stroke: rgb("#BFD7FF"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *🛠 Module 1*\
        #set text(size: 18pt)
        WinGet / Scoop \
        System software \
        installed in one command
      ]
    ],
    block(fill: rgb("#EAFBEA"), stroke: rgb("#A8E6A8"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *🌳 Module 2*\
        #set text(size: 18pt)
        Git \
        Every change \
        leaves a trace
      ]
    ],
    block(fill: rgb("#FFF6E0"), stroke: rgb("#FFE08A"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *📝 Module 3*\
        #set text(size: 18pt)
        Markdown \
        Program docs
        are text themselves
      ]
    ],
    block(fill: rgb("#F3EAFF"), stroke: rgb("#D6BBFF"), inset: 10pt, radius: 18pt, width: 90%)[
      #align(center)[
        *📐 Module 4*\
        #set text(size: 18pt)
        Typst \
        Notes and slides \
        can be code too
      ]
    ],
  )
  \

  #set text(size: 28pt)
  Each module swaps a *habit of clicking* for a *file you can keep*.
]

== What You Need Today

#[
  #set text(size: 28pt)

  - A Windows 10 / 11 computer
  - A working internet connection
  - One attitude: *I write it once; the machine repeats it ten thousand times*
]

= Module 1 System Software Management

== Opening Question

#align(center + horizon)[
  #set text(size: 32pt)

  How do you usually *install software*?
  \
  \
  Download an installer and click *Next* all the way through? Or type *a single command*?
]

== Package, Dependency, Package Manager, Repository

#[
  A package manager is a toolset for automatically installing, upgrading, configuring, and uninstalling software (or dependency libraries). It saves the user the tedious work of downloading manually, hunting for dependencies, and setting environment variables.

  *Core concepts*

  - *Package*: a piece of software together with its version and its install, uninstall rules
  - *Dependency*: other software this one needs, resolved automatically by the manager
  - *Repository*: the official catalog the package manager searches
]

== Package Managers

#columns()[
  === OS-Level Package Managers

  - Windows:
    - Official: WinGet (Microsoft)
    - Community: Scoop, Chocolatey
  - macOS: Homebrew, MacPorts
  - Linux:
    - Debian/Ubuntu family: apt, dpkg
    - Red Hat/Fedora family: dnf
    - Arch Linux family: pacman
    - Nix family: Nix

  === Language-Level Package Managers

  - Python: pip, uv, Poetry, pipx, pdm
  - Node.js: npm, pnpm, bun, yarn
  - Java: Maven, Gradle
  - Rust: cargo
  - Go: go mod
  - C/C++: vcpkg

  === Cross-Language Package Managers

  - conda family: mamba/micromamba, pixi
  - spack
]

== Why Use a Package Manager

#align(center + horizon)[
  #set text(size: 18pt)
  #tableq(
    (
      ([Task], [Manual install], [Package manager]),
      ([Install software], [Find the site, pick a version, download, Next ×5, tick PATH], [`winget/scoop install xxx`]),
      ([Upgrade software], [Open each app and hunt for "Check for updates"], [`winget/scoop update`]),
      ([Move to a new machine], [Half a day, and you still miss one or two], [One script, run once]),
      ([Reproduce a colleague's environment], [Screenshots + a Word step-by-step doc], [Send one script file]),
      ([Clean uninstall], [Dig through Control Panel for leftovers], [`winget/scoop uninstall xxx`]),
    ),
    3,
  )
  \
  *One command beats ten clicks — and a command can be saved, shared, and replayed.*
]

== WinGet: Five Common Commands

#align(center + horizon)[
  #set text(size: 22pt)
  #tableq(
    (
      ([Command], [What it does]),
      ([`winget search git`], [Find a package in the official repository]),
      ([`winget install Git.Git`], [Install; the package ID must be exact]),
      ([`winget list`], [List every piece of software managed on this machine]),
      ([`winget upgrade --all`], [Upgrade all outdated software in one go]),
      ([`winget uninstall Git.Git`], [Remove a package cleanly]),
    ),
    2,
  )
  \
  *search → install → list → upgrade → uninstall.*
]

== Scoop: Why Developers Like It

#columns()[
  #set text(size: 18pt)

  *Its character*

  - Installing and managing it *needs no administrator rights*, so restricted accounts and shared lab machines work too
  - Install scripts are *JSON*, which reads well
  - *Extract and it is installed*; uninstalling leaves nothing behind
  - Highly extensible, so you can build your own buckets

  #colbreak()

  *Its cost*

  - Few GUIs are in the default buckets; you may have to write the script yourself
  - Coverage is thinner for software that needs administrator rights
  - It cannot shut down background services, so upgrades are easily interrupted by a process holding the files
  - Better suited to developers *who like to tinker* and want a customized environment
]

#tip[
  This is not either/or: Scoop handles the command line, WinGet fills in the GUIs, and the two coexist.
]

== Scoop: Install and Extend

#columns()[
  #set text(size: 22pt)

  === Allow this user to run scripts

  ```bash
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

  === Use a custom install directory

  ```bash
  irm get.scoop.sh -outfile 'install.ps1'
  .\install.ps1 -ScoopDir 'C:\Scoop' -NoProxy
  ```

  #colbreak()

  === Install the basics

  ```bash
  scoop install git aria2
  ```

  === Add the official extras bucket

  ```bash
  scoop bucket add extras
  ```

  === Add a custom bucket

  ```bash
  scoop bucket add extras-cn https://github.com/scoopforge/Extras-CN
  ```
]

== Scoop: Day-to-Day Management

#columns()[
  #set text(size: 20pt)

  *Five frequent commands*
  ```bash
  scoop search <app>   # find software
  scoop list           # what is installed
  scoop status         # what is out of date
  scoop cleanup        # remove old versions
  scoop checkup        # self-diagnosis
  ```

  #colbreak()

  *Two habits*

  - Installing `aria2` speeds up downloads with multiple threads; if you are behind a proxy, turn it off with
    `scoop config aria2-enabled false`
  - Use `scoop-completion`: type the first few letters, then press `Tab`

]

#tip[
  If you do not like the command line, you can drive Scoop and WinGet from the UniGetUI graphical interface.
]

== WinGet and Scoop: Two Designs

#align(center + horizon)[
  #set text(size: 22pt)
  #let data = csv("data/scoop-winget-en.csv")
  #figure(
    tableq(data, 3),
    caption: "Windows package managers compared",
  )
]

== Restore Your Machine Anywhere

#[
  #set text(size: 20pt)

  === Snapshot the machine you have now

  ```bash
  winget export -o packages.json
  ```

  === Replay it on another computer

  ```bash
  winget import -i packages.json --accept-package-agreements
  ```

  === Or simpler: a single `setup.ps1`

  ```bash
  winget install Git.Git --silent
  winget install Microsoft.VisualStudioCode --silent
  winget upgrade --all --silent
  ```
]

= Module 2 Managing Code Projects

== Opening Question

#align(center + horizon)[
  #set text(size: 28pt)

  Have you never seen a folder like this?
  \
  `report.docx` · `report_v2.docx` · `report_final_last_ever.docx`
  \
  Which one is *really* the final version?
]

== Why Git

#figure(
  image("vscode/images/git.png", height: 70%),
  caption: none,
)

#columns()[
  #set text(size: 18pt)

  - *Version control*: go back to any point in history at any time
  - *Traceability*: every line has an author and a reason
  - *Backup*: your work lives on more than one machine at once
  - *Branches*: experiment freely, merge only when it works
  - *Collaboration*: several people edit the same project without overwriting one another
]

== Four Areas, Three Groups of Commands

#align(center + horizon)[
  #set text(size: 22pt)
  #tableq(
    (
      ([Direction], [Command], [Meaning]),
      ([Working tree → staging area], [`git add`], [Pick out the changes for this commit]),
      ([Staging area → local repo], [`git commit`], [Freeze them together with a reason]),
      ([Local repo → remote repo], [`git push`], [Push a copy to the remote]),
      ([Remote repo → local repo], [`git fetch`], [Fetch only, do not merge]),
      ([Remote repo → working tree], [`git clone` / `git pull`], [Fetch the whole thing and merge]),
    ),
    3,
  )
  \
  *First work out which area your change is in, and you will never misremember a command.*
]

== One-Time Configuration

#columns()[
  #set text(size: 18pt)

  ```toml
  [user]
  name = ivaquero
  email = msaintms@outlook.com

  [credential]
  helper = store

  [commit]
  gpgsign = false

  [gpg]
  program = gpg

  [pull]
  rebase = false

  [merge]
  conflictstyle = diff3

  [diff]
  colorMoved = default

  [alias]
  # basics
  cf = config
  h = help
  ...
  ```
]

== .gitignore and Commit Messages

#columns()[
  #set text(size: 18pt)

  *`.gitignore` — what should not enter history*
  ```text
    .venv/
    __pycache__/
  *.pyc
    output/
  ```
  Environments and build artifacts are *regenerable*, so they do not belong in the repository.

  #colbreak()

  *A good commit message says "why"*
  ```text
  fix: convert shaft diameter from mm to m
  docs: add torque-twist lab procedure
  feat: plot twist angle vs torque
  ```
  `type: what you did` — your future self will read this line at two in the morning.
]

== A Real Session: From init to merge

#columns()[
  #set text(size: 16pt)

  *① Start a project*
  ```bash
  mkdir bearing-lab; cd bearing-lab
  git init
  # write README.md
  git add .
  git commit -m "docs: add lab skeleton"
  ```

  *② Try a risky change*
  ```bash
  git branch exp/new-material
  git switch exp/new-material
  # change torque.py freely; main stays clean
  git add torque.py
  git commit -m "feat: convert mm/GPa units"
  ```

  *③ Merge if it works out*
  ```bash
  git switch main
  git merge exp/new-material
  git log --oneline --graph
  ```

  #colbreak()

  *④ Put it somewhere safe*
  ```bash
  git remote add origin https://github.com/<you>/bearing-lab.git
  git push -u origin main
  ```

  *⑤ Get it back on another machine*
  ```bash
  git clone https://github.com/<you>/bearing-lab.git
  ```

  *Common branch and inspection commands*
  ```bash
  git branch <name>      # create a branch
  git switch <name>      # switch branches
  git branch -d <name>   # delete a merged branch
  git diff               # see the differences
  git blame <file>
  ```
]

= Module 3 Program Documentation

== Opening Question

#align(center + horizon)[
  #set text(size: 27pt)

  When you sit down to take study notes,
  \
  do you open *Word*, or a *plain text file*?
  \
  Same content — which one is easier to *template*, easier for *an AI to rewrite directly*?
]

== Word · Markdown · Typst

#align(center + horizon)[
  #set text(size: 18pt)
  #tableq(
    (
      ([Dimension], [Word], [Markdown], [Typst]),
      ([File], [.docx (binary)], [.md (plain text)], [.typ (plain text)]),
      ([Git diff], [✗ gibberish], [✓ readable], [✓ readable]),
      ([Layout control], [Drag and click], [~ limited], [✓ programmable, precise]),
      ([Math formulas], [Equation editor], [✓], [✓]),
      ([50 copies], [Copy, paste, rearrange], [✓ one template], [✓ one template + loops]),
      ([Best for], [Hand-off documents], [Notes, README, prompts], [Reports, slides, papers]),
    ),
    4,
  )
  \
  *Choose by purpose, not by habit — they all export the same PDF in the end.*
]

== What Markdown Is

#columns()[
  #set text(size: 18pt)

  Markdown is a *lightweight markup language* that is easy to read and write.
  What you type is already readable text,
  and in recent years it has been used widely for everyday writing and even for ebook publishing.

  Common free editors include

  - Closed source: Obsidian, Typora
  - Open source: Zettlr, MarkText

  #colbreak()

  *Why programmers prefer it*

  - The shortest path between you and an AI: *plain text in, plain text out*
  - Every edit shows up as a readable diff in Git
  - No formatting burden; all your attention goes to the content

]

#note[
  Of the three languages large models are most fluent in, Markdown is the only one *anyone can learn the same day*.
]

== Extensions for Writing Markdown

#columns()[
  #set text(size: 18pt)

  *Markdown All in One*: the all-in-one extension, number one in downloads among Markdown plugins

  - Shortcut commands and snippets
  - Automatic heading numbering, automatic table of contents
  - LaTeX math support

  *rumdl*: a linter and formatter

  - Helps you write standards-compliant documents and avoid syntax errors that break rendering
  - Fixes structural problems automatically on save

  #colbreak()

  *Markdown Inline Editor*: Typora-like live rendering

  - Write and see the result without a split preview
  - Supports all the basic syntax, and mermaid diagrams too

  *Extras for editing and output*

  - Draw.io: draw complex diagrams directly in its embedded extension
  - Word Count CJK: counts Chinese by *character* and English by *word*
  - Pandoc: the Swiss Army knife of document formats, handling the final export step
]

```bash
code --install-extension yzhang.markdown-all-in-one rvben.rumdl codesmith.markdown-inline-editor-vscode hediet.vscode-drawio
```

== Tables, Formulas, Code

#columns(2, gutter: 1em)[
  #set text(size: 18pt)

  *Markdown*: what you write is the content itself

  ```text
  # Shaft Torsion Lab

  ## 1. Objective

  Measure the **twist angle** of the steel shaft.

  | Case | T (N·m) | θ (°) |
  | ---- | ------- | ----- |
  | A    | 20      | 0.8421 |
  | B    | 35      | 1.4737 |
  ```

  #colbreak()

  *Typst*: layout goes into the source too

  ```typ
  #set page(paper: "a4")

  = Shaft Torsion Lab

  == 1. Objective

  Measure the *twist angle* of the steel shaft.

  #table(
    columns: 3,
    [Case], [T (N·m)], [θ (°)],
    [A], [20], [0.8421],
    [B], [35], [1.4737],
  )
  ```
]

== One Command Turns It into PDF / DOCX / HTML

#columns()[
  #set text(size: 20pt)

  *Starting from Markdown* (needs Pandoc)
  ```bash
  scoop install pandoc
  pandoc README.md -o README.docx
  pandoc README.md -o README.pdf
  ```

  *Starting from Typst*
  ```bash
  typst compile report.typ report.pdf
  ```
  #[
    #set text(size: 14pt)
    #tip[
      Exporting PDF needs a LaTeX engine and the right fonts on your machine; configure this once.
    ]
  ]

  #colbreak()

  *What you get in return*

  - Documents are *diffable*; a reviewer sees every change
  - A class of 60 people can share *a single template*
  - Change the institution's name once and 60 PDFs rebuild in seconds
  - It is text, so *an AI can read it, review it, and change it*

]

= Module 4 Notes and Slides

== Opening Question

#align(center + horizon)[
  #set text(size: 27pt)

  Markdown cannot produce paper-grade layout, \
  and LaTeX is heavy and hard to tune.
  \
  \
  Is there a *third way*?
]

== What Typst Is

#[
  Typst is a programmable markup language for publishing. It has variables, functions, and package management — the features of a modern programming language. It focuses on scientific writing and occupies the same niche as LaTeX, and it is currently LaTeX's strongest competitor: the concise syntax of Markdown plus LaTeX's varied layout, with compilation fast enough to write and watch at the same time.
]
\
\
#columns()[
  - Concise syntax: about as easy to pick up as Markdown
    - Fast compilation: written in Rust
    - Simple setup: develop locally in VSCode
    - A modern language: variables, functions, package management, and error checking

    - #link("https://typst.app/universe/search/?kind=packages")[Typst community]

    #colbreak()
    #figure(
      image("vscode/images/typst.png", width: 90%),
      caption: none,
    )
]

== Install and Editor Configuration

#columns()[
  #set text(size: 18pt)

  *Install the software*
  ```bash
  scoop install typst git
  # or
  winget install typst.typst
  ```

  *Then the formatter*
  ```bash
  scoop install typstyle
  ```

  *Install the Tinymist extension*

  ```bash
  code --install-extension myriad-dreamin.tinymist czhang03.unicode-math-input
  ```

  #[
    #set text(size: 14pt)
    #note[
      Companion extensions: Unicode Math Input helps you type math symbols, and an emoji is just an escaped `\:`.
    ]
  ]

  #colbreak()

  Write the following into `settings.json`.

  ```json
  {
    "[typst]": {
      "editor.defaultFormatter": "myriad-dreamin.tinymist"
    },
    "tinymist.formatterMode": "typstyle",
    "tinymist.lint.enabled": true,
    "tinymist.exportPdf": "onDocumentHasTitle",
    "tinymist.preview.cursorIndicator": true
  }
  ```
]



== One Source, Two Outputs

#columns()[
  #set text(size: 17pt)

  *Handouts and notes*: use `chapter-style` to lay out by chapter

  ```typ
  #import "lib/lib.typ":*
  #show: chapter-style.with(title: "Skill Tree")

  = Choosing Software
  == Selection Criteria
  ```


  *Slides*: use `touying-quick`, one heading per page

  ```typ
  #import "lib/lib.typ":*
  #show: touying-quick.with(title: "Programming Thinking")

  = Module 1
  == Opening Question
  ```

  #colbreak()

  *Two entry points into the same project*: shared content lives in `lib/` and `data/`

  - Table data goes in `data`, shared by the handout and the slides
  - Images go in `images/`, referenced with paths relative to the repository root
  - Code samples become real files and are pulled back in with `read()`, not copied into the document
  - Check existing packages before writing a custom function, so every page does not get its own layout

  #[
    #set text(size: 14pt)
    #tip[
      In short: one set of data, one template — however many files you produce, none of them needs re-laying-out.
    ]
  ]
]

== One Command to a PDF

#columns()[
  #set text(size: 18pt)

  *Produce the output*
  ```bash
  typst compile tech-thinking.typ out.pdf
  ```

  *Write and watch*
  ```bash
  typst watch tech-thinking.typ
  ```

  *Export an image sequence*

  ```bash
  typst compile --ppi 100 deck.typ "output/{0p}.png"
  ```

  #colbreak()

  *A few habits worth having early*

  - Pass the font path when compiling, or glyphs will be missing
  - If it does not fit on one page, *shrink the font or split the page* instead of cramming
  - Always use paths relative to the *repository root*; never write absolute paths
  - Errors point to an exact line and column; reading the first line is usually enough

]

#warning[
  Remember to put build output in `output` and add it to `.gitignore`: anything regenerable does not belong in the repository.
]

== The Page You Are Looking At

#align(center + horizon)[
  #set text(size: 24pt)

  Every slide you are looking at right now \
  is one *.typ file* in a Git repository.
  \
  \

  ```bash
  typst compile tech-thinking.typ tech-thinking.pdf
  ```

  \
  This lecture is itself the case study — content, data, images, and layout are all *reviewable and reusable*.
]

= Summary

== Self-Check

#columns(2, gutter: 1.5em)[
  #set text(size: 18pt)

  *System software*

  - ✓ `winget search / install / list / upgrade --all / uninstall`
  - ✓ `scoop install / bucket add / list / status / cleanup`
  - ✓ Explain what a package, a repository, and a dependency each are
  - ✓ Write a `setup.ps1` that lets the machine rebuild itself

  *Code projects*

  - ✓ `init → add → commit → status → log`
  - ✓ Create a branch and merge it back into main
  - ✓ Write a `.gitignore` and a decent commit message

  #colbreak()

  *Program docs*

  - ✓ Say what belongs in Markdown and what belongs in Typst
  - ✓ Use extensions to write clean Markdown and see it rendered
  - ✓ Turn plain text into PDF or DOCX with one command

  *Notes and slides*

  - ✓ Install typst and Tinymist so the editor can preview
  - ✓ Recognize the two entry points, `chapter-style` and `touying-quick`
  - ✓ Get the output with one compile command
]

== One Line to Take Home

#align(center + horizon)[
  #set text(size: 26pt)

  Programming thinking is not about *code*.

  It is refusing to do the same thing a second time — \
  anything you can *write once*, you never click through again.
  \
  \

  Click → command → script → repository

  \
  Today we walked only one stretch of that line; next, it is about letting *AI* walk the rest with you.
]
