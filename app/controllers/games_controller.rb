require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("a".."z").to_a.sample }.join
  end

  def score
    @letters = params[:letters]
    @userinput = params[:input]
    if (params[:letters].each_char.include? params[:input].each_char) == false
        @response = "sorry but #{@userinput} can't be build out of #{@letters}"
    elsif parsing(@userinput) == false
      @response = "sorry #{@userinput} is not a valid English word"
    else
      @response = "Congratulation! #{@userinput} is a valid word!"
    end
  end

  def parsing(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["found"]
  end

end
