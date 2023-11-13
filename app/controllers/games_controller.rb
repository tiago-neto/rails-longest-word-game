require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle.sample(10)
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_dictionary = URI.open(url).read
    word = JSON.parse(word_dictionary)
    word["found"]
  end

  def score
    @answer = params[:word]
    @letters = params[:letters].split
    @result = @answer.chars.all? { |char| @letters.include?(char) }
    if @result == true && english_word == true
      @display = "Congratulations! Your answer is valid!"
    elsif english_word == false
      @display = "Your answer is not an english word"
    elsif @result == false
      @display = "Your answer doesn't contain the valid characters"
    else
      @display = "Your answer is not valid"
    end
  end
end
