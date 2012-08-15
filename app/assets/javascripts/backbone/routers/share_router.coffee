class window.ShareRouter extends Backbone.Router
  routes: null

  initializeShareBar: ->
    new window.ShareBarView
      el: $("#share-bar"),
      model: new Bookmark($("#share-bar").data('bookmark'))
    @
