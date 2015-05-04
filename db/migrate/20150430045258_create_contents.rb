class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.text :body
      t.string :page
      t.integer :slot

      t.timestamps null: false
    end
  end
end
