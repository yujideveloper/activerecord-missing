# frozen_string_literal: true

ActiveRecord::Base.configurations = {
  "test" => { "adapter" => "sqlite3", "database" => ":memory:" }
}
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration::Current
  def self.up
    create_table(:authors) do |t|
      t.string :name
    end
    create_table(:posts) do |t|
      t.belongs_to :author
      t.string :title
      t.string :body
    end
    create_table(:comments) do |t|
      t.belongs_to :author
      t.belongs_to :post
      t.string :body
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up

class ApplicationRecord < ActiveRecord::Base
end
class Author < ApplicationRecord
  has_many :posts
  has_many :comments
end
class Post < ApplicationRecord
  belongs_to :author, optional: true
  has_many :comments
end
class Comment < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :post
end

RSpec.describe ActiveRecord::Missing do
  it "has a version number" do
    expect(ActiveRecord::Missing::VERSION).not_to be nil
  end

  describe "#missing" do
    before(:all) do
      a = Author.create!(name: "Author1")
      p1 = a.posts.create!(title: "post-title1", body: "post-body1")
      p2 = Post.create!(author: nil, title: "post-title2", body: "post-body2")
      Post.create!(author: nil, title: "post-title3", body: "post-body3")
      p1.comments.create!(body: "comment-body1")
      p2.comments.create!(author: a, body: "comment-body2")
    end

    context "when specified single association" do
      it "should return posts that are missing a related author" do
        expect(Post.where.missing(:author)).to be_exists
        expect(Post.where.missing(:author).to_a).to match [
          have_attributes(title: "post-title2"),
          have_attributes(title: "post-title3")
        ]
      end
    end

    context "when specified multiple associations" do
      it "should return posts that are missing both an author and any comments" do
        expect(Post.where.missing(:author, :comments)).to be_exists
        expect(Post.where.missing(:author, :comments).to_a).to match [
          have_attributes(title: "post-title3")
        ]
      end
    end
  end
end
