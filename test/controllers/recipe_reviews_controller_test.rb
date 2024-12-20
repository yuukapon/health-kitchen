require "test_helper"

class RecipeReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get recipe_reviews_create_url
    assert_response :success
  end

  test "should get edit" do
    get recipe_reviews_edit_url
    assert_response :success
  end

  test "should get update" do
    get recipe_reviews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get recipe_reviews_destroy_url
    assert_response :success
  end
end
