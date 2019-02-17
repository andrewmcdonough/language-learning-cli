#!/usr/bin/env ruby
# frozen_string_literal: true

require "colorize"
require_relative "./word_list"
require_relative "./big_box_outputer"
require_relative "./apple_say_outputer"

class Study
  attr_reader :from_language, :to_language, :outputers

  ADD_TO_IGNORE_LIST_SHORTCUT = "\\"

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

  def ignore_list_filename
    "./lists/#{from_language}-#{to_language}.ignore.txt"
  end

  def word_list
    @word_list ||=
      WordList.new(text: File.open(list).read)
  end

  def ignore_list
    @ignore_list ||= (File.exist?(ignore_list_filename) ? File.open(ignore_list_filename).read.split("\n") : [])
  end

  def add_to_ignore_list(word)
    ignore_list << word
  end

  def update_ignore_list
    File.open(ignore_list_filename, "w") do |fh|
      fh.write(ignore_list.join("\n"))
    end
  end

  def run
    loop do
      word_pair = word_list.random_pair
      next if ignore_list.include?(word_pair.from)

      ask_question(word_pair)
      check_answer(word_pair)
    end
  ensure
    update_ignore_list
  end

  def ask_question(word_pair)
    outputers.each { |outputer| outputer.output_question(question: word_pair.from) }
  end

  def check_answer(word_pair)
    given_answer = gets.chomp
    if given_answer == ADD_TO_IGNORE_LIST_SHORTCUT
      add_to_ignore_list(word_pair.from)
    else
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
end
