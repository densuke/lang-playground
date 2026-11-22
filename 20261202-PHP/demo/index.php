<?php $prices = ['りんご' => 120, 'みかん' => 80, 'ぶどう' => 300]; ?>
<h1>今日の値段</h1>
<ul>
<?php foreach ($prices as $name => $yen): ?>
  <li><?= $name ?> <?= $yen ?>円</li>
<?php endforeach; ?>
</ul>
<p>PHP <?= PHP_VERSION ?> で生成</p>
