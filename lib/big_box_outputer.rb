class BigBoxOutputer
  attr_reader :from_language, :to_language
  private :from_language, :to_language

  def initialize(from_language:, to_language:)
    @from_language = from_language
    @to_language = to_language
  end

  def output_question(question:)
    puts "-" * 40
    puts "| What is the #{to_language} for " + question.colorize(:yellow) + "?"
    puts "-" * 40
    puts "\n"
  end

  def output_correct(score:, total:)
    puts "Correct! (#{score}/#{total})".colorize(:green)
  end

  def output_incorrect(correct_answer:, score:, total:)
    puts  "WRONG! The correct answer is ".colorize(:red) + correct_answer.colorize(:magenta)
  end
end