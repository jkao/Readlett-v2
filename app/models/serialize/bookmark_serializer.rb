class Serialize::BookmarkSerializer
  def self.as_json(bookmark)
    if bookmark.errors.present?
      { :errors => bookmark.errors.full_messages }
    else
      {
        :id => bookmark.id,
        :title => bookmark.title,
        :description => bookmark.description,
        :url => "/bookmark/#{bookmark.id}/redirect/", # TODO: Can't seem to resolve routes here
        :private => bookmark.private,
        :nsfw => bookmark.nsfw,
        :disqus_uuid => bookmark.disqus_uuid,
        :views => bookmark.views,
        :likes_count => bookmark.likes_count,
        :created_at => bookmark.created_at,
        :updated_at => bookmark.updated_at,
        :user_id => bookmark.user_id # TODO: This should be a serialized User Object
      }
    end
  end

  def self.with_user_as_json(user, bookmark)
    # TODO
  end
end
