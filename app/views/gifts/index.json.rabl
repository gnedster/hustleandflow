collection @gifts
attributes :value, :description, :image_uri
child :donor do 
    node :name do |u| 
        u.name.titlecase
    end
    attributes :affiliation, :address_raw
end

child :judge do
    node :first_name do |u|
        u.first_name.titlecase
    end
    node :last_name do |u|
        u.last_name.titlecase
    end

    node :middle_name do |u|
        u.middle_name.titlecase
    end
    attributes :agency
end
