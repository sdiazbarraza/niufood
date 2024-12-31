class CreateRegisters < ActiveRecord::Migration[7.0]
  def change
    create_table :registers do |t|
      t.string :status, null: false
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
