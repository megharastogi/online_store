class Image < ActiveRecord::Base
  
  validates_presence_of :content_type, :if => lambda{|i| !i.filename.blank?}
  validates_presence_of :size, :if => lambda{|i| !i.content_type.blank?}
  has_attachment   :content_type => :image,
                   :storage => :file_system,
                   :max_size => 100.kilobytes,
                   :resize_to => '200x200>',
                   :thumbnails => { :thumb => '50x50>' },
                   :processor => 'Rmagick',
                   :path_prefix => 'public/records'
                   
  belongs_to :record, :polymorphic => true
  
  validates_as_attachment 
  
  def validate
      unless self.filename
        errors.add_to_base("You must choose an image(jpg, jpeg, png or gif) to upload.") 
      else
        [:content_type].each do |attr_name|
          enum = attachment_options[attr_name]
          unless enum.nil? || enum.include?(send(attr_name))
            errors.add_to_base("Please upload jpg, jpeg, png or gif image.") #Images should only be GIF, JPEG, or PNG
          end
        end
        if !self.content_type.blank? && self.class.image?(self.content_type)
          [:size].each do |attr_name|
            enum = attachment_options[attr_name]
            unless enum.nil? || enum.include?(send(attr_name))
              errors.add_to_base("Image size should not be more than 1MB.") #Images should be upto 100kb
            end
          end
        end
      end
    end


end
