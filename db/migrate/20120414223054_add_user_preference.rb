class AddUserPreference < ActiveRecord::Migration
  def up
    add_column :users, :nsfw, :boolean, :default => false

    change_column :reports, :reason, :text
  end

  def down
    remove_column :users, :nsfw, :boolean, :default => false

    change_column :reports, :reason, :string
  end
end
