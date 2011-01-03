class Freebaseartist < ActiveRecord::Base
  set_inheritance_column "ruby_type"
  establish_connection :postgres_development
    
end
