ActiveAdmin.register Role do
  permit_params :name

  filter :name
  filter :updated_at
  filter :created_at
end
