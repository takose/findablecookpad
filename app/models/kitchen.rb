require 'bundler/setup'
Bundler.require


class Kitchen < ActiveRecord::Base
    validates :link,
        presence: true,
        format: { with: /http:\/\/cookpad\.com\/recipe\/list\/+[0-9]\d/}
end

