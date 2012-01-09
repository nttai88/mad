class Document < ActiveRecord::Base
  belongs_to :project

  mount_uploader :file, FileUploader
  mount_uploader :file1, FileUploader
  mount_uploader :file2, FileUploader
  mount_uploader :file3, FileUploader
  mount_uploader :file4, FileUploader
  mount_uploader :file5, FileUploader
  mount_uploader :file6, FileUploader
  mount_uploader :file7, FileUploader
  mount_uploader :file8, FileUploader
  mount_uploader :file9, FileUploader

end
