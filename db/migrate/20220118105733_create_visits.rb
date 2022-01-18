class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.datetime :visit_at
      t.string :action
      t.string :country

      t.timestamps
    end
  end
end
