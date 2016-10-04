# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_proBooks_session',
  :secret      => 'b2c0ca303bfe7cbdba1366f825ab44ee803f07422e751278deee89d93e2cac7ef46c3ab855339b29abd0cbca6dcd90f28ba6ee49ff07ad9c4a798fbc1242e7e6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
