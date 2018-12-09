# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.coffee.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.filter-presets').on 'submit', 'form', (e) ->
    e.preventDefault()
    $this = $(this)
    $name_field = $this.find('#filter_name')
    field_name = $name_field.attr('name')
    name = $name_field.val()

    data = $('.filter-block form').serializeArray()
    data.push({ name: field_name, value: name })

    $submit_button = $this.find('input[type="submit"]')

    $.ajax
      url: $this.attr('action')
      dataType: 'json'
      contentType: 'application/x-www-form-urlencoded'
      method: $this.attr('method')
      data: dataArrayToObject(data)
      success: (result, status, xhr) ->
        $name_field.val('')
        $submit_button.attr('disabled', false)
        $('.saved-filters select').append($('<option>', { text: result.name, value: result.id }))

        $data_store = $('.data-store')
        current_filter_ids = $data_store.data('current-filter-ids')
        current_filter_ids.push(result.id)
        $data_store.data('current-filter-ids', current_filter_ids)
        notification_message = 'Filter "' + result.name + '" created'
        new Noty(
          text: notification_message,
          type: 'success',
          theme: 'semanticui'
        ).show()
      error: (xhr) ->
        response = xhr.responseJSON
        notification_message = if response then response.error else ('error ' + xhr.status)
        new Noty(
          text: notification_message,
          type: 'error',
          theme: 'semanticui'
        ).show()
        $submit_button.attr('disabled', false)

  dataArrayToObject = (data) ->
    result = {}
    $.map data, (elem, index) ->
      result[elem['name']] = elem['value']

    result

  $('.saved-filters').on 'click', '.load-filter-button', (e) ->
    e.preventDefault()

    selected_filter_id = $('.filters-list select').val()
    return if selected_filter_id == ''

    $.getJSON('/filters/' + selected_filter_id).then (result) ->
      location.replace(location.pathname + '?' + $.param(result))
      return

  $('.saved-filters').on 'click', '.remove-filter-button', (e) ->
    e.preventDefault()

    selected_filter_id = $('.filters-list select').val()
    return if selected_filter_id == ''

    selected_filter_id = parseInt(selected_filter_id)
    $selected_option = $('.saved-filters').find('option[value=' + selected_filter_id + ']')

    $.ajax
      url: '/filters/' + selected_filter_id
      method: 'DELETE'
      success: (result, status, xhr) ->
        $selected_option.remove()
        $data_store = $('.data-store')
        current_filter_ids = $data_store.data('current-filter-ids')
        filtered_ids = current_filter_ids.filter (value) ->
          value != selected_filter_id
        $data_store.data('current-filter-ids', filtered_ids)
      error: (xhr) ->
        response = xhr.responseJSON
        notification_message = if response then response.error else ('error ' + xhr.status)
        new Noty(
          text: notification_message,
          type: 'error',
          theme: 'semanticui'
        ).show()
        $submit_button.attr('disabled', false)


