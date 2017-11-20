# Voitextbot
Bot for Telegram on Ruby.

- [About](#about)
- [Quick start](#quick-start)
  - [Get Telegram token](#about)
  - [Get Yandex SpeechKit token and user ID](#quick-start)
  - [Select language](#about)
  - [Start](#about)

About:
------
Voitextbot is a Telegram bot. Voitextbot can convert both sent and forwarded voice messages to text.
By default bot works with Russian language, but you car easily change this

Quick start:
------------

  1. Clone project

  ```bash
  git clone https://github.com/NarekChang/voitextbot
  ```

  2. Get token from [@BotFather](t.me/BotFather)
  ```bash
  token = '#'
  ```

  3. Get token and login from [Yandex SpechKit](https://tech.yandex.ru/speechkit/)
  ```bash
  user_id = '#'
  sy_token = '#'
  ```

  4. Select your language
  ```bash
  uri = URI.parse("https://asr.yandex.net/asr_xml?uuid=#{user_id}&key=#{sy_token}&topic=notes&lang=langCode-LANGCODE")
  ```

  5. Start
  ```bash
  ruby index.rb
  ```

