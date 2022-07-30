# If a virtual env is active, launch nvim, else launch the virtualenv then nvim

function prv
  if set -q VIRTUAL_ENV;
    nvim;
  else;
    poetry run nvim
  end
end
