<?php
// 同じ array 型が、リストにも辞書にもなる。順序は入れた順
$list = ['a', 'b', 'c'];
$dict = ['name' => 'PHP', 'year' => 1994];
$dict['site'] = 'php.net';
echo json_encode($list), "\n";
echo json_encode($dict), "\n";
// 型は値が決める。宣言は要らない
var_dump("5" + 3);
var_dump("5" . 3);
