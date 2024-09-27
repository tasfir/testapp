class CreateGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
      
      t.string :status, null: false, default: 'published' # Use a string for the default value
    end
  end
end
