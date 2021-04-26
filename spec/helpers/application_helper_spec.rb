require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "Application Title helpers" do
    it "Title is displayed" do
      expect(full_title("test")).to eq "test - BIGBAG Store"
      expect(full_title("")).to eq "BIGBAG Store"
      expect(full_title(nil)).to eq "BIGBAG Store"
    end
  end
end
