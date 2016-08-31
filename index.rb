require 'telegram/bot'

token = '257482587:AAHkdako3TGWc1--PKt3evunrjZcz3lIBlw'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      end

    if message.voice

      require 'net/http'
      require 'net/https'
      require 'uri'
      require 'rubygems'
      require 'open-uri'

      user_id = '01ae13cb744628b58fb536d496daa2e6'
      sy_token = '66ce8a9b-9bdd-44c7-b461-6f78c1f88eb2'
      chat_id = message.chat.id
      f_name = "file#{chat_id}"

      v_id = message.voice.file_id
      v_file = bot.api.getFile(file_id: v_id)
      v_path = v_file['result']['file_path']
      f_url = "https://api.telegram.org/file/bot#{token}/#{v_path}"

      File.open("#{f_name}.mp3", 'w') do |file|
        file << open(f_url).read
      end
      bot.api.sendMessage(chat_id: message.chat.id, text: 'One minute, please')

      @dir = File.expand_path("../", __FILE__)

      Dir.glob("#{@dir}/*.mp3").each do |ogg|
        mp3 = ogg
        system "ffmpeg -i \"#{ogg}\" -acodec libmp3lame \"#{mp3}\""
      end

      uri = URI.parse("https://asr.yandex.net/asr_xml?uuid=#{user_id}&key=#{sy_token}&topic=notes&lang=ru-RU")
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'audio/x-mpeg-3'
      request.body = ''
      request.body << File.read("#{f_name}.mp3")

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end


      require 'active_support/core_ext/hash'

      xml = <<-XML
      #{response.body}
      XML

      hash = Hash.from_xml(xml)

      if hash['recognitionResults']['variant']
        if hash['recognitionResults']['variant'].class == Array
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{hash['recognitionResults']['variant'][0]}")
        else
          bot.api.sendMessage(chat_id: message.chat.id, text: "#{hash['recognitionResults']['variant']}")
        end
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Sorry, i don't understand")
      end
    end

  end
end
