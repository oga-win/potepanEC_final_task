require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product) }

    before do
      get potepan_product_path(product.id)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
