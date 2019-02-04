class Design < ApplicationRecord
  mount_uploader :template_image, DesignUploader
  has_many :vouchers

  scope :with_template, -> { where.not(template_image: nil) }

end
