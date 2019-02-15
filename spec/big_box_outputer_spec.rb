# frozen_string_literal: true

require_relative '../lib/big_box_outputer'

RSpec.describe BigBoxOutputer do
  let(:output_stream) { double(IO, puts: nil) }
  let(:from_language) { "German" }
  let(:to_language) { "English" }

  subject do
    described_class.new(from_language: from_language,
                        to_language: to_language,
                        output_stream: output_stream)
  end

  describe 'outputs questions' do
    let(:question) { "Hallo" }
    before { subject.output_question(question: question) }

    it 'surrounds the question with a big box' do
      yellow_hallo = 'Hallo'.colorize(:yellow)
      expect(output_stream).to have_received(:puts).with(<<~OUTPUT
        ----------------------------------------
        | What is the English for #{yellow_hallo}?
        ----------------------------------------
      OUTPUT
                                                        )
    end
  end

  describe 'outputs correct text for a correct answer' do
    let(:score) { 1 }
    let(:total) { 3 }
    before { subject.output_correct(score: score, total: total) }

    it 'gives the score' do
      expect(output_stream).to have_received(:puts).with(<<~OUTPUT
        Correct! (1/3)
      OUTPUT
        .colorize(:green))
    end
  end

  describe 'outputs correct text for a correct answer' do
    let(:score) { 1 }
    let(:total) { 3 }
    let(:correct_answer) { "hello" }
    before { subject.output_incorrect(correct_answer: correct_answer, score: score, total: total) }

    it 'gives the corrrect answer' do
      expect(output_stream).to have_received(:puts).with(<<~OUTPUT
        \n\e[0;31;49mWRONG! (1/3)\nThe correct answer is \e[0m\e[0;35;49mhello\e[0m
      OUTPUT
                                                        )
    end
  end
end
