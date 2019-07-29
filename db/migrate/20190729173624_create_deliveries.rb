class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.belongs_to :alert, foreign_key: false

      t.datetime :sent_at

      t.timestamps
    end

    add_foreign_key :deliveries, :alerts, on_delete: :cascade
  end
end
