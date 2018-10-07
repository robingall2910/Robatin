require 'discordrb'
require 'time_diff'
#kill me daddy -Seth
bot = Discordrb::Commands::CommandBot.new token: 'no u', client_id: 219545310693687296, prefix: '$', log_mode: :info

bot.ready do
  START_TIME = Time.now
end

bot.command(:exit, help_available: true, description: "shutdown the bot") do |event|
  break unless event.user.id == 117678528220233731
                                                                                                                         
  bot.send_message(event.channel.id, 'See ya soon.')
  exit                                                                                                                   
end

bot.command(:eval, help_available: true, description: "evaluate ruby code") do |event, *code|
  break unless event.user.id == 117678528220233731
                                                                                                                         
  begin
    eval code.join(' ')
  rescue => e
    "An error occured. ```rb\n#{e}\n```"
  end
end

bot.command(:setgame, help_available: true, description: "change the game status to another thing") do |event, *game|
  break unless event.user.id == 117678528220233731
  g = "#{game.join(' ')}"
  
  event.bot.game = g
  bot.send_message(event.channel.id, "Set the game status to " + g)
end


bot.command(:clean, help_available: false) do |event, num|
  event.channel.prune(num.to_i + 1) if event.user.id == 117678528220233731 or if event.server.owner.id
end

=begin
this is the bee movie meme. 
please remove.
=end

bot.command(:memeify, help_available: true, description: "a meme") do |event|
	 bot.send_message(event.channel.id, "kill me now i removed it all")
end

# Anime list searcher
bot.command :anime do |event, *args|
  anime = ''
  args.each do |str|
    anime = anime + str + '+'
  end
  anime = anime[0...-1]
  url = "http://myanimelist.net/api/anime/search.xml?q=" + anime
  # Requires MyAnimeList account
  doc = Nokogiri::XML(open(url, http_basic_authentication: ["MAL username", "MAL password"]))
  doc.xpath('//entry').each do |entry|

    event.respond entry.xpath('image').text

    response = "\n\n" + entry.xpath('title').text + "\n" + entry.xpath('english').text + "\n\n"
    response = response + "Score : " + entry.xpath('score').text + "\n\n"
    response = response + "Type : " + entry.xpath('type').text + "\n\n"
    response = response + "Episodes : " + entry.xpath('episodes').text + "\n\n"
    response = response + "Status : " + entry.xpath('status').text + "\n\n"

    end_date = entry.xpath('end_date').text

    # If manga is ongoing then the date will be 0000-00-00
    if end_date == "0000-00-00"
      end_date = "On-Going"
    end

    response = response + "Aired : " + entry.xpath('start_date').text + " - " + end_date + "\n\n"
    response = response + "Synopsis : \n" + entry.xpath('synopsis').text.gsub('<br />', "")

    event.respond response
    break
  end

end

# Manga API information bot
bot.command :manga do |event, *args|
  manga = ''
  args.each do |str|
    manga = manga + str + '+'
  end
  manga = manga[0...-1]
  url = "http://myanimelist.net/api/manga/search.xml?q=" + manga
  # Requires MyAnimeList account
  doc = Nokogiri::XML(open(url, http_basic_authentication: ["MAL username", "MAL password"]))

  doc.xpath('//entry').each do |entry|

    event.respond entry.xpath('image').text

    response = "\n\n" + entry.xpath('title').text + "\n" + entry.xpath('english').text + "\n\n"
    response = response + "Score : " + entry.xpath('score').text + "\n\n"
    response = response + "Chapters : " + entry.xpath('chapters').text + "\n\n"
    response = response + "Volumes : " + entry.xpath('volumes').text + "\n\n"
    response = response + "Status : " + entry.xpath('status').text + "\n\n"

    end_date = entry.xpath('end_date').text

    # If manga is ongoing then the date will be 0000-00-00
    if end_date == "0000-00-00"
      end_date = "On-Going"
    end

    response = response + "Aired : " + entry.xpath('start_date').text + " - " + end_date + "\n\n"
    response = response + "Synopsis : \n" + entry.xpath('synopsis').text.gsub('<br />', "")

    event.respond response
    break
  end

end

bot.run

g
