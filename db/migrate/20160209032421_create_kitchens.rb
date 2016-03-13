class CreateKitchens < ActiveRecord::Migration
  def change
    create_table :kitchens do |t|
      t.string :name
      t.string :link

      t.timestamps null: false
    end
  end
end
