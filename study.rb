#!/usr/bin/env ruby

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
      WordList.new(text: open(list).read)
  end

  def run
    loop do
      word_pair = word_list.random_pair
      question = word_pair.from

      outputers.each { |outputer| outputer.output_question(question: question) }

      given_answer = gets.chomp
      @total += 1

      if word_pair.correct_answer?(given_answer)
        @score += 1
        outputers.each{ |outputer| outputer.output_correct(score: @score, total: @total) }
      else
        outputers.each{ |outputer| outputer.output_incorrect(correct_answer: word_pair.to,
                                                             score: @score,
                                                             total: @total) }
      end
    end
  end

  def display_correct
    puts "Correct! (#{@score}/#{@total})".colorize(:green)
  end

  def display_incorrect(correct_answer:)
    puts  "WRONG! The correct answer is ".colorize(:red) + correct_answer.colorize(:magenta)
  end

  def insert_spacing
    puts "\n"
    puts "\n"
    puts "*" * 80
    puts "\n"
    puts "\n"
  end

  def display(question)
    puts "-" * 40
    puts "| What is the #{to} for " + question.colorize(:yellow) + "?"
    puts "-" * 40
    puts "\n"
  end

  def say(question)
    say_cmd = "echo \"#{question}\" | say -v Anna"
    `#{say_cmd}`
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
