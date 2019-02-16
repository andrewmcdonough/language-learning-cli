# frozen_string_literal: true

require "word_pair"

RSpec.describe WordPair do
  subject { described_class.load(pair_text) }

  describe "loading a new pair" do
    context "with a normal pair" do
      let(:pair_text) { "was - what" }

      it "splits the input by a delimiter" do
        expect(subject.from).to eql "was"
        expect(subject.to).to eql "what"
      end
    end

    context "with a pair with no padding" do
      let(:pair_text) { "was-what" }

      it "splits the input by a delimiter" do
        expect(subject.from).to eql "was"
        expect(subject.to).to eql "what"
      end
    end
  end

  describe "checking correctness" do
    context "for a normal pair 'was - what'" do
      let(:pair_text) { "was - what" }

      it { is_expected.to be_correct_answer("what") }
      it { is_expected.to_not be_correct_answer("hello") }
    end

    context "where the answer has an optional article 'der Stuhl - the chair" do
      let(:pair_text) { "der Stuhl - the chair" }

      it { is_expected.to be_correct_answer("the chair") }
      it { is_expected.to be_correct_answer("chair") }
    end

    context "where there is more than one answer 'schwer - difficult/hard" do
      let(:pair_text) { "schwer - difficult/hard" }

      it { is_expected.to be_correct_answer("difficult") }
      it { is_expected.to be_correct_answer("hard") }
    end

    context "where there are brackets" do
      let(:pair_text) { "wie gehts dir - how are you? (informal)" }

      it { is_expected.to be_correct_answer("how are you") }
      it { is_expected.to be_correct_answer("how are you?") }
    end

    context "where the pair has capitals" do
      let(:pair_text) { "das Werkzeug - the Tool" }

      it { is_expected.to be_correct_answer("the tool") }
      it { is_expected.to be_correct_answer("the Tool") }
      it { is_expected.to be_correct_answer("tool") }
      it { is_expected.to be_correct_answer("Tool") }
    end
  end
end
