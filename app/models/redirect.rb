class Redirect < ActiveRecord::Base
    establish_connection :postgres_development
    
    def self.getFreebaseName(external_name)
      redirect =  Redirect.find_by_name(external_name);
      if (redirect == nil)
        return nil;
      else
        return redirect.redirects_to;
      end
    end
end
