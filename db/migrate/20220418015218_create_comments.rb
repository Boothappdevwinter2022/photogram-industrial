class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :photo, null: false, foreign_key: true, index: true #index by photo_id here bc every time we go to the photo details page, we'll need to use this to pull the right comments
      t.text :body

      t.timestamps
    end
  end
end
