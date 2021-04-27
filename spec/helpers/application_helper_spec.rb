require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'Application Title helpers' do
    it 'Title is displayed(product name: test)' do
      expect(full_title('test')).to eq 'test - BIGBAG Store'
    end
    it 'Title is displayed(product name: empty)' do
      expect(full_title('')).to eq 'BIGBAG Store'
    end
    it 'Title is displayed(product name: nil)' do
      expect(full_title(nil)).to eq 'BIGBAG Store'
    end
  end
end
