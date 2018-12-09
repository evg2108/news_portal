ActiveAdmin.register Tag do
  permit_params :name

  filter :updated_at
  filter :created_at
end
