collection @gifts
node(:description)      { |u| u.description.titlecase }
attribute               :value, :image_uri

child :donor do 
    node(:name)         { |u| u.name.titlecase }
end

child :judge do
    node(:middle_name)  {|u| u.middle_name.titlecase }
end
