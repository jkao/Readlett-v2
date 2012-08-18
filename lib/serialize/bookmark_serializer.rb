class Serialize::BookmarkSerializer
  # TODO: Change the Title & Description to a MAX Length (see Rails String Helpers)

  def self.json_hash(bookmark)
    return {} if bookmark.nil?

    if bookmark.errors.present?
      { :errors => bookmark.errors.full_messages }.as_json
    else
      {
        :id => bookmark.id,
        :title => bookmark.title,
        :short_title => (bookmark.title && bookmark.title.length > 64) ? "#{bookmark.title[0..61]}..." : bookmark.title,
        :description => bookmark.description,
        :short_description => (bookmark.description && bookmark.description.length > 256) ? "#{bookmark.description[0..253]}..." : bookmark.description,
        :url => bookmark.url,
        :short_url => (bookmark.url && bookmark.url.length > 32) ? "#{bookmark.url[0..29]}..." : bookmark.url,
        :domain_url => bookmark.domain_url,
        :short_domain_url => (bookmark.domain_url && bookmark.domain_url.length > 32) ? "#{bookmark.domain_url[0..29]}..." : bookmark.domain_url,
        :domain_url_with_scheme => bookmark.domain_url_with_scheme,
        :share_url => bookmark.share_url,
        :private => bookmark.private,
        :nsfw => bookmark.nsfw,
        :disqus_uuid => bookmark.disqus_uuid,
        :views => bookmark.views,
        :likes_count => bookmark.likes_count,
        :tags => bookmark.tags,
        :created_at => bookmark.created_at.strftime("%b. %d, %Y"),
        :updated_at => bookmark.updated_at.strftime("%b. %d, %Y"),
        :user => {
          :name => bookmark.user.nil? ? "" : bookmark.user.name
        }
      }
    end
  end

  def self.as_json(bookmark, current_user=nil)
    json = self.json_hash(bookmark)

    # If User is Authenticated, We Want Authentication Details
    if current_user
      auth_hash = {
        :is_owner => bookmark.is_owner?(current_user),
        :follows => current_user.follows?(bookmark)
      }
      json.merge!(auth_hash)
    end

    json.as_json
  end

  def self.as_json_with_current_entries(bookmark, current_user=nil)
    json = self.json_hash(bookmark)

    if current_user
      entries_hash = {
        :current_entry_url => current_user.current_bookmark_user_entry(bookmark).current_url,
        :current_entry_date => current_user.current_bookmark_user_entry(bookmark).created_at.strftime("%b. %d, %Y")
      }
      json.merge!(entries_hash)
    end
  end
end
