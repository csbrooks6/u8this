# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app, %w{deploy@brooks6.com}
role :web, %w{deploy@brooks6.com}
role :db,  %w{deploy@brooks6.com}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'brooks6.com', user: 'deploy', roles: %w{web app}

set :deploy_to, '/srv/www/staging.u8this.com'
