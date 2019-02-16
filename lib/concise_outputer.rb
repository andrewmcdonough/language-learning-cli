# frozen_string_literal: true

require 'colorize'

class ConciseOutputer
  attr_reader :from_language, :to_language, :output_stream
  private :from_language, :to_language, :output_stream

  TICK = "✅"
  CROSS = "❌"
  BR = "\n"

  def initialize(from_language:, to_language:, output_stream:)
    @from_language = from_language
    @to_language = to_language
    @output_stream = output_stream
  end

  def output_question(question:)
    output(question.colorize(:yellow) + " ")
  end

  def output_correct(score:, total:)
    output "#{TICK} (#{score}/#{total})".colorize(:green) + BR
  end

  def output_incorrect(correct_answer:, score:, total:)
    output(
      "#{CROSS} (#{score}/#{total})".colorize(:red) + " " +
      correct_answer.colorize(:magenta) + BR
    )
  end

  private

  def output(text)
    output_stream.print(text)
  end
end
