class AppleSayOutputer
  VOICES = {
    English: "Daniel",
    German: "Anna"
  }
  # Find more voices by running `say -v ?` in the terminal

  attr_reader :from_language, :to_language
  private :from_language, :to_language

  def initialize(from_language:, to_language:)
    @from_language = from_language
    @to_language = to_language
  end

  def output_question(question:)
    say(question, language: from_language)
  end

  def output_correct(score:, total:)
    say("Correct!", language: to_language)
  end

  def output_incorrect(correct_answer:, score:, total:)
    say("Incorrect!", language: to_language)
  end

  private

  def say(something, language:)
    voice = VOICES[language.to_sym]
    say_cmd = "echo \"#{something}\" | say -v #{voice}"
    `#{say_cmd}`
  end
end
