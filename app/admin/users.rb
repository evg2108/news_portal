ActiveAdmin.register User do
  includes :roles

  permit_params :email, :name, :password, :password_confirmation, role_ids: []

  filter :email
  filter :name
  filter :created_at

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :roles do |row|
      row.roles_name.join(', ')
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :name
      row :roles do
        resource.roles_name.join(', ')
      end
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :roles,
              as: :select,
              collection: Role.all,
              multiple: true,
              input_html: { class: 'select2-tagged-multiselect', style: 'width: 80%' }
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

end
