class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.integer :user_id,         null: false, default: 0

      t.string :ip_address,       null: false, default: ""
      t.string :community,        null: false, default: ""
      t.integer :max_cpu_core,    null: false, default: 0
      t.integer :assign_cpu_core, null: false, default: 0
      t.integer :cpu_tdp,         null: false, default: 0

      t.timestamps
    end
  end
end
