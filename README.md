###Purpose
redis bloomFilter  as a cache filtering，a web object is cached only when  it has been accessed  at least once. I‘m going to assume that a lot of vicious access  are never written to the cache, and then query from database that increase the disk read workload.  Further, filtering out the one-hit-wonders also saves cache space on disk, increasing the cache hit rates.

### Required
redis >= 2.2
lua  >= 5.1
php >= 5.6
luabit  stable

###Example
```php
#add
$redis = new Redis();
$redis->connect('127.0.0.1', 6379);
$script = file_get_contents('add.lua');
$sha = $redis->script('load', $script);
$test = $redis->evalSha($sha,['tinycoder@163.com']);
echo $redis->getLastError();
```
```php
#check
$redis = new Redis();
$redis->connect('127.0.0.1');
$script = file_get_contents('check.lua');
$sha = $redis->script('load', $script);
$ret = $redis->evalSha($sha,['tinycoder@163.com']);
echo $ret;
echo $redis->getLastError();
```
