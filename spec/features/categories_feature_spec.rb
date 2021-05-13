require 'rails_helper'

RSpec.feature "CategoriesFeatures", type: :feature do
  let!(:taxonomy) { create(:taxonomy, name: "Category") }
  let!(:taxon) { create(:taxon, parent: taxonomy.root) }
  let!(:bag) { create(:taxon, name: "bag", taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: taxon) }
  let!(:product) do
    create(:product, name: "Ruby on Rails T-Shirt", price: "23.45", taxons: [shirts])
  end

  scenario "View category link" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link product.name, href: potepan_product_path(product.id)
  end

  scenario "View category page" do
    visit potepan_category_path(taxonomy.root.id)
    expect(current_path).to eq potepan_category_path(taxonomy.root.id)
  end

  scenario "View category page title" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_title "#{taxonomy.root.name} - BIGBAG Store"
  end

  scenario "View category page sidebar-title" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".page-title h2", text: "Category"
  end

  scenario "View category page breadcrumb" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".col-xs-6 .breadcrumb", text: "Home Shop Category"
  end

  scenario "View category page bag-name" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".panel-body", text: bag.name
  end

  scenario "View category page shirts-name" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".panel-body", text: shirts.name
  end

  scenario "View category page product-name" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".productCaption h5", text: product.name
  end

  scenario "View category page product-price" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_selector ".productCaption h3", text: product.display_price
  end

  scenario "View category page Home link path" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link "Home", href: potepan_path
  end

  scenario "Bag page display" do
    visit potepan_category_path(bag.id)
    expect(current_path).to eq potepan_category_path(bag.id)
  end

  scenario "Bag page title display" do
    visit potepan_category_path(bag.id)
    expect(page).to have_title "#{bag.name} - BIGBAG Store"
  end

  scenario "Bag page category text display" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".page-title h2", text: "clothing"
  end

  scenario "Bag page bag text display" do
    visit potepan_category_path(bag.id)
    expect(page).to have_selector ".page-title h2", text: "bag"
  end

  scenario "Bag page product name display" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".productCaption h5", text: product.name
  end

  scenario "Bag page product price display" do
    visit potepan_category_path(bag.id)
    expect(page).not_to have_selector ".productCaption h3", text: product.display_price
  end

  scenario "View bag page link" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link bag.name, href: potepan_category_path(bag.id)
  end

  scenario "View shirts page link" do
    visit potepan_category_path(taxonomy.root.id)
    expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
  end
end
