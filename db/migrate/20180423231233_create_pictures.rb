class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :picture
      t.integer :article_id
      t.timestamps
    end
  end
end
