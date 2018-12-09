ActiveAdmin.register City do
  permit_params :name

  filter :name
  filter :updated_at
  filter :created_at

  collection_action :search, method: :get do
    result = City.identified_search(params[:query], :name)
    render json: result
  end
end
