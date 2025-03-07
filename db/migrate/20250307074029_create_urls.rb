class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.text :original_url
      t.string :short_url
      t.datetime :expires_at
      t.integer :access_count

      t.timestamps
    end
    add_index :urls, :short_url, unique: true
  end
end
