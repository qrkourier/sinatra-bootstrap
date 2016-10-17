class AddDatetime < ActiveRecord::Migration
  def up
    add_column :domains, :created_on, :datetime
  end
  def down
    remove_column :domains, :created_on
  end
end

