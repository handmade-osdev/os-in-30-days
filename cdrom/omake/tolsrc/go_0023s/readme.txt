"go_0020s"について                              川合秀実  kawai@imasy.org

・これは何か？

  これは、go_0020w/go_0020oのソースです。go_0020wというのは、gcc-3.2を改造して
作ったコンパイラのwin32版バイナリです。go_0020oはそのOSASK版です。

  細かいことをいうと、このgo_0020sは、gcc-3.2のソースにgo_0020pのパッチをあてた
後のソースです。go_0020sだけで全てのソースが含まれていますので、go_0020sを持っ
ていればgo_0020pは不要です。

  （姉妹品のまとめ）
    go_0020w : win32版バイナリ               (GPL)
    go_0020o : OSASK版バイナリ               (GPL)
    go_0020s : go_0020w, oのソース           (GPL)
    go_0020p : go_0020sとgcc-3.2ソースの差分 (KL-01)

・どうやって、実行バイナリを作るのか？

  makeに先立ち、include/rule.makを設定します。まずディレクトリgo_0020sの中で
setmode goとすれば、win32上のGOでmakeできる状態になります。またsetmode gccとす
れば、win32のAPIを直接呼び出すことはしないでANSI-Cの標準ライブラリだけを使うよ
うになります。この状態ならMinGWやGO+w32clibcでmakeできる状態になります。いずれ
にしてもこのrule.makは雛形でしかないので、各自の環境に合わせてパスを書き込んで
ください（w32clibcを使うなら、include/rule.makをさらに若干書き換える必要がある
でしょう）。

  go版の場合、go_0009wかそれ以降でmakeします。基本的にはディレクトリgccの中で
"make"とすれば、cpp0.exe、cc1.exe、cc1plus.exeの3つができます。詳しいことは
Makefileを解析してください。簡単な構造ですから、読めると思います。3つができた後
にupx -9 *.exeとすれば、それぞれふさわしいサイズになります。

  gcc版の場合は、まず下記の通りに、golib00、gas2nask、naskcnv0、sjisconvのstdc
版を作ります（これらのツールはcpp0、cc1、cc1plusの生成に必要）。そしてディレク
トリgccの中で"make"とすれば、cpp0.exe、cc1.exe、cc1plus.exeの3つができます。

  また、ディレクトリgccの中で"make -r osaskgo.bin"とすれば、OSASK版のバイナリも
できます。

  golib00w、gas2nask、nask、sjisconv、naskcnv0については、toolw32とtoolstdcの両
方に入っています。setmode goの場合は、toolw32の中でmakeとすれば、それぞれ生成さ
れます。setmode gccの場合は、toolstdcの中でmakeします。それぞれupxすると、配布
版バイナリになります。

・ライセンスについて

  このソースセットはGPLでライセンスします。もし、GPLではなくKL-01でライセンスさ
れたソースがほしい人は、go_0020pのほうを当たってください。

  なお以下のディレクトリに関しては、例外的にKL-01(川合堂ライセンス-01)です。
    drv_osa, drv_stdc, drv_w32, funcs, go_lib, nasklib, omake, toolstdc,
    toolw32, w32clibc

  GPLのライセンス文はCopyingに、KL-01のライセンス文は以下のURLにあります。
        http://www.imasy.org/~mone/kawaido/license01-1.0.html

  GPL部分の著作権については、それぞれの元著作者に帰します。KL-01部分の著作権に
ついては、go_lib内のstring系関数群の著作権はGakuさんに、それ以外は川合に帰しま
す。

・libmingw.libについて

  libmingwは、MinGWのライブラリから実行バイナリ生成にどうしても必要なものだけを
集めた簡易ライブラリです。このライセンスは当然GPLです。

・謝辞

  gccの開発者のみなさまに心からの謝辞をささげます。もしこのgoの一部がgccの開発
者の方々に認めていただけたら、こんなに嬉しいことはありません。

  Gakuさんのstringライブラリを使わせていただきました。Gakuさん、ありがとうござ
います。

  また開発を直接助けてくれた、くーみんさん、henohenoさん、そしてOSASKコミュニテ
ィーのみなさま、ありがとうございました。

  なお、川合の2002.10.03～2003.02.28の期間のおける開発成果は、特別認可法人 情報
処理振興事業協会 (IPA) の「未踏ソフトウェア創造事業未踏ユース」での委託業務によ
るものです。この場を借りて支援をいただけたことにたいしてお礼申し上げます。

・どこが変わったか？

  機能的な違いについては、バイナリ版を参照してください。ここでは、ソースレベル
での違いだけに言及しています。

< go_0000s → go_0001s >

  includeディレクトリ内の2つのファイルを削除しました。これはmakeに不要なファイ
ルでした。ソース内の改行コードが、CRLFとLFのみのものが混在していました。LFのみ
に統一しました。delaln32のバイナリとソースも一応入れておくことにしました。

< go_0001s → go_0002s >

  ドライバ(drv_stdc)内のファイル以外の全ては、外部のインクルードファイルを必要
としません。自分が持っているライブラリだけで動いています。必要なのは以下の5関数
main0, GOL_open, GOL_close, GOL_stepdir, GOL_sysabort
だけです。これらは環境に依存して書かれるものです。これらは、もちろん、標準ライ
ブラリのみで記述することができ、それはdrv_stdcに入っています。これは、
malloc, fopen, fseek, ftell, fread, fclose, fwrite, fputs
だけで書かれています。
  ドライバとcallmain.cを除く全てのファイルは、go_0002wでコンパイルできます。
環境に依存するドライバとcallmain.cはMinGWでコンパイルする必要があります。
  くわしくはMakefileを参照してください。

< go_0002s → go_0004s >

  stdcドライバのほかに、w32ドライバを用意しました。これはMinGWを持っていなくて
もコンパイルできます。またstdc版よりもコンパクトです。
  golib00wを作ったのでソースを入れました。
  Makefileをgo_0004wしか使わないように書き換えました。
  libmingwが必要になったので加えました。

< go_0004s → go_0005s >

  一般公開に向け、ドキュメントを少し直しました。それだけです。

< go_0005s → go_0006s >

  gas2naskとnaskを追加してMakefileを書き換え、cc1とcc1plusをわずかに改良しまし
た(必要なアライン命令を明示的に出力します)。

< go_0006s → go_0007s >

  sjisconvとnaskcnv0を追加し、drv_osaを加え、naskをOSASK版とソース共用できる形
式にあらため、cc1とcc1plusのセクションまわりのバグを修正し、golib00wで長いファ
イル名でのバグを直しました。

< go_0007s → go_0008p >

  [OSASK 5584]でgo_0007のNASKにバイナリーモード時のバグが見付かったので修正しま
した。

< go_0008p → go_0009s >

  osaskgo.binを作る場合に限って、ASKAが必要になりました。またdrv_osaの中のosama
in.cの中の関数refresh_static()はosaskgo.mapの記述にあわせて修正しなければいけな
い部分があるので注意が必要です。

< go_0009s → go_0011s >

  go_0010pでのnaskcnv0の修正を取り込んで、sjisconvをosaskgoにも入れた程度です。

< go_0011s → go_0012s >

  golib00のstdc版(golib00s)を追加しました。そしてdrv_stdcをまともにして、cc1な
どをLinux上などでもmakeできるようにしました。

< go_0012s → go_0013s >

  naskcnv0のstdc版(nskcn0bs)を追加しました。go_0012のバグも修正しました。

< go_0013s → go_0014s >

  gas2naskのstdc版（gas2nsks）を追加しました。

< go_0014s → go_0015s >

  naskのstdc版を追加しました。

< go_0015s → go_0017s >

  gas2naskのfsubrsバグを修正しました。

< go_0017s → go_0018s >

  gas2naskのバグを修正しました（fistps、fists、filds、stosl、fabs、fucomp、
fistps、fdivs）。win32-console用の簡易ライブラリを追加しました。

< go_0018s → go_0019s >

  バンドルしていたライブラリのヘッダファイルを間違えただけなので、go_0018sと
go_0019sの違いはこのドキュメントだけです。

< go_0019 → go_0020 >

  ソースレベルでの改訂をして、go版とgcc(stdc)版の違いを、include/rule.makだけに
しました。
  stdc版では、利用している関数を以前の12個から8個へとさらに減少させました。
    fopen, fclose, fread, fwrite, fseek, ftell, malloc, exit
もしくは、以下の6関数を作るだけでもいいです。
  GOLD_getsize(ファイルサイズ取得),
  GOLD_read(ファイルのバイナリモードリード -- 一括でファイル全体を読むだけ),
  GOLD_write_b(ファイルのバイナリモードライト -- 一括でファイル全体を書くだけ),
  GOLD_write_t(ファイルのテキストモードライト -- ファイルを書くときは一括、
                  コンソールへのメッセージ出力の場合は何度か呼ばれうる),
  GOLD_exit(exitとおなじ),
  malloc(mallocと同じ)
mallocについてはそれぞれのmain()の中で最初に1回呼んでいるだけですので、malloc関
数として作らなくても代替可能です。
  OS依存ドライバを、完全共通化しました。naskやgas2naskやsjisconvなどのディレク
トリを整理して、改変しやすくしました。この2点によって、機能が増えたにもかかわら
ず、ソースは25KB以上小さくなり、ファイル数は3つ減り、ディレクトリも7つ減ってい
ます。


・お問い合わせは？

  OSASK-MLか、OSASK伝言板へどうぞ。

               2003.11.12  川合秀実  kawai@imasy.org
