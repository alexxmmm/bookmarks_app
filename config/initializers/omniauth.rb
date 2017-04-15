OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1820194308303529', 'ecba24e660da4936a07fb8c4f2d3a8b4'
end
