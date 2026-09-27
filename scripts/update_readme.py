#!/usr/bin/env python3
"""README.md の収録言語一覧を、各言語ディレクトリの README 1 行目から作り直す。

使い方:
    python3 scripts/update_readme.py          # README.md を書き換える
    python3 scripts/update_readme.py --check  # 一覧が古ければ終了コード 1

.githooks/pre-commit から --check が呼ばれる。clone ごとに一度だけ有効化する:
    git config core.hooksPath .githooks
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
README = ROOT / "README.md"
# 各言語 README の 1 行目: "# <言語> を試す (<YYYY-MM-DD>)"
TITLE = re.compile(r"# (.+) を試す \((\d{4}-\d{2}-\d{2})\)")
BLOCK = re.compile(r"(<!-- langs:start[^\n]*-->\n).*?(<!-- langs:end -->)", re.S)


def lang_rows():
    for d in sorted(ROOT.glob("2*/")):
        first = (d / "README.md").read_text().splitlines()[0]
        m = TITLE.fullmatch(first)
        if not m:
            sys.exit(f"{d.name}/README.md の 1 行目が「# 言語 を試す (日付)」形式でない: {first}")
        yield f"| {m[2]} | {m[1]} | [{d.name}]({d.name}) |"


def render(readme):
    table = "| 公開日 | 言語 | ディレクトリ |\n|---|---|---|\n" + "\n".join(lang_rows()) + "\n"
    new, n = BLOCK.subn(lambda m: m[1] + table + m[2], readme)
    if n != 1:
        sys.exit("README.md に langs:start / langs:end マーカーが無い")
    return new


def main():
    old = README.read_text()
    new = render(old)
    if "--check" in sys.argv[1:]:
        if new != old:
            sys.exit("README.md の収録言語一覧が古い。python3 scripts/update_readme.py を実行")
        return
    README.write_text(new)


if __name__ == "__main__":
    main()
