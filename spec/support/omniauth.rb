OmniAuth.config.test_mode = true

def set_omniauth(provider)
  omniauth_hash = { 'uid' => '12345',
                                   'info' => {
                                     'name' => 'soc_net_user',
                                     'email' => 's_n@soc_network.com'
                                  }
                                }
  OmniAuth.config.add_mock(provider, omniauth_hash)
end
