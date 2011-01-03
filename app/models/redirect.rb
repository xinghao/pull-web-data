class Redirect < ActiveRecord::Base
    establish_connection :postgres_development
    
    def self.getFreebaseName(external_name)
      redirect =  Redirect.find_by_name_lowercase(external_name.downcase);
      if (redirect == nil)
        redirect = Freebaseartist.find_by_name_lowercase(external_name.downcase);
      end
      if (redirect == nil)
        return nil;
      else
        return redirect.redirects_to;
      end
    end
end
