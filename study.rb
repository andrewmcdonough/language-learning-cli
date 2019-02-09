#!/usr/bin/env ruby

require "colorize"
require_relative "./lib/word_list"

class Study
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
    @total = 0
    @score = 0
  end

  def list
    "./lists/#{from}-#{to}.txt"
  end

  def word_list
    @word_list ||=
      WordList.new(text: open(list).read)
  end

  def run
    loop do
      word_pair = word_list.random_pair
      question = word_pair.from
      display(question)
      say(question)
      given_answer = gets.chomp
      @total += 1

      if word_pair.correct_answer?(given_answer)
        @score += 1
        display_correct
      else
        display_incorrect(correct_answer: word_pair.to)
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

Study.new(
  from: "German",
  to: "English"
).run
