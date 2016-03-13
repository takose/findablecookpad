require 'bundler/setup'
Bundler.require
if development?
  ActiveRecord::Base.establish_connection('sqlite3:db/development.db')
end

class Kitchen < ActiveRecord::Base
    validates :link,
        presence: true,
        format: { with: /http:\/\/cookpad\.com\/recipe\/list\/+[0-9]\d/}
end

