require "test_helper"

class HeresiasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heresia = heresias(:one)
  end

  test "should get index" do
    get heresias_url
    assert_response :success
  end

  test "should get new" do
    get new_heresia_url
    assert_response :success
  end

  test "should create heresia" do
    assert_difference("Heresia.count") do
      post heresias_url, params: { heresia: { descricao: @heresia.descricao, nome: @heresia.nome } }
    end

    assert_redirected_to heresia_url(Heresia.last)
  end

  test "should show heresia" do
    get heresia_url(@heresia)
    assert_response :success
  end

  test "should get edit" do
    get edit_heresia_url(@heresia)
    assert_response :success
  end

  test "should update heresia" do
    patch heresia_url(@heresia), params: { heresia: { descricao: @heresia.descricao, nome: @heresia.nome } }
    assert_redirected_to heresia_url(@heresia)
  end

  test "should destroy heresia" do
    assert_difference("Heresia.count", -1) do
      delete heresia_url(@heresia)
    end

    assert_redirected_to heresias_url
  end
end
