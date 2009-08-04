class Textfile < ActiveRecord::Base
  validates_presence_of :filepath, :content, :accessed_at
  
  validates_uniqueness_of :filepath
  
  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ? OR filepath LIKE ?', "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
end
