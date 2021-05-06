require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET #show" do
    let(:product) { create(:product, taxons: [taxon]) }
    let(:taxon) { create(:taxon) }

    before do
      get potepan_product_path(product.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'product name can be displayed' do
      expect(response.body).to include(product.name)
    end
    it 'product price can be displayed' do
      expect(response.body).to include(product.display_price.to_s)
    end
    it 'product description can be displayed' do
      expect(response.body).to include(product.description)
    end
  end
end
