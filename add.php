<?php

$redis = new Redis();
$redis->connect('127.0.0.1', 6379);


$script = file_get_contents('/data/webroot/lua/add.lua');
$sha = $redis->script('load', $script);

$test = $redis->evalSha($sha,['javascript']);

echo $redis->getLastError();



