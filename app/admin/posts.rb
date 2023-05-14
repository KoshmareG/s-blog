ActiveAdmin.register Post do
  menu priority: 3

  config.per_page = 10

  permit_params :title, :body, :picture

  index do
    selectable_column
    id_column
    column :title
    column :body do |post|
      truncate(post.body, omision: "...", length: 200)
    end
    column :user
    actions
  end

  show do
    attributes_table do
      row :title
      row :body
      row :picture do |post|
        image_tag url_for(post.picture.variant(resize_to_limit: [400, 400])) if post.picture.present?
      end
      row :user
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
      f.input :picture, as: :file
    end
    f.actions
  end
end
