require 'telegram/bot'
token = 'token'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.sendMessage(chat_id: message.chat.id, text: "Hi, #{message.from.first_name}")
      end

    if message.voice

      v_id = message.voice.file_id
      v_file = bot.api.getFile(file_id: id)
      v_path = v_file["result"]["file_path"]
      f_url = "https://api.telegram.org/file/bot#{token}/#{v_path}"

      bot.api.sendMessage(chat_id: message.chat.id, text: "Voice dwlnd link, #{f_url}")

    end

  end
end
