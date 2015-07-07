class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :string
    add_column :users, :oauth_token, :string
    add_column :users, :name, :string
    add_column :users, :oauth_expires_at, :string
    add_column :users, :image_url, :string
  end
end
