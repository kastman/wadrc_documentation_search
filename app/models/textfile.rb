class Textfile < ActiveRecord::Base
  validates_presence_of :filepath, :content, :owner, :accessed_at, :modified_at
  validates_uniqueness_of :filepath
  
  before_save :write_to_filesystem
  #after_destroy :delete_from_filesystem

  
  attr_accessor :needs_fs_update
  
  def abridged_filepath
    filepath.ellipsisize(90)
  end
  
  def abridged_content(n = 1)
    "#{content.split('. ').first(n).join('. ')}."
  end
  
  
  # Writes @content to the filesystem, so you can update textfiles from the 
  # Rails app itself.
  def write_to_filesystem
    if @needs_fs_update 
      if File.writable?(File.split(self.filepath)[0])
        #open(self.filepath, 'w') { |f| f << self.to_yaml }
        open(self.filepath, 'w') { |f| f << self.content }
        modified_at = Time.now
        # File.chown(Etc.getpwnam(owner).uid, nil, filepath)
      else raise IOError, "Unable to write to file."
      end
    end
  end
  
  # # This is set to true when the Textfile is modified by the Rails app and 
  # # content differs from what's on the filesystem, but doesn't actually
  # # do a file read to check.
  # #
  # # Technically, if the instance variable isn't defined it will return nil
  # # which evals to false, but return false explicitly is a little nicer.
  # def needs_fs_update
  #   @needs_fs_update
  # end
  # 
  # # Setter for needs_fs_update virtual attribute
  # def needs_fs_update=(value)
  #   @needs_fs_update = value
  # end
  

  ## Deletes a file from the filesystem when it is removed from Rails.
  ## In general this was too dangerous, so I've commented it out, but might
  ## bring it back with better sanity checks.
  # def delete_from_filesystem
  #   if File.writable?(self.filepath)
  #     File.delete(self.filepath)
  #   end
  # end

  
end
