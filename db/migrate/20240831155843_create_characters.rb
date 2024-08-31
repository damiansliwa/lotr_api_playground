class CreateCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.string :realm

      t.timestamps
    end
  end
end
