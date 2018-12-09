$ ->
  $('.select2-simple').select2()

  $('.select2-tags').select2(
    tags: true
    tokenSeparators: [",", " ", ";"],
  ).on('select2:open', (e)->
    $('.select2-container--open .select2-dropdown--below').css('display','none');
  )

  $('.select2-tagged-multiselect').select2
    tags: true
    closeOnSelect: false

  $('.select2-remote').each ->
    $this = $(this);

    source = (terms) ->
      $this.data('source')

    $this.select2
      minimumInputLength: 3
      ajax:
        url: source,
        dataType: 'json',
        data: (params) -> { query: params.term }
        processResults: (data, params) -> { results: data }
      escapeMarkup: (markup) -> markup
