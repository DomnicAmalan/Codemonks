set :branch, "staging"
set :yarn_flags, '--staging --silent --no-progress'    # default
server "3.109.169.1", user: "ubuntu", roles: %w{web}, my_property: :my_value
