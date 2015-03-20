class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.references :tag, index: true
      t.references :taggable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
