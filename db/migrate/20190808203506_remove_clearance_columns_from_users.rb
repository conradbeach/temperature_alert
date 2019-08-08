# frozen_string_literal: true

class RemoveClearanceColumnsFromUsers < ActiveRecord::Migration[6.0]
  def up
    change_table :users do
      remove_column :users, :encrypted_password, :string, limit: 128, null: false
      remove_column :users, :confirmation_token, :string, limit: 128
      remove_column :users, :remember_token, :string, limit: 128, null: false
    end
  end
end
