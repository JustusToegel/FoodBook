require "test_helper"

class MealIngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get meal_ingredients_index_url
    assert_response :success
  end

  test "should get new" do
    get meal_ingredients_new_url
    assert_response :success
  end

  test "should get create" do
    get meal_ingredients_create_url
    assert_response :success
  end
end
