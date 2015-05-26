class Task4 < ActiveRecord::Base
  establish_connection "#{Rails.env}_sec"

end

class Rubric < ActiveRecord::Base
  establish_connection "#{Rails.env}_sec"
  has_many :products 
end

class Product < ActiveRecord::Base
  establish_connection "#{Rails.env}_sec"
  belongs_to :rubtic
end
