#= require jquery
#= require rails-ujs
#= require activestorage
#= require cable
#= require noty/lib/noty
#= require select2/dist/js/select2
#= require lib/select2-custom
#= require jquery-datetimepicker/build/jquery.datetimepicker.full
#= require events
#= require_self

$ ->
  requestNewEvents = ->
    $.getJSON('/new_events').then (result) ->
      result.events.forEach (event_title) ->
        new Noty(
          text: 'Анонсировано новое событие отфильтрованное для вас: ' + event_title
          type: 'success'
          theme: 'semanticui'
        ).show()

      if result.last_event_id
        $.ajax
          url: '/new_event_marks/' + result.last_event_id
          method: 'PATCH'

  if $('.data-store').length > 0
    App.cable.subscriptions.create { channel: "ApplicationCable::NewEventChannel", room: 'all' },
      received: (data) ->
        if data.event_id
          requestNewEvents()

    requestNewEvents()

  $('.header').on 'click', 'button.inline', (e) ->
    buttons = $('.header').find('button.hidden')
    buttons.removeClass('hidden')
    buttons.addClass('inline')

    $this = $(this)
    $this.addClass('hidden')
    $this.removeClass('inline')

    visible_block = $('.header .inline-block')
    visible_block.removeClass('inline-block')
    visible_block.addClass('hidden')

    show_block_class = $this.data('activate')
    show_block = $('.header .' + show_block_class)
    show_block.removeClass('hidden')
    show_block.addClass('inline-block') unless show_block.hasClass('inline-block')

  $('.date-time-picker').datetimepicker
    format:'Y-m-d H:i'
    formatTime:'H:i'
    formatDate:'Y-m-d'
    step: 10