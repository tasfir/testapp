class CreateThanas < ActiveRecord::Migration[7.0]
  def change
    create_table :thanas do |t|
      t.integer :district_id, null: false
      t.float :lat
      t.float :long

      t.timestamps
      t.string :status, null: false, default: 'published' # Use a string for the default value
    end

    # You may want to add an index for faster lookup
    add_index :thanas, :district_id

    require 'json'

    file = File.read(Rails.root.join('db', 'seeds', 'json_files', 'thanas.json'))
    thanas = JSON.parse(file)

    thanas.each do |thana_data|
      thana = Thana.create(district_id: thana_data['district_id'], lat: thana_data['lat'], long: thana_data['long'])

      Translation.create(
        translatable: thana,
        locale: 'en',
        key: 'name',
        value: thana_data['name']
      )

      Translation.create(
        translatable: thana,
        locale: 'bn',
        key: 'name',
        value: thana_data['bn_name']
      )
    end
  end
end
