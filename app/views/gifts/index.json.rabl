collection @gifts
attributes :value, :description, :image_uri
child :donor do 
    attributes :name, :affiliation, :address_raw
end

child :judge do
    attributes :first_name, :last_name, :middle_name, :agency
end
