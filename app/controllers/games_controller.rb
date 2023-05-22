class GamesController < ApplicationController
  require "json"
  require "open-uri"

  def new
    @letters = []
    10.times do
      @letters.push(("A".."Z").to_a.sample.to_s)
    end
    @letters
  end

  def score
    @attempt = params[:attempt]
    @letters = params[:letters]
    if contain_letter(@attempt, @letters) == false
      return @result = "Sorry, your word cannot be made with the grid"
    elsif is_english?(@attempt) == false
      return @result = "Your word is not an english word"
    else
      return @result = "Your score is #{@attempt.size}"
    end
  end

  def contain_letter(attempt, grid)
    letters = attempt.upcase.chars
    letters.all? { |letter| grid.count(letter) >= letters.count(letter) }
  end

  def is_english?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    found_serialized = URI.open(url).read
    found = JSON.parse(found_serialized)
    found["found"] == true
  end
end
