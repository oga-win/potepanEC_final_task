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

    scenario "It is possible to page transition when clicked product detail page" do
      click_on 'sample-image'
      expect(current_path).to eq potepan_product_path(product.id)
    end

    scenario "Click the Bag name of the category to display the Bag name" do
      within("#category") do
        click_on bag.name
        expect(page).to have_content "#{bag.name}(#{bag.products.count})"
      end
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
