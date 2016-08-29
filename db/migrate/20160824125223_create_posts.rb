class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.string :title
      t.text :content
      t.integer :user_id
      t.references :user, index: true, foreign_key: true
      t.string :link_select
      t.string :video_url
      t.string :ytb_key
      t.string :sc_link
      t.string :singer
      t.string :song
      t.integer :hit, default: 0       # 조회수
      t.integer :reconum, default: 0   # 추천수
    

      t.timestamps null: false
    end
  end
end
