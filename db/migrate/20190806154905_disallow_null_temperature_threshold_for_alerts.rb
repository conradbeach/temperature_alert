# frozen_string_literal: true

class DisallowNullTemperatureThresholdForAlerts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :alerts, :temperature_threshold, false
  end
end
