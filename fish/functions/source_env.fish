
# Function to source a dotenv file before running a command

function source_env
  bass export (cat $argv[1] | sed -E '/^(#|$)/ d')
  eval $argv[2..-1]
end
