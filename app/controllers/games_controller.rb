require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # create answers instance
    @letters = ("a".."z").to_a.sample(10)
    # create empty hash to count letters

  end

  def score
    new
    @letters_hash = params[:letters_hash]
    @letters = params[:letters]
    # create answers instance
    @answer = params[:answer]
    # create empty hash to count letters
    @answer_hash = Hash.new(0)
    # iterate to push letters into a hash with counts
    @answer.chars.each do |letter|
      @answer_hash[letter] += 1
    end
    @letters_hash = Hash.new(0)
    # iterate to push letters into a hash with counts
    @letters.chars.each do |letter|
      @letters_hash[letter] += 1
    end
    # check if the answer matches
    @answer.chars.each do |letter|
      if @letters_hash[letter].nil?
        @check_letters = false
      elsif @answer_hash[letter] <= @letters_hash[letter]
        @check_letters = true
      else
        @check_letters = false
    end
    @check_if_word = check_if_word
    end
  end

  def check_if_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary_serialized = open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    dictionary["found"]
  end
end
