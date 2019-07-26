# frozen_string_literal: true

class AddZipAndPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :zip_code, :string
    add_column :users, :phone_number, :string
  end
end
