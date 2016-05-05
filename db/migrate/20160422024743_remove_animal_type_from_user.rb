class RemoveAnimalTypeFromUser < ActiveRecord::Migration
  def change
     remove_column :users, :animal_type
  end
end
