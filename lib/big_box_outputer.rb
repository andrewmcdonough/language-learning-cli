require 'colorize'

class BigBoxOutputer
  attr_reader :from_language, :to_language, :output_stream
  private :from_language, :to_language, :output_stream

  HR_WIDTH = 40
  HORIZONTAL_BOX_CHAR = "-".freeze
  VERTICAL_BOX_CHAR = "|".freeze
  BR = "\n".freeze
  HR = HORIZONTAL_BOX_CHAR * HR_WIDTH.freeze

  def initialize(from_language:, to_language:, output_stream:)
    @from_language = from_language
    @to_language = to_language
    @output_stream = output_stream
  end

  def output_question(question:)
    output(
     HR + BR +
     VERTICAL_BOX_CHAR + " What is the #{to_language} for " + question.colorize(:yellow) + "?" + BR +
     HR + BR
    )
  end

  def output_correct(score:, total:)
    output "Correct! (#{score}/#{total})\n".colorize(:green)
  end

  def output_incorrect(correct_answer:, score:, total:)
    output BR + "WRONG! (#{score}/#{total})\nThe correct answer is ".colorize(:red) + correct_answer.colorize(:magenta) + BR
  end

  private

  def output(text)
    output_stream.puts(text)
  end
end
