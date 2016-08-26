class CreateRecommends < ActiveRecord::Migration
  def change
    create_table :recommends do |t|
      t.integer :post_id
      t.string :email
      t.timestamps null: false
    end
  end
end
