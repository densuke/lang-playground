rocq --version
rocq compile /work/hello.v
rocq compile /work/rev_twice.v
rocq compile /work/bad_claim.v; echo "exit=$?"
rocq compile /work/bad_cheat.v; echo "exit=$?"
cd /tmp && cp /work/extract.v . && rocq compile extract.v && cat isort.ml && ocaml /work/run_isort.ml
