class CreateDivisions < ActiveRecord::Migration[7.2]
  def change
    create_table :divisions do |t|
      t.string :code, null: false
      t.float :lat
      t.float :long

      t.timestamps
      t.string :status, null: false, default: 'published'  # Use a string for the default value
    end

    add_index :divisions, :code, unique: true

    # Create translations for divisions
    reversible do |dir|
      dir.up do
        # Initial divisions data with English and Bengali names
        divisions = [
          { code: 'BRS', name: 'Barishal', bn_name: 'বরিশাল', lat: 22.701002, long: 90.353451 },
          { code: 'CTG', name: 'Chattogram', bn_name: 'চট্টগ্রাম', lat: 22.356851, long: 91.783182 },
          { code: 'DKA', name: 'Dhaka', bn_name: 'ঢাকা', lat: 23.810332, long: 90.412518 },
          { code: 'KHL', name: 'Khulna', bn_name: 'খুলনা', lat: 22.845641, long: 89.540328 },
          { code: 'RJS', name: 'Rajshahi', bn_name: 'রাজশাহী', lat: 24.363589, long: 88.624135 },
          { code: 'RGP', name: 'Rangpur', bn_name: 'রংপুর', lat: 25.743892, long: 89.275227 },
          { code: 'SYL', name: 'Sylhet', bn_name: 'সিলেট', lat: 24.894929, long: 91.868706 },
          { code: 'MYS', name: 'Mymensingh', bn_name: 'ময়মনসিংহ', lat: 24.747149, long: 90.420273 }
        ]

        divisions.each do |division|
          div = Division.find_or_create_by!(code: division[:code]) do |d|
            d.lat = division[:lat]
            d.long = division[:long]
          end

          # Create or update translations
          Translation.find_or_create_by!(translatable: div, locale: 'en', key: 'name') do |t|
            t.value = division[:name]
          end
          Translation.find_or_create_by!(translatable: div, locale: 'bn', key: 'name') do |t|
            t.value = division[:bn_name]
          end
        end
      end
    end
  end
end
