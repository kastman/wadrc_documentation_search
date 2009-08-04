# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_textfile_search_session',
  :secret      => 'f1f49bb07a5772efa066b272bb224a1dd28c59681e89f046194809d444ef3dfa0cadb1e3dd28c94c88eb0a331063d21afbc7510fb84458182d27443e70bd841f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
