class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :postable_id, null: false
      t.string :postable_type, null: false
      t.timestamps null: false
    end
    add_in
  end
end
