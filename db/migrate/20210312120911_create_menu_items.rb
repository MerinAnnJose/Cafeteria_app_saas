class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.bigint :menu_category_id
      t.string :name
      t.string :desc
      t.float :price

      t.timestamps
    end
  end
end
