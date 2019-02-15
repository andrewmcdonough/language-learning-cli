require 'colorize'

class BigBoxOutputer
  attr_reader :from_language, :to_language, :output_stream
  private :from_language, :to_language, :output_stream

  def initialize(from_language:, to_language:, output_stream:)
    @from_language = from_language
    @to_language = to_language
    @output_stream = output_stream
  end

  def output_question(question:)
    output(
     "-" * 40 + "\n" +
     "| What is the #{to_language} for " + question.colorize(:yellow) + "?" + "\n" +
     "-" * 40 + "\n"
    )
  end

  def output_correct(score:, total:)
    output "Correct! (#{score}/#{total})\n".colorize(:green)
  end

  def output_incorrect(correct_answer:, score:, total:)
    output "\nWRONG! The correct answer is ".colorize(:red) + correct_answer.colorize(:magenta) + "\n"
  end

  private

  def output(text)
    output_stream.puts(text)
  end
end
