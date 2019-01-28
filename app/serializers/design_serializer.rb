class DesignSerializer < ActiveModel::Serializer

  attributes :id, :name, :template, :height, :width,
       :created_at, :updated_at
end
