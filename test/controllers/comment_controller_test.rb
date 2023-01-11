require "test_helper"

class CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get body:text" do
    get comment_body:text_url
    assert_response :success
  end

  test "should get article_id:references" do
    get comment_article_id:references_url
    assert_response :success
  end

  test "should get user_id:references" do
    get comment_user_id:references_url
    assert_response :success
  end
end
