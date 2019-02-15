require_relative '../lib/big_box_outputer'

RSpec.describe BigBoxOutputer do
  let(:output_stream) { double(IO, puts: nil) }
  let(:from_language) { "German" }
  let(:to_language) { "English" }
  subject { described_class.new(from_language: from_language,
                                to_language: to_language,
                                output_stream: output_stream) }


  describe 'outputing questions' do
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
end
