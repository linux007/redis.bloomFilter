<?php

$redis = new Redis();
$redis->connect('127.0.0.1');
$script = file_get_contents('/data/webroot/lua/check.lua');
$sha = $redis->script('load', $script);
$ret = $redis->evalSha($sha,['php']);
echo $ret;
echo $redis->getLastError();