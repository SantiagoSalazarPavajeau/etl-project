class CreateRevenues < ActiveRecord::Migration[6.0]
  def change
    create_table :revenues do |t|
      t.integer :year
      t.integer :amount

      t.timestamps
    end
  end
end
