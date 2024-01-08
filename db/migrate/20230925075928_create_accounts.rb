class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :cc
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
