class DeleteColumnCountFromLikes < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :count, :integer
  end
end
