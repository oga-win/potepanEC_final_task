require 'rails_helper'

RSpec.feature "CategoriesFeatures", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, parent: taxonomy.root) }
  let!(:bag) { create(:taxon, name: "bag", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: taxon) }
  let!(:product) do
    create(:product, name: "Ruby on Rails T-Shirt", price: "23.45", taxons: [shirts])
  end

  describe "About taxonomy" do
    before { visit potepan_category_path(taxonomy.root.id) }

    scenario "View category page" do
      expect(current_path).to eq potepan_category_path(taxonomy.root.id)
    end

    scenario "Show page-title on the category page" do
      expect(page).to have_title "#{taxonomy.root.name} - BIGBAG Store"
    end

    scenario "Show sidebar-title on the category page" do
      expect(page).to have_selector ".page-title h2", text: "Category"
    end

    scenario "Show breadcrumbs on the category page" do
      expect(page).to have_selector ".col-xs-6 .breadcrumb", text: "Home Shop Category"
    end

    scenario "List products that belong to the same taxon" do
      expect(page).to have_selector ".panel-body", text: bag.name
      expect(page).to have_selector ".panel-body", text: shirts.name
    end

    scenario "Show product-name on the category page" do
      expect(page).to have_selector ".productCaption h5", text: product.name
    end

    scenario "Show product-price on the category page" do
      expect(page).to have_selector ".productCaption h3", text: product.display_price
    end

    scenario "The link to the top page is correct" do
      expect(page).to have_link "Home", href: potepan_path
    end

    scenario "The link to list products that belong to the same taxon is correct" do
      expect(page).to have_link bag.name, href: potepan_category_path(bag.id)
      expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
    end

    scenario "The link to the product page is correct" do
      expect(page).to have_link product.name, href: potepan_product_path(product.id)
    end
  end

  describe "About bag" do
    before { visit potepan_category_path(bag.id) }

    scenario "Bag page display" do
      expect(current_path).to eq potepan_category_path(bag.id)
    end

    scenario "Show page-title on the bag page" do
      expect(page).to have_title "#{bag.name} - BIGBAG Store"
    end

    scenario "Show right section text on the bag page" do
      expect(page).not_to have_selector ".page-title h2", text: "clothing"
      expect(page).to have_selector ".page-title h2", text: "bag"
    end

    scenario "Show production caption on the bag page" do
      expect(page).not_to have_selector ".productCaption h5", text: product.name
      expect(page).not_to have_selector ".productCaption h3", text: product.display_price
    end
  end
end
