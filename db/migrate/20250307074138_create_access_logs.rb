class CreateAccessLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :access_logs do |t|
      t.references :url, null: false, foreign_key: true
      t.datetime :accessed_at

      t.timestamps
    end
  end
end
