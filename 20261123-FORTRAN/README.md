# FORTRAN を試す (2026-11-23)

「古今東西 プログラミング言語紹介」2026-11-23 回の実験環境です。

## 使い方

```bash
./run.sh                                          # 対話シェル (bash) に入る
./run.sh gfortran -o /tmp/hello /work/hello.f90   # 自由形式 (.f90) をコンパイルする
./run.sh bash -s < demo.sh                        # 全部を順に実行する
./run.sh bash -c 'cd /work && gfortran -o /tmp/f fixed_form.f && /tmp/f'   # 固定形式 (.f) を 1 本だけ動かす
```

`container` (macOS 26 の Apple container) / `docker` / `podman` のいずれかがあれば動きます。
`demo/` が `/work` に入ります。拡張子 `.f` は固定形式、`.f90` は自由形式として扱われます。

## 処理系について

公式イメージ `gcc:16.2.0-trixie` (GCC 16.2.0、2026-08-07 リリース。gfortran 入り。GPL) を、
マニフェストの digest で固定して使います。arm64 / amd64 の両方が配られています。

gfortran は Fortran 95 を土台に、2003 / 2008 をほぼ、2018 を一部実装します。
`-std=` に指定できるのは `f95` `f2003` `f2008` `f2018` `f2023` `gnu` `legacy` で、
**`-std=f77` や `-std=f66` はありません**。昔のコードは既定のまま (または `-std=legacy`) で通し、
新しい規格では削除された機能がエラーになる様子を `-std=f2018` で見せます。

## 入っているもの

| ファイル | 内容 |
|---|---|
| `demo/hello.f90` | Hello World (自由形式) |
| `demo/fixed_form.f` | 固定形式 (FORTRAN 77 風)。桁位置・文番号・暗黙の型・FORMAT |
| `demo/old_flow.f` | 算術 IF と GO TO。`-std=f2018` では**エラーになる** (削除済みの機能) |
| `demo/implicit_trap.f` | `DO 10 I = 1.10` はループではなく代入になる (空白に意味がない固定形式の罠) |
| `demo/hollerith.f` | ホレリス定数 (`4HFORT`)。`-std=f2018` では**エラーになる**、`-std=legacy` で通る |
| `demo/modern.f90` | 現代の Fortran。module・配列演算・`where`・`do concurrent`・`matmul` |
