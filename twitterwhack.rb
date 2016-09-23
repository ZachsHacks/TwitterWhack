require 'open-uri'
require 'twitter'
require 'byebug'

class TwitterWhack

	def initialize(first_word, second_word, num_of_tweets)
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key    = "PeG04pQbZR5N4GUHJ4kReTHS9"
			config.consumer_secret = "J9DXcXaZOUfOWyaQhVPplFB1N6GYEVoPblz8L4quoSbV0TdH4p"
			config.access_token    = "231970064-EXYSBDWDqFzwuceDQS2wjA4DU6ki9PJ1GbGErh5Q"
			config.access_token_secret = "5IrOjLM3HEkL1uJelEF41ygpigMQn35OdFCUTyPkoamtK"
		end

		@index = 0
		@first_i = 0
		@second_i = 0
		begin
			return	whacker(first_word, second_word, num_of_tweets)
		rescue Twitter::Error::TooManyRequests => error
			p "Error, trying again soon..."
			# 	# NOTE: Your process could go to sleep for up to 15 minutes but if you
			# 	# retry any sooner, it will almost certainly fail with the same exception.
			sleep error.rate_limit.reset_in + 1
			retry
		end
	end


	def whacker(first_word, second_word, num_of_tweets)
		index = whackIndex(first_word, second_word, num_of_tweets)
		score = whackScore(first_word, second_word, num_of_tweets)
		@string =  "Your words (#{first_word} and #{second_word}) gave an index of #{index} with a score of #{score}."
	end

	def to_s
		return "#{@string}"
	end

	def results
		if @index < 4
			return "Wow that's amazing!"
	 elsif @index >= 4 && @index < 7
		 return "You did ok, but keep trying!"
	 else
		 return "Try again, your score is not competitive enough."
	 end
	end

	def whackIndex(first_word, second_word, num_of_tweets)
		@client.search("to: #{first_word} #{second_word}", result_type: "recent").take("#{num_of_tweets}".to_i).each do |tweet|
			@index += 1
			if (@index < 2)
				@example = tweet.text
			end
		end
		return @index
	end

	def example
		@example
	end

	def whackScore(first_word, second_word, num_of_tweets)
		@client.search("to: #{first_word}", result_type: "recent").take("#{num_of_tweets}".to_i).each do |tweet|
			@first_i += 1
		end
		@client.search("to: #{second_word}", result_type: "recent").take("#{num_of_tweets}".to_i).each do |tweet|
			@second_i += 1
		end
		return @first_i * @second_i
	end
end
#
# tw = TwitterWhack.new("iphone 7", "hiss", 1000)
#   puts tw.to_s
