collection @gifts
attributes :value, :description, :image_uri
child :donor do 
    attributes :name
end

child :judge do
    attributes :first_name, :last_name, :middle_name
end
