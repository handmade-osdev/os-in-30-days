"src47"の使い方の説明                      2005/01/08 川合秀実
                                           2005/02/13 小柳雅明
１．これは何か？

  "src47"は、OSASK ver.4.7の「OSASK.EXE」を生成するのに必要なモジュールのソース
プログラムのセットです。

２．makeの方法

  まず、tolset08を準備します。といってもこのドキュメントを書いている現時点では
tolset08はまだできていません。tolset08を待てない人は、osa_dir2に最新ツールをど
んどん入れ込んで、さらにgolib00w.exeをgolib00.exeにリネームすれば、多分tolset08
相当になると思います。手っ取り早い方法としては、
  http://www.afis.to/‾mone/osask/osask_ml/200412/msg00018.html
を土台にしていじるのが楽そうです。

  さて、tolset08はできたら、このsrc47をtolsetディレクトリの中に入れます。変に深
いところや、tolsetの外などに置いてはいけません。いや、あえてそうしたければそう
してもかまいませんが、その場合はあちこちにあるMakefile内のTOOLPATHを修正しなけ
ればいけないと思います。

  それで、使っているOSに応じて!cons_98.batかもしくは!cons_nt.batを実行し、プロ
ンプトが出たら、

prompt>make img_at

としてください。OSASK_AT.EXE、OSASK_AT.SYS、OSAIMGAT.BINが自動で生成されます。
「make img_tw」ならTOWNS版、「make img_ne」ならNEC98版がそれぞれできます。
「make img_qe」ならqemu版、「make img_vm」ならVMware版、「make img_bo」なら
Bochs版ができます。

EXE版のみを生成する場合は、
「make at」ならPC/AT版、「make tw」ならTOWNS版、「make ne」ならNEC98版が、
「make qe」ならqemu版、「make vm」ならVMware ver.3版、「make img_bo」なら
Bochs版ができます。

※Bochsは1.3以降を使用して下さい。VMwareはversion4.5以降では、PC/AT版の
バイナリがそのまま使えます。

３．テスト実行の方法

  プロンプトで「make run」とすると、OSASKのqemu版を自動で生成した後に、実行し
てくれます。

４．カスタマイズ

  make_inc.txtを編集することで、ウィンドウデザインやデフォルト半角フォントなど
を変更することができます。

５．著作権とライセンス

  著作権については、該当するOSASKの一般公開版に付属するCOPYRIGHT.TXTを参照して
ください。このアーカイブ内の全てのファイルに対してKL-01を適用します。
