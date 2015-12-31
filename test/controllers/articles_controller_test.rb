require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:one)
  end

  class SignedOutArticlesControllerTest < ArticlesControllerTest
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:articles)
    end

    test "should get new" do
      get :new
      assert_response :unauthorized
    end

    test "should not create article" do
      assert_no_difference('Article.count') do
        post :create, article: { title: 'Some title' }
      end

      assert_response :unauthorized
    end

    test "should show article" do
      get :show, id: @article
      assert_response :success
    end

    test "should not get edit" do
      get :edit, id: @article
      assert_response :unauthorized
    end

    test "should not update article" do
      patch :update, id: @article, article: { title: 'New Title' }
      assert_response :unauthorized
    end

    test "should destroy article" do
      assert_no_difference('Article.count') do
        delete :destroy, id: @article
      end

      assert_response :unauthorized
    end
  end

  class SignedInArticlesControllerTest < ArticlesControllerTest
    setup do
      request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.
        encode_credentials('dhh', 'secret')
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create article" do
      assert_difference('Article.count') do
        post :create, article: { title: 'Some title' }
      end

      assert_redirected_to article_path(assigns(:article))
    end

    test "should show article" do
      get :show, id: @article
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @article
      assert_response :success
    end

    test "should update article" do
      patch :update, id: @article, article: { title: 'New Title' }
      assert_redirected_to article_path(assigns(:article))
    end

    test "should destroy article" do
      assert_difference('Article.count', -1) do
        delete :destroy, id: @article
      end

      assert_redirected_to articles_path
    end
  end
end
