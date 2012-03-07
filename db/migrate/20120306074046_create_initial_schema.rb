class CreateInitialSchema < ActiveRecord::Migration
  def up

    create_table :bookmarks do |t|
      t.string  :title,                   :null => false, :limit => 64
      t.string  :description
      t.string  :link,                    :null => false
      t.integer :user_id,                 :null => false
      t.integer :category_id,             :null => false
      t.boolean :private,                 :null => false, :default => false
      t.boolean :nsfw,                    :null => false, :default => false
      t.string :disqus_uuid
      t.integer :views
      t.timestamps
    end

    create_table :users do |t|
      t.string  :email,                    :null => false, :limit => 64
      t.string  :name
      t.string  :url
      t.string  :description
      t.string :disqus_uuid
      t.timestamps
    end

    create_table :bookmarks_users do |t|
      t.integer :bookmark_id,                 :null => false
      t.integer  :user_id,                    :null => false
      t.string  :current_url,                 :null => false,
      t.boolean :finished,                    :null => false, :default => false
      t.boolean :private,                     :null => false, :default => false
      t.timestamps
    end

    create_table :categories do |t|
      t.string   :code,                    :null => false
      t.string   :name,                :null => false
    end

    create_table :ratings do |t|
      t.integer :bookmark_id,                 :null => false
      t.integer  :user_id,                    :null => false
      t.integer  :rating,                     :null => false
      t.timestamps
    end

    create_table :featured_items do |t|
      t.integer :bookmark_id,                 :null => false
      t.integer  :user_id,                    :null => false
      t.datetime  :start,                    :null => false
      t.datetime  :end,                    :null => false
      t.timestamps
    end

    create_table :pictures_users do |t|
      t.string :picture,                 :null => false
      t.string :uuid,                    :null => false
      t.integer :user_id,                :null => false
      t.boolean :deleted,                :null => false, :default => false
      t.timestamps
    end

    create_table :authorizations do |t|
      t.string :provider,                 :null => false
      t.string :uid,                    :null => false
      t.integer :user_id,                :null => false
    end

    create_table :reports do |t|
      t.integer :complaint_bookmark_id
      t.integer :complaint_user_id
      t.integer :complainer_user_id
      t.string :reason
    end

  end

  def down
    drop_table :bookmarks
    drop_table :users
    drop_table :bookmarks_users
    drop_table :categories
    drop_table :ratings
    drop_table :featured_items
    drop_table :pictures_users
    drop_table :authorizations
    drop_table :reports
  end
end
