require "ckeditor/orm/active_record"
Ckeditor.setup do |config|
  config.assets_languages = ['en', 'fr']
  config.assets_plugins = ['image', 'smiley']
end
