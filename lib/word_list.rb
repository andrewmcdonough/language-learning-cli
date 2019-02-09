require_relative './word_pair'

class WordList
  attr_reader :text

  def initialize(text:)
    @text = text
  end

  def pairs
    text.split("\n").map { |line|
      WordPair.load(line)
    }
  end

  def random_pair
    pairs.shuffle.pop
  end
end
