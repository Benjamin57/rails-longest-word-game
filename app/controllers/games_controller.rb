require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    number = rand(1..10)
    @word_array = [*('A'..'Z')].sample(number)
  end

  def score
    @word = params[:question]
    @word_array = params[:word_array].chars
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = open(url).read
    result = JSON.parse(word_serialized)
    final = result["found"]
    if final == false
      @message = "is not an english word"
    elsif valid? == false
      @message = "does not corresspond"
    else
      @message = "you won"
    end
  end

  def valid?
    attempt = @word.split('')
    sum = 0
    attempt.each do |letter|
      count = @word_array.include?(letter)
      count ? sum += 1 : sum
      @word_array.delete(letter)
    end
    sum == attempt.length
  end
end
