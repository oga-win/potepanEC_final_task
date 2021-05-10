require 'rails_helper'

RSpec.feature "ProductsFeatures", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) do
    create(:taxon, name: "Taxon", taxonomy: taxonomy, parent: taxonomy.root)
  end

  let!(:product) { create(:product, taxons: [taxon]) }

  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_current_path potepan_product_path(product.id)
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_title "#{product.name} - BIGBAG Store"
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".page-title h2", text: product.name
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".col-xs-6 h2", text: product.name
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".col-xs-6 h2", text: product.name
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".media-body h2", text: product.name
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".media-body h3", text: product.display_price
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_selector ".media-body p", text: product.description
  end
  scenario "View show page" do
    visit potepan_product_path(product.id)
    expect(page).to have_link '一覧ページへ戻る', href: potepan_category_path(product.taxons.first.id)
  end
end
