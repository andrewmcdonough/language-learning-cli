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

    it { expect(subject.pairs[0].from).to eql "bonjour" }
    it { expect(subject.pairs[0].to).to eql "hello" }
    it { expect(subject.pairs[1].from).to eql "oui" }
    it { expect(subject.pairs[1].to).to eql "yes" }
  end

  context 'with a comment' do
    let(:text) { "# Nouns\noui-yes" }

    it { expect(subject.pairs.first.from).to eql "oui" }
    it { expect(subject.pairs.first.to).to eql "yes" }
  end

  context 'with a blank line' do
    let(:text) { "bonjour-hello\n\n\n\noui-yes" }

    it { expect(subject.pairs[0].from).to eql "bonjour" }
    it { expect(subject.pairs[0].to).to eql "hello" }
    it { expect(subject.pairs[1].from).to eql "oui" }
    it { expect(subject.pairs[1].to).to eql "yes" }
  end

  context 'with a comment' do
    let(:text) { "bonjour-hello\noui-yes" }
  end
end
