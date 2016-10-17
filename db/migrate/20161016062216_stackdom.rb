class Stackdom < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :list
      t.datetime :created_on
    end
  end
end
