collection @gifts
attributes              :value, :image_uri
node(:description)      { |u| u.description.titlecase }
child :donor do 
    node(:name)         { |u| u.name.titlecase }
    node(:affiliation)  { |u| (u.affiliation||"").titlecase }
    node(:address_raw)  { |u| (u.address_raw||"").titlecase }
end

child :judge do
    node(:first_name)   { |u| u.first_name.titlecase }
    node(:last_name)    { |u| u.last_name.titlecase }
    node(:middle_name)  { |u| u.middle_name.titlecase }
    node(:agency)       { |u| u.agency.titlecase }
end
