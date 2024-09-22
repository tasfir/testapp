class CreateThanas < ActiveRecord::Migration[7.0]
  def change
    create_table :thanas do |t|
      t.integer :district_id, null: false
      t.float :lat
      t.float :long

      t.timestamps
      t.string :status, null: false, default: 'published' # Use a string for the default value

      t.index :district_id
    end
    reversible do |dir|
      dir.up do
        require 'json'

        file = File.read(Rails.root.join('db', 'seeds', 'json_files', 'thanas.json'))
        thanas = JSON.parse(file)

        # thanas.each do |thana|
        #   div = Thana.find_or_create_by!(id: thana[:id]) do |d|
        #     d.district_id = thana[:district_id]
        #     d.lat = thana[:lat]
        #     d.long = thana[:long]
        #   end
        #
        #   # Create or update translations
        #   Translation.find_or_create_by!(translatable: div, locale: 'en', key: 'name') do |t|
        #     t.value = thana[:name]
        #   end
        #   Translation.find_or_create_by!(translatable: div, locale: 'bn', key: 'name') do |t|
        #     t.value = thana[:bn_name]
        #   end
        # end

        thanas.each do |thana|
          thana = Thana.create(district_id: thana['district_id'], lat: thana['lat'], long: thana['long'])
          thana.debugger

          Translation.create(
            translatable: thana,
            locale: 'en',
            key: 'name',
            value: thana['name']
          )

          Translation.create(
            translatable: thana,
            locale: 'bn',
            key: 'name',
            value: thana['bn_name']
          )
        end
      end
    end
  end
end
