require "application_system_test_case"

class HeresiasTest < ApplicationSystemTestCase
  setup do
    @heresia = heresias(:one)
  end

  test "visiting the index" do
    visit heresias_url
    assert_selector "h1", text: "Heresias"
  end

  test "should create heresia" do
    visit heresias_url
    click_on "New heresia"

    fill_in "Descricao", with: @heresia.descricao
    fill_in "Nome", with: @heresia.nome
    click_on "Create Heresia"

    assert_text "Heresia was successfully created"
    click_on "Back"
  end

  test "should update Heresia" do
    visit heresia_url(@heresia)
    click_on "Edit this heresia", match: :first

    fill_in "Descricao", with: @heresia.descricao
    fill_in "Nome", with: @heresia.nome
    click_on "Update Heresia"

    assert_text "Heresia was successfully updated"
    click_on "Back"
  end

  test "should destroy Heresia" do
    visit heresia_url(@heresia)
    click_on "Destroy this heresia", match: :first

    assert_text "Heresia was successfully destroyed"
  end
end
