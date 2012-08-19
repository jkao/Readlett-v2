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
    #Backbone.history.start()

  # Explore Page
  if $('#explore-bookmarks').present()
    window.router = new ExploreRouter()
    Backbone.history.start()

  # Share Bar
  if $("#share-bar").present()
    window.router = new ShareRouter().initializeShareBar()


  # My Bookmarks Page
  if $("#my-bookmarks").present()
    window.router = new MyBookmarksRouter()
    Backbone.history.start()

  # Feedback Dialog
  if $("#feedback-dialog").present()
    new FeedbackDialogView({
      el: "#feedback-dialog"
    })

  null
)
