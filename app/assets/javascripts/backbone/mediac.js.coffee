#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Mediac =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

window.TEMPLATES = "backbone/templates"

# Initialize the Application
$(->

  # Home Page
  if $('#recent-bookmarks').present()
    window.router = new HomeRouter().initializeRecentBookmarksFeed()
    Backbone.history.start()

  # Explore Page
  if $('#explore-bookmarks').present()
    window.router = new ExploreRouter()
    Backbone.history.start()

  # Profiles Page
  # TODO

  null
)
