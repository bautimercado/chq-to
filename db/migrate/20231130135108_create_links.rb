class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :slug, null: false, default: ""
      t.string :url, null: false
      t.string :name, null: true
      t.string :type, null: false
      t.string :password, null: true
      t.datetime :expiration_date, null: true
      t.boolean :accessed, null: true, default: false
      t.belongs_to :user, index: true

      t.timestamps

      t.index :slug, unique: true
    end
  end
end
