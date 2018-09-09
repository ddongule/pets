require 'csv'
class Pet < ApplicationRecord
    validates :character ,:uniqueness => true

    def self.to_csv
        CSV.generate do |csv|
            csv << Pet.attribute_names
            Pet.all.each do |pet|
                csv << pet.attributes.values
            end
        end
    end

end
