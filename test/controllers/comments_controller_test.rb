require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  def sign_in
    request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.
      encode_credentials('dhh', 'secret')
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, article_id: @comment.article.id, comment: { body: 'Great article' }
    end

    assert_redirected_to article_path(@comment.article)
  end

  test "should not destroy comment if not signed in" do
    assert_no_difference('Comment.count', -1) do
      delete :destroy, article_id: @comment.article.id, id: @comment
    end

    assert_response :unauthorized
  end

  test "should destroy comment if signed in" do
    sign_in

    assert_difference('Comment.count', -1) do
      delete :destroy, article_id: @comment.article.id, id: @comment
    end

    assert_redirected_to article_path(@comment.article)
  end

end
