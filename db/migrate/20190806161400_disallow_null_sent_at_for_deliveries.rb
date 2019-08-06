# frozen_string_literal: true

class DisallowNullSentAtForDeliveries < ActiveRecord::Migration[6.0]
  def change
    change_column_null :deliveries, :sent_at, false
  end
end
