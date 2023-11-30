class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :slug, null: false
      t.string :url, null: false
      t.string :name, null: true
      t.string :type, null: false
      t.string :password, null: true
      t.date :expiration_data, null: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end