class AddIsImportedToCharacters < ActiveRecord::Migration[7.2]
  def change
    add_column :characters, :is_imported, :boolean, default: false
  end
end
