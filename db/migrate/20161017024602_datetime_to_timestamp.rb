class DatetimeToTimestamp < ActiveRecord::Migration
  def change
    change_column(:domains, :created_on, :timestamp)
  end
end
