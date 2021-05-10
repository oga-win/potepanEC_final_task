require 'rails_helper'

RSpec.feature "CategoriesFeatures", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, parent: taxonomy.root) }
  let!(:bag) { create(:taxon, name: "bag", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: taxon) }
  let!(:product) do
    create(:product, name: "Ruby on Rails T-Shirt", price: "23.45", taxons: [shirts])
  end

  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(current_path).to eq potepan_category_path(taxonomy.root.id)
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_title "#{taxonomy.root.name} - BIGBAG Store"
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".page-title h2", text: "Category"
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".col-xs-6 .breadcrumb", text: "Home Shop Category"
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".panel-body", text: bag.name
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".panel-body", text: shirts.name
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".productCaption h5", text: product.name
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".productCaption h3", text: product.display_price
  end
  scenario "View category show page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link "Home", href: potepan_path
  end

  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(current_path).to eq potepan_category_path(bag.id)
  end
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(page).to have_title "#{bag.name} - BIGBAG Store"
  end
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".page-title h2", text: "clothing"
  end
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(page).to have_selector ".page-title h2", text: "bag"
  end
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".productCaption h5", text: product.name
  end
  scenario "Products for each category are displayed" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".productCaption h3", text: product.display_price
  end

  scenario "should be able to visit other category" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link bag.name, href: potepan_category_path(bag.id)
  end
  scenario "should be able to visit other category" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
  end

  scenario "should be able to visit products" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end
end
