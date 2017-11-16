require 'telegram/bot'

token = '#'
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

      user_id = '#'
      sy_token = '#'
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
        system "ffmpeg -y -i \"#{ogg}\" -acodec libmp3lame \"#{mp3}\""
      end
#change
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

        Dir.glob("#{@dir}/*.mp3").each do |ogg|
          system "rm \"#{ogg}\""
        end
      else
        bot.api.sendMessage(chat_id: message.chat.id, text: "Sorry, i don't understand")
      end
      time = Time.now
      open('log.txt', 'a') { |f|
        f.puts (time.inspect + " >> #{chat_id}")
      }
    end

  end
end
