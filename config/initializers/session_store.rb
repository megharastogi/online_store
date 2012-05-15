# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_my-online-store_session',
  :secret      => '685af62ecbcf417f41fa234bfaf535c32d0748ff108c1eac7b6bd4763d993723ad3427694ef94b74538cd826a01a243bac49fcea6587ecb271528450ef1e68dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
