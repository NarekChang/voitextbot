<?php

$loader = require __DIR__.'/vendor/autoload.php';

$API_KEY = 'ключ_АПИ';
$BOT_NAME = 'имя_бота';

try {
    $telegram = new Longman\TelegramBot\Telegram($API_KEY, $BOT_NAME);

    echo $telegram->setWebHook('https://yourdomain/hook.php');
} catch (Longman\TelegramBot\Exception\TelegramException $e) {
    echo $e->getMessage();
}
