class BigBoxOutputer
  def output_question(question:, from_language:, to_language:)
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
