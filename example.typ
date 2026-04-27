// example.typ
// レポート本文の記述例

#import "template.typ": report, report-table

// コードブロックを見やすく整形・ハイライトする
#import "@preview/codelst:2.0.1": sourcecode
// 数式の参照・番号付け機能を拡張する
#import "@preview/equate:0.3.2": equate
#show: equate.with(number-mode: "label")
// 物理系の記法（微分記号など）を簡潔に書くためのマクロ群
#import "@preview/physica:0.9.8": *
// 日本語ダミーテキスト（Lorem Ipsum）を生成する
#import "@preview/roremu:0.1.0": roremu
// CJK 文字間で不自然な空きが入るのを抑制する
#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space
#show: remove-cjk-break-space

#show: report.with(
  // タイトルページ情報（必要に応じて上書き）
  title: "レポートタイトル",
  author: "山田太郎",
  student-id: "0000000",
  // date: datetime.today(),

  // ページ設定
  // paper: "a4",
  // margin: (x: 20mm, y: 25mm),

  // フォント設定
  // seriffont: "New Computer Modern",
  // seriffont-cjk: "Harano Aji Mincho",
  // sansfont: "Source Sans Pro",
  // sansfont-cjk: "Harano Aji Gothic",
  // monofont: "DejaVu Sans Mono",

  // 本文スタイル
  // fontsize: 10pt,
  // linespacing: 1.7,
  // non-cjk: regex("[\u0000-\u2023]"),
  // heading-numbering: "1.1.",
)



= 見出し

== 本文

== 数式の例

$
  pdv(E, x_1) = 2 f_1 pdv(f_1, x_1) + 2 f_2 pdv(f_2, x_1)
$ <eq:partial>

@eq:partial は $x_1$ に関する偏微分である。

== コード例

#sourcecode[
  ```python
  # example.py
  def square(x):
      return x * x
  ```
]

== 表の例

#report-table(
  header: ([カテゴリ], [詳細]),
  rows: (
    ([開催名], [週末ボードゲーム会]),
    ([開催日時], [2026年5月3日 13:00-18:00]),
    ([会場], [市民交流センター 2階 多目的室]),
    ([参加人数上限], [16名（先着順）]),
    ([持ち物], [飲み物、筆記用具、参加費 500円]),
  ),
  caption: [イベント運営の基本情報],
  label-name: "tbl:example",
)

@tbl:example にイベント運営の基本情報を示す。

= roremu の例

== 日本語ダミーテキスト（標準）

#roremu(8)

== 日本語ダミーテキスト（開始位置をずらす）

#roremu(8, offset: 8)

== 日本語ダミーテキスト（先頭文を指定）

#roremu(17, custom-text: "私はその人を常に先生と呼んでいた。")
