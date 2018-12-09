ActiveAdmin.register Filter do
  includes :user, :tag, :city

  actions :index

  filter :updated_at
  filter :created_at
end
