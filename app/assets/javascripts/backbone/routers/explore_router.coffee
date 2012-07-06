class window.ExploreRouter extends Backbone.Router
  routes:
    'tag/:id' : 'tag'

  tag: (id) ->
    alert("tag #{id}")
