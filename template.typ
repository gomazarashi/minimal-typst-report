// template.typ
// 公開用レポートテンプレート

// タイトルページを生成する関数
#let report-title(
  title, // レポートタイトル
  author, // 著者名
  student-id, // 学籍番号
  date, // 日付
) = {
  // PDF メタデータを設定
  set document(
    title: title,
    author: author,
  )

  // タイトルを中央寄せで表示
  align(center)[
    #text(size: 16pt, weight: 500)[#title]

    #v(8pt)

    #text(size: 10pt)[
      #author \
      学籍番号: #student-id \
      #date.display("[year]年[month]月[day]日")
    ]
  ]

  v(20pt)
}

// 三線表スタイルの表を生成する関数
#let report-table(
  columns: 2,
  align: (left, center),
  header: ([項目], [値]),
  rows: (),
  caption: [表],
  label-name: none,
) = {
  v(1em)
  let fig = figure(
    table(
      columns: columns,
      align: align,
      stroke: none,
      table.hline(y: 0, stroke: 1.2pt + black),
      table.header(..header),
      table.hline(y: 1, stroke: 0.5pt + black),
      ..rows.flatten(),
      table.hline(y: auto, stroke: 1.2pt + black),
    ),
    caption: caption,
  )
  if label-name != none {
    [#fig #label(label-name) #v(1em)]
  } else {
    [#fig #v(1em)]
  }
}

// レポート本体のフォーマットを適用する関数
#let report(
  // タイトルページの情報
  title: "タイトル", // レポートタイトル
  author: "氏名", // 著者名
  student-id: "0000000", // 学籍番号
  date: datetime.today(), // 日付
  // ページ設定
  paper: "a4", // 用紙サイズ
  margin: (x: 20mm, y: 25mm), // ページの余白（左右 20mm、上下 25mm）
  // フォント設定（セリフ体・サンセリフ体・等幅）
  seriffont: "New Computer Modern", // 英数字用セリフ体
  seriffont-cjk: "Harano Aji Mincho", // CJK用セリフ体
  sansfont: "Source Sans Pro", // 英数字用サンセリフ体
  sansfont-cjk: "Harano Aji Gothic", // CJK用サンセリフ体
  monofont: "DejaVu Sans Mono", // コード用等幅フォント
  // 本文スタイル
  fontsize: 10pt, // 本文フォントサイズ
  linespacing: 1.7, // 行間の倍率
  non-cjk: regex("[\u0000-\u2023]"), // 非CJK文字の範囲判定
  heading-numbering: "1.1.", // 見出しの番号付け形式
  body,
) = {
  // CJK 文字の高さ比率（行間計算用）
  let cjkheight = 0.88
  // 行間：指定行間 - CJK高さ相当分
  let linegap = linespacing * fontsize - cjkheight * fontsize

  // ページレイアウト設定
  set page(
    paper: paper, // 用紙サイズ
    margin: margin, // ページ余白
    numbering: "1/1", // ページ番号表示
  )

  // テキスト全体の設定
  set text(
    lang: "ja", // 言語設定（日本語）
    // フォント：非CJK文字用（セリフ体）、CJK文字用（別フォント）
    font: ((name: seriffont, covers: non-cjk), seriffont-cjk),
    size: fontsize, // フォントサイズ
    top-edge: cjkheight * fontsize, // 行高さ基準点
  )

  // 段落の設定
  set par(
    first-line-indent: (amount: 1em, all: true), // 段落の最初の行を 1em インデント（全段落対象）
    justify: true, // 両端揃え
    spacing: linegap, // 段落間隔
    leading: linegap, // 行高さ
  )

  // 見出しの番号付け形式を設定
  set heading(numbering: heading-numbering)

  // 表（figure kind: table）だけキャプションを上に配置
  show figure.where(kind: table): set figure.caption(position: top)

  // 見出し表示ルール：level 1 で数式カウンタをリセット
  show heading: it => {
    // 第1レベル見出しで式番号をリセット（章ごとに 1 から再開）
    if it.level == 1 {
      counter(math.equation).update(0)
    }

    // 見出しをサンセリフ体・太さ 500 で表示
    set text(
      font: ((name: sansfont, covers: non-cjk), sansfont-cjk),
      weight: 500,
    )

    it
  }

  // コード（raw）表示設定
  show raw: set text(
    font: (monofont, sansfont-cjk), // コードを等幅フォントで表示
  )

  // 数式環境の設定
  set math.cases(gap: 0.7em) // cases 環境の行間
  set math.mat(
    row-gap: 1em, // 行間
    column-gap: 1em, // 列間
  )

  // 数式の番号付け：(章番号.式番号) 形式
  set math.equation(
    numbering: (..nums) => {
      // 見出しカウンタから章番号を取得
      let h = counter(heading).get()
      let sec = h.at(0, default: 0)
      // 式番号を取得
      let eq = nums.pos().first()
      // (章.式) 形式で番号付け
      numbering("(1.1)", sec, eq)
    },
  )


  report-title(
    title,
    author,
    student-id,
    date,
  )

  body
}
