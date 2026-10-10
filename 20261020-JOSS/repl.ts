// 標準入力を 1 行ずつ JOSS として評価する入口。再実装本体は対話ループを持たないための補い。
// 各行の前に "* " を付けて入力を見せる (この表示は本体ではなくこのファイルの仕事)。
import { createInterface } from "node:readline";
import { Joss } from "/opt/joss/joss.ts";

const joss = new Joss(process.stdin, process.stdout);
for await (const line of createInterface({ input: process.stdin })) {
  if (line.trim() === "") continue;
  console.log(`* ${line}`);
  try {
    joss.eval(line);
  } catch (e) {
    console.log(`error: ${(e as Error).message}`);
  }
}
