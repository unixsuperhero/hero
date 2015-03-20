class Note < ActiveRecord::Base
  has_many :metadatas

  has_many :hashtags, as: :taggable
  has_many :tags, through: :hashtags
end
