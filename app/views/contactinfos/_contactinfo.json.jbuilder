json.extract! contactinfo, :id, :contactable_id, :contactable_type, :telefono, :email, :mobile, :created_at, :updated_at
json.url contactinfo_url(contactinfo, format: :json)
