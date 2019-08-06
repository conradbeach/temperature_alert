# frozen_string_literal: true

class RenameAlertsTemperatureToTemperatureThreshhold < ActiveRecord::Migration[6.0]
  def change
    rename_column :alerts, :temperature, :temperature_threshold
  end
end
