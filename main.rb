require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: 'no u', client_id: 219545310693687296, prefix: '$', log_mode: :info


bot.command(:exit, help_available: true, description: "shutdown the bot") do |event|
  break unless event.user.id == 117678528220233731
                                                                                                                         
  bot.send_message(event.channel.id, 'See ya soon.')
  exit                                                                                                                   
end

bot.command(:eval, help_available: true, description: "evaluate ruby code") do |event, *code|
  break unless event.user.id == 117678528220233731
                                                                                                                         
  begin
    eval code.join(' ')
  rescue
    "An error occured  "
  end
end

bot.command(:setgame, help_available: true, description: "change the game status to another thing") do |event, *game|
  break unless event.user.id == 117678528220233731
  g = "#{game.join(' ')}"
  
  event.bot.game = g
  bot.send_message(event.channel.id, "Set the game status to " + g)
end

=begin
this is the bee movie meme. 
please remove.
=end

bot.command(:memeify, help_available: true, description: "a meme") do |event|
	 bot.send_message(event.channel.id, "kill me now i removed it all")
end


bot.run
