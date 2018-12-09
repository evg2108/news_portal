ActiveAdmin.register Post do
  permit_params :message

  filter :message
  filter :updated_at
  filter :created_at
end
