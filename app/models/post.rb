class Post < ApplicationRecord
  belongs_to :account
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :dislikes

  has_paper_trail

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
