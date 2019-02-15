# frozen_string_literal: true

class WordPair
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def self.load(input)
    (from, to) = input.split /\s*-\s*/
    new(from: from, to: to)
  end

  def correct_answer?(given_answer)
    possible_answers.any? { |answer| simplify(answer) == simplify(given_answer) }
  end

  def possible_answers
    to.split("/")
  end

  def simplify(word)
    word
      .strip
      .downcase
      .gsub(/\(.*\)/, '')
      .gsub(/^the/, '')
      .gsub(/^a/, '')
      .gsub(/^to/, '')
      .gsub(/s$/, '')
      .gsub(/\W/, '')
      .strip
  end
end
