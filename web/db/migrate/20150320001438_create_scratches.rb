class CreateScratches < ActiveRecord::Migration
  def change
    create_table :scratches do |t|
      t.text :data

      t.timestamps
    end
  end
end
