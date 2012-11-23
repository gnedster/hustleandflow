collection @gifts
attributes :value, :description, :image_uri
child :donor do 
    node :name do |u| 
        u.name.titlecase
    end
end

child :judge do
    node :middle_name do |u|
        u.middle_name.titlecase
    end
end
