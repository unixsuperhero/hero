class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.references :note
      t.string :name
      t.string :data

      t.timestamps
    end
  end
end
