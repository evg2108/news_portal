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
  if $('.data-store').length > 0
    App.cable.subscriptions.create { channel: "ApplicationCable::NewEventChannel", room: 'all' },
      received: (data) ->
        current_filter_ids = $('.data-store').data('current-filter-ids')
        recived_filter_ids = data.filter_ids
        return if recived_filter_ids.length == 0 || current_filter_ids.length == 0

        intersection =  $(current_filter_ids).not($(current_filter_ids).not(recived_filter_ids))

        if intersection.length > 0
          $.getJSON('/events/' + data.event_id).then (result) ->
            new Noty(
              text: 'Анонсировано новое событие отфильтрованное для вас: ' + result.title
              type: 'success'
              theme: 'semanticui'
            ).show()

    $.getJSON('/events/new_events').then (result) ->
      result.events.forEach (event_title) ->
        new Noty(
          text: 'Анонсировано новое событие отфильтрованное для вас: ' + event_title
          type: 'success'
          theme: 'semanticui'
        ).show()

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

  $('.header').on 'submit', 'form.ajax-reloader-form', (e) ->
    e.preventDefault()

    $form = $(this)
    $submit_button = $form.find('input[type="submit"]')

    $.ajax
      url: $form.attr('action')
      dataType: 'json'
      contentType: 'application/x-www-form-urlencoded'
      method: $form.attr('method')
      data: $form.serialize()
      success: (result, status, xhr) ->
        if xhr.status == 201
          location.replace(xhr.getResponseHeader('location'))
      error: (xhr) ->
        response = xhr.responseJSON
        notification_message = if response then response.error else ('error ' + xhr.status)
        new Noty(
          text: notification_message,
          type: 'error',
          theme: 'semanticui'
        ).show()
        $submit_button.attr('disabled', false)

  $('.date-time-picker').datetimepicker
    format:'Y-m-d H:i'
    formatTime:'H:i'
    formatDate:'Y-m-d'
    step: 10