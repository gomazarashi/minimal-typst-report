// example.typ
// レポート本文の記述例

#import "template.typ": report

#import "@preview/codelst:2.0.1": sourcecode
#import "@preview/equate:0.3.2": equate
#show: equate.with(number-mode: "label")
#import "@preview/physica:0.9.8": *
#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space
#show: remove-cjk-break-space

#show: report.with(
  title: "レポートタイトル",
  author: "山田太郎",
  student-id: "0000000",
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

#figure(
  table(
    columns: 2,
    [項目], [値],
    [A], [1],
    [B], [2],
  ),
  caption: [表の例],
) <tbl:example>

@tbl:example に例を示す。
= 見出し

== 本文

== 数式の例

$
  pdv(E, x_1) = 2 f_1 pdv(f_1, x_1) + 2 f_2 pdv(f_2, x_1)
$ <eq:partial_>
