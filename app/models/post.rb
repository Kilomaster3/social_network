# frozen_string_literal: true

require 'elasticsearch/model'

class Post < ApplicationRecord
  belongs_to :account
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  mount_uploader :image, ImageUploader

  scope :search_last_post, -> { where('created_at > ?', 24.hours.ago).order(id: :asc) }
  scope :most_comments, -> { joins(:comments).group('posts.id').having('count(comments.id) > ?', 1) }
  scope :most_likes, -> { joins(:likes).group('posts.id').having('count(likes.id) > ?', 1) }

  scope :published, -> { where.not(published_at: nil).where('published_at <= ?', Time.zone.now) }
  scope :scheduled, -> { where.not(published_at: nil).where('published_at > ?', Time.zone.now) }

  attr_accessor :status

  include PublicActivity::Model
  tracked owner: ->(controller, _model) { controller&.current_account }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  searchkick

  mappings dynamic: false do
    indexes :title, type: :text, analyzer: 'english'
    indexes :content, type: :text, analyzer: 'english'
  end

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

  def self.search_post(query)
    __elasticsearch__.search({
                               query: {
                                 multi_match: {
                                   query: query,
                                   fields: %w[title content]
                                 }
                               },
                               highlight: {
                                 pre_tags: ['<em>'],
                                 post_tags: ['</em>'],
                                 fields: {
                                   title: {},
                                   text: {}
                                 }
                               }
                             })
  end
end
