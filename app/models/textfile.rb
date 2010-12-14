class Textfile < ActiveRecord::Base
  validates_presence_of :filepath, :content, :owner, :accessed_at
  validates_uniqueness_of :filepath
  
  after_update :write_to_filesystem
  #after_destroy :delete_from_filesystem
  
  def abridged_content(n = 1)
    "#{content.split('. ').first(n).join('. ')}."
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ? OR filepath LIKE ? OR owner LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def write_to_filesystem
    if open(filepath, 'r') { |f| f.read } != content
      if File.writable?(File.split(self.filepath)[0])
        #open(self.filepath, 'w') { |f| f << self.to_yaml }
        open(self.filepath, 'w') { |f| f << self.content }
      else raise IOError, "Unable to write to file."
      end
    else
      # File content hasn't changed, only "accessed_at"
    end
  end
  
=begin
  def delete_from_filesystem
    if File.writable?(self.filepath)
      File.delete(self.filepath)
    end
  end
=end
  
end
