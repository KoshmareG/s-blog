ActiveAdmin.register User do
  permit_params :email, :username, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :username
    actions
  end

  show do
    attributes_table do
      row :email
      row :username
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  filter :email
  filter :username
end
