class Archive < ApplicationRecord
  has_attached_file :total_production
  has_attached_file :register

  validates_attachment :total_production,
                     content_type: { content_type: ["application/x-msaccess"] }

  validates_attachment :register,
                      content_type: { content_type: ["application/x-msaccess"] }

    do_not_validate_attachment_file_type :total_production
    do_not_validate_attachment_file_type :register
end
