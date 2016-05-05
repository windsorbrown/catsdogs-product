class ChangePhotoTypeFromUser < ActiveRecord::Migration
  def change
   add_column :photos, :animal_type, :string
  end
end
