require_relative '../lib/word_list'

RSpec.describe WordList do
  subject { WordList.new(text: text) }

  context 'with a single word pair' do
    let(:text) { "bonjour-hello" }

    it { expect(subject.pairs.first.from).to eql "bonjour" }
    it { expect(subject.pairs.first.to).to eql "hello" }
  end

  context 'with two word pairs' do
    let(:text) { "bonjour-hello\noui-yes" }

    it { expect(subject.pairs.first.from).to eql "bonjour" }
    it { expect(subject.pairs.first.to).to eql "hello" }
    it { expect(subject.pairs.last.from).to eql "oui" }
    it { expect(subject.pairs.last.to).to eql "yes" }
  end

  context 'with a comment' do
    let(:text) { "bonjour-hello\noui-yes" }
  end
end
