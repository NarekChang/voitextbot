require 'telegram/bot'
token = '257482587:AAHkdako3TGWc1--PKt3evunrjZcz3lIBlw'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Hello1, #{message.from.first_name}")
    end
  end
end
