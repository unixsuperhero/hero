class Tag < ActiveRecord::Base
  has_many :hashtags
  has_many :taggables, through: :hashtags
  has_many :notes, through: :hashtags, source: :taggable, source_type: 'Note'
  #has_many :taggables, class_name: 'Note', through: :hashtags
  #has_many :notes, through: :taggables, source: :taggables
end
