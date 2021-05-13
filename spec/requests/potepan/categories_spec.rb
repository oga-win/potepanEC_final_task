RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let!(:product) { create(:product, taxons: [taxon]) }
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon, parent_id: taxonomy.root.id, taxonomy: taxonomy) }

    before do
      get potepan_category_path(taxon.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'taxon name can be displayed' do
      expect(response.body).to include(taxon.name)
    end

    it 'taxonomy name can be displayed' do
      expect(response.body).to include(taxonomy.name)
    end

    it 'product name can be displayed' do
      expect(response.body).to include(product.name)
    end

    it 'product price can be displayed' do
      expect(response.body).to include(product.display_price.to_s)
    end
  end
end
