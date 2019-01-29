class Design < ApplicationRecord
  mount_uploader :template_image, DesignUploader
  has_many :vouchers
end
