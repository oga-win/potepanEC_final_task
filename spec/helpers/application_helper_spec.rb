require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#full_title' do
    subject { full_title(str) }

    context "When string is given" do
      let(:str) { 'test' }

      it { is_expected.to eq 'test - BIGBAG Store' }
    end

    context "When empty string is given" do
      let(:str) { '' }

      it { is_expected.to eq 'BIGBAG Store' }
    end

    context "When nil string is given" do
      let(:str) { nil }

      it { is_expected.to eq 'BIGBAG Store' }
    end
  end
end
