class AddDatetimesToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_at
    add_column :articles, :updated_at
  end
  
end
