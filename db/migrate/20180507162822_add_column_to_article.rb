class AddColumnToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :city_id, :integer

  end
end
