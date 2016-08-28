class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      #t.integer :reply_id   # 써놨지만 사용하지 않음, 기존id사용
      t.string  :email
      t.text    :content
      t.integer :post_id    # 외래키

      t.timestamps null: false
    end
  end
end
