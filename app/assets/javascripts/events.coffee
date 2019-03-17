# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.coffee.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.filters-list select').on 'change', (e) ->
    $('.saved-filters .buttons form#delete_filter').attr('action', '/filters/' + this.value)
    $('.saved-filters .buttons form#apply_filter').attr('action', '/filtered_events_lists/' + this.value)