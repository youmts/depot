ActiveAdmin.register Product do
  permit_params :title, :description, :image, :price

  index do
    selectable_column
    id_column
    column :title
    column :image do |product|
      link_to image_tag(product.image_url(:thumb)), admin_product_path(product)
    end
    column :price
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :image do |product|
        image_tag(product.image_url(:thumb))
      end
      row :price
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :image, as: :file
      f.input :price
    end
    f.actions
  end
end
