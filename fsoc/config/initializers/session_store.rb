# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fsoc_session',
  :secret      => 'eda8232ea9089597a0be8d927faf668023c4686f0235ff4624199a41cf09959b5b501ddf807920efc7a668a12b555ad46444001a39ada7862fa8bb73b25bd117'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
