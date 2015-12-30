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
end
