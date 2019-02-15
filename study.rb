#!/usr/bin/env ruby
# frozen_string_literal: true

require "colorize"
require_relative "./lib/word_list"
require_relative "./lib/big_box_outputer"
require_relative "./lib/apple_say_outputer"

class Study
  attr_reader :from_language, :to_language, :outputers

  def initialize(from_language:, to_language:, outputers:)
    @from_language = from_language
    @to_language = to_language
    @outputers = outputers
    @total = 0
    @score = 0
  end

  def list
    "./lists/#{from_language}-#{to_language}.txt"
  end

  def word_list
    @word_list ||=
      WordList.new(text: File.open(list).read)
  end

  def run
    loop do
      word_pair = word_list.random_pair
      ask_question(word_pair)
      check_answer(word_pair)
    end
  end

  def ask_question(word_pair)
    outputers.each { |outputer| outputer.output_question(question: word_pair.from) }
  end

  def check_answer(word_pair)
    given_answer = gets.chomp
    @total += 1
    if word_pair.correct_answer?(given_answer)
      @score += 1
      outputers.each { |outputer| outputer.output_correct(score: @score, total: @total) }
    else
      outputers.each do |outputer|
        outputer.output_incorrect(correct_answer: word_pair.to, score: @score, total: @total)
      end
    end
  end
end

from_language = "German"
to_language = "English"
Study.new(
  outputers: [
    BigBoxOutputer.new(from_language: from_language, to_language: to_language, output_stream: STDOUT),
    AppleSayOutputer.new(from_language: from_language, to_language: to_language)
  ],
  from_language: from_language,
  to_language: to_language
).run
