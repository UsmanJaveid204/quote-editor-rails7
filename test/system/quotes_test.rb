require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:first) # Reference to the first fixture quote

    visit quotes_path
    assert_selector "h1", text: "Quotes"
  end

  test 'create new quote' do
    click_on "New quote"
    assert_selector "h1", text: "New quote"

    fill_in('quote[name]', with: "Capybara quote")
    click_on "Create Quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Capybara quote"
  end

  test 'Show Quote' do
    click_link @quote.name
    assert_selector "h1", text: @quote.name
  end

  test 'Update Quote' do
    click_link 'Edit', match: :first
    assert_selector "h1", text: "Edit quote"

    fill_in "quote[name]", with: "Capybara quote"
    click_on "Update Quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Capybara quote"
  end

  test "Destroying a quote" do
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
end
