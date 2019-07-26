# frozen_string_literal: true

class CreateAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :alerts do |t|
      t.belongs_to :user, foreign_key: false

      t.integer :temperature
      t.text :message

      t.timestamps
    end

    add_foreign_key :alerts, :users, on_delete: :cascade
  end
end
