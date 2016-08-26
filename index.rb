require 'telegram/bot'
token = '257482587:AAHkdako3TGWc1--PKt3evunrjZcz3lIBlw'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.sendMessage(chat_id: message.chat.id, text: "Hi, #{message.from.first_name}")
      end

    if message.voice

      id = message.voice.file_id
      j = bot.api.getFile(file_id: id)
      path = j["result"]["file_path"]
      f_url = "https://api.telegram.org/file/bot#{token}/#{path}"

      bot.api.sendMessage(chat_id: message.chat.id, text: "Voice dwlnd link, #{f_url}")

    end

  end
end
