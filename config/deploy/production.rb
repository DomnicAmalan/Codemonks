set :branch, "main"
set :yarn_flags, '--production --silent --no-progress'    # default
server "3.109.169.1", user: "ubuntu", roles: %w{web}, my_property: :my_value
