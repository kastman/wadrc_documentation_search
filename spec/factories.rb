Factory.define :textfile do |f|
  f.sequence(:filepath) {|n| "/path/to/file#{n}"}
  f.content "Eagleman: I've got something, for you!!!"
  f.owner "erik"
  f.modified_at Date.today
  f.accessed_at Date.today
end
