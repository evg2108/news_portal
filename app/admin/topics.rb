ActiveAdmin.register Topic do
  includes :event

  permit_params :title, :description, :event_id

  filter :title
  filter :description
  filter :event_id,
         as: :select,
         input_html: {
           class: 'select2-remote',
           data: {
             source: '/admin/events/search',
             placeholder: 'Type city name / place name / event_name',
             allow_clear: true, ajax__delay: 500
           }
         },
         collection: ->() { Event.collection_for_identified_search(params.dig(:q, :event_id_eq)) }
  filter :updated_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :event_id,
              as: :select,
              collection: f.object.event&.for_identified_select || [],
              selected: f.object.event_id,
              input_html: {
                class: 'select2-remote',
                data: {
                  source: search_admin_events_path,
                  placeholder: 'Type city name / place name / event_name',
                  allow_clear: true, ajax__delay: 500
                },
                style: 'width: 80%'
              }
      f.input :title
      f.input :description
    end
    f.actions
  end

end
