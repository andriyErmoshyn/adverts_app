def log_in_with(login, password)
    visit login_path
    fill_in 'Login', with: login
    fill_in 'Password', with: password
    click_button 'Log in'
  end

# For sessions_controller_spec.rb
  def log_in(member, opts={})
    remember_me = opts[:remember_me] || 1
    post :create, session: { login: member.login, password: member.password, remember_me: remember_me }
  end
