class Stackdom < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :list
    end
  end
end
