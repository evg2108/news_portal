ActiveAdmin.register Event do
  includes :tags, place: :city

  permit_params :title, :description, :begin_time, :end_time, :place_id, tag_names: []

  filter :title
  filter :description
  filter :begin_time
  filter :end_time
  filter :place_id,
         as: :select,
         input_html: {
           class: 'select2-remote',
           data: {
             source: '/admin/places/search',
             placeholder: 'Type city name / place name',
             allow_clear: true, ajax__delay: 500
           }
         },
         collection: ->() { Place.collection_for_identified_search(params.dig(:q, :place_id_eq)) }
  filter :updated_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :place_id,
              as: :select,
              collection: f.object.place&.for_identified_select || [],
              selected: f.object.place_id,
              input_html: {
                class: 'select2-remote',
                data: {
                  source: search_admin_places_path,
                  placeholder: 'Type city name / placement name',
                  allow_clear: true, ajax__delay: 500
                },
                style: 'width: 80%'
              }
      f.input :tag_names,
              as: :select,
              collection: f.object.tag_names,
              multiple: true,
              input_html: { class: 'select2-tags', style: 'width: 80%' }
      f.input :begin_time, as: :string, input_html: { class: 'date-time-picker' }
      f.input :end_time, as: :string, input_html: { class: 'date-time-picker' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :begin_time
      row :end_time
      row :place
      row :city
      row :tags do
        resource.tag_names.join(', ')
      end
      row :updated_at
      row :created_at
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :begin_time
    column :end_time
    column :place
    column :city
    column :tags do |row|
      row.tag_names.join(', ')
    end
    column :created_at
    actions
  end

  collection_action :search, method: :get do
    result = Event.identified_search(params[:query], 'cities.name', 'places.title', 'events.title', separator: '/') do |relation|
      relation.joins(place: :city)
    end
    render json: result
  end
end
