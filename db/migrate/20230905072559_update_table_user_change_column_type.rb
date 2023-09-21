class UpdateTableUserChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :type, 'User'
  end
end
