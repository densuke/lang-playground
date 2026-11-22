<?php
// 手元の PHP が、サポート中の最新の修正版かを確かめる。
// 表は php.net の supported-versions / releases (2026-11-22 時点) から写したもの。
// 実際に使うときは、必ず php.net で最新の表を確かめること。
const LATEST = ['8.2' => '8.2.36', '8.3' => '8.3.37', '8.4' => '8.4.28', '8.5' => '8.5.13', '8.6' => '8.6.0'];
const EOL = ['8.2' => '2026-12-31', '8.3' => '2027-12-31', '8.4' => '2028-12-31', '8.5' => '2029-12-31', '8.6' => '2030-12-31'];

function check(string $version): string {
    $series = implode('.', array_slice(explode('.', $version), 0, 2));
    if (!isset(LATEST[$series])) {
        return "$version: サポート外の系統。更新が必要";
    }
    if (version_compare($version, LATEST[$series], '<')) {
        return "$version: " . LATEST[$series] . " 以降へ更新が必要";
    }
    return "$version: 最新の修正版 (セキュリティ修正の期限 " . EOL[$series] . ")";
}

foreach ([PHP_VERSION, '8.4.27', '8.1.30'] as $v) {
    echo check($v), PHP_EOL;
}
