ActiveAdmin.register Place do
  includes :city

  permit_params :title, :description, :city_id

  filter :title
  filter :description
  filter :city_id,
         as: :select,
         input_html: {
           class: 'select2-remote',
           data: {
             source: '/admin/cities/search',
             placeholder: 'Type city name',
             allow_clear: true, ajax__delay: 500
           }
         },
         collection: ->() { City.collection_for_identified_search(params.dig(:q, :city_id_eq)) }
  filter :updated_at
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :city_id,
              as: :select,
              collection: Array.wrap(f.object.city),
              selected: f.object.city_id,
              input_html: {
                class: 'select2-remote',
                data: {
                  source: search_admin_cities_path,
                  placeholder: 'Please type city name',
                  allow_clear: true, ajax__delay: 500
                },
                style: 'width: 80%'
              }
    end
    f.actions
  end

  collection_action :search, method: :get do
    result = Place.identified_search(params[:query], 'cities.name', :title, separator: '/') do |relation|
      relation.joins(:city)
    end

    render json: result
  end
end
