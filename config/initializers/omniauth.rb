Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production? || Rails.env.test?
    provider :facebook, '892712080819102', '4c85eca4962b30225bcae5f9d7efc7ad'
    provider :twitter, 'oejiCjKy7SeW7IP0OQpZUn3vS', 'DTNkd8q8Hy5bBTd3YuNLJc0jNktSqER38kTcfrEXukeCrlzKNZ'
  elsif Rails.env.development?
    provider :facebook, '1031055046915188', 'd49a98c2171b28892f4242f439a98d88'
    provider :twitter, 'kkWyWnfAhUoOCk9PgYz9bvGnJ', '7CUBRcj1729pHQWXSBt8R4WhYm944fofPhkCjyRVroLn4MKdg3'
  end
end
