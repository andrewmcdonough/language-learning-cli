class AppleSayOutputer
  def output_question(question:, from_language:, to_language:)
    say_cmd = "echo \"#{question}\" | say -v Anna"
    `#{say_cmd}`
  end

  def output_correct(score:, total:)
    # Don't say anything for now
  end

  def output_incorrect(correct_answer:, score:, total:)
    # Don't say anything for now
  end
end
