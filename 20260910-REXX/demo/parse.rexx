/* REXX らしい PARSE。区切り文字を並べるだけで文字列を切り分ける */
line = "2026-09-10 REXX"
parse var line yyyy '-' mm '-' dd ' ' name
say "年:" yyyy "月:" mm "日:" dd "言語:" name
