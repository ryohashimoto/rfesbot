require 'oauth'

CONSUMER_KEY = ""
CONSUMER_SECRET = ""

class Bot < OAuth::Consumer

  def start
  end

  def stop
  end

  def post
  end
end

bot = Bot.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "http://twitter.com")
request_token = bot.get_request_token
request_token.authorize_url
