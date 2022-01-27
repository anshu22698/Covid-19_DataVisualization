classdef state < country  %subclass of class "country"
   properties (Access = ?Covid_19_Data_Visualization)
       country_of_state  (1,1) string
   end
   methods
       function obj = state(st_name,c_name)
           arguments
              st_name (1,1) string = " " 
              c_name (1,1) string = " "
           end
          obj@country(c_name);          
          if st_name ~= " "   
              obj.find_pos(st_name,2);  %find the position of state i.e. row number in data 
              obj.cumulative_details(obj.position); %find the cumulative details and store according to date
              obj.cumulative_to_daily();  %find daily data with help of cumulative data 
              obj.country_of_state = obj.Covid_Data{obj.position,1};  %find the country of state/region 
          end
       end       
   end
end