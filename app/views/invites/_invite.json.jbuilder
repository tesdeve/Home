json.extract! invite, :id, :email, :token, :sender_id, :recipient_id, :building_id, :accepted, :created_at, :updated_at
json.url invite_url(invite, format: :json)
