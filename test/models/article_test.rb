require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "doesn't allow title of less than 5 character" do
    article = Article.new(title: "abcd")
    assert !article.valid?
  end

  test "allow title of 5 characters" do
    article = Article.new(title: "abcde")
    assert article.valid?
  end

  test "destroys dependent comments" do
    article = Article.create(title: 'title')
    2.times { article.comments.create }

    assert_difference('Comment.count', -2) do
      article.destroy
    end
  end
end
