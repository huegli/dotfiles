if status is-interactive
  # Commands to run in interactive sessions can go here
  
  # VI mode
  fish_vi_key_bindings
  # fish_user_key_bindings
  bind --mode insert --sets-mode default jk repaint
end
