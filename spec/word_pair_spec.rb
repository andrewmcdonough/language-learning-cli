require 'word_pair'

RSpec.describe WordPair do
  describe 'loading a new pair' do
    subject { described_class.load(pair_text) }

    context 'with a normal pair' do
      let(:pair_text) { "was - what" }

      it 'splits the input by a delimiter' do
        expect(subject.from).to eql "was"
        expect(subject.to).to eql "what"
      end
    end

    context 'with a pair with no padding' do
      let(:pair_text) { "was-what" }

      it 'splits the input by a delimiter' do
        expect(subject.from).to eql "was"
        expect(subject.to).to eql "what"
      end
    end
  end
end
