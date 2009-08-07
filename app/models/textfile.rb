class Textfile < ActiveRecord::Base
  validates_presence_of :filepath, :content, :accessed_at
  validates_uniqueness_of :filepath
  
  after_save :write_to_filesystem
  #after_destroy :delete_from_filesystem
  
  def abridged_content(n = 1)
    "#{content.split('. ').first(n).join('. ')}."
  end
  
  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ? OR filepath LIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def write_to_filesystem
    if File.writable?(File.split(self.filepath)[0])
      #open(self.filepath, 'w') { |f| f << self.to_yaml }
      open(self.filepath, 'w') { |f| f << self.content }
    else raise IOError, "Can't write there."
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
