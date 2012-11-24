collection @gifts
node(:description)      { |u| u.description.titlecase }
attribute               :value, :image_uri
child :gift_type do
    node(:gift_type)         { |u| u.gift_type.titlecase }
end

child :donor do 
    node(:name)         { |u| u.name.titlecase }
end

child :judge do
    node(:middle_name)  {|u| u.middle_name.titlecase }
end
