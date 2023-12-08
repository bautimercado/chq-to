class CreateAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :accesses do |t|
      t.string :ip_address, null: false
      t.belongs_to :link, index: true

      t.timestamps
    end
  end
end
