class WordPair
  attr_reader :from, :to

  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def self.load(input)
    (from, to) = input.split %r{\s*-\s*}
    new(from: from, to: to)
  end

  def correct_answer?(given_answer)
    simplify(to) == simplify(given_answer)
  end

  def simplify(word)
    word
      .strip
      .downcase
      .gsub(/^the/,'')
      .gsub(/^a/,'')
      .gsub(/^to/,'')
      .gsub(/s$/,'')
      .gsub(/\W/,'')
      .strip
  end
end