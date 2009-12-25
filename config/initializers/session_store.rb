# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_photoblog_session',
  :secret      => '86a7af40aa541899e312668d0a58482485cbf5051ab9327ab28b8d459bf610098772bdf365a39a5aa5f2a76b652a21464d9b08863dd9b3128acb5f4a76cf14c2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
