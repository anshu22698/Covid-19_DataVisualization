classdef country < globe  %subclass of class "globe"
    properties (Access = protected)
        position (1,:) {mustBePositive} =[]        
    end
    properties (Access = ?Covid_19_Data_Visualization)
        state_names (1,:) string = []
    end
      
    methods    
        function obj = country(c_name)
            arguments
               c_name (1,1) string = " "
            end
            
            if ~isa(obj,"state")         %if obj is not of class "state"      
                if c_name ~= " "
                    obj.find_pos(c_name,1);  %find position/row number of country
                    %it will be array of number when country has atleast 1 state/region
                    
                    obj.cumulative_details(obj.position(1)); %cumulative details of country
                    obj.cumulative_to_daily();  %daily details
                end           
                if length(obj.position)>1  %it mean country has atleast 1 state
                    state_cell = obj.Covid_Data(obj.position(2:end),2); %cell of names of states of country
                    for ii =1:length(state_cell)
                       obj.state_names =[obj.state_names, string(state_cell{ii})];  %convert cell to string array   
                    end               
                end   
                
            end
                                 
        end %constructor end
         
        %find the position of country or state/region in data%
        %value of k=1 for country as it is in 1st column and 2 for state as it is in 2nd column%
        function find_pos(obj,count_or_state,k)
            [r,~] = size(obj.Covid_Data);
            for ii = 2:r
                if ~isempty(strfind(obj.Covid_Data{ii,k},count_or_state))
                      obj.position = [obj.position ii];
                end
            end
        end
        
        %find the cumulative details for country or state
        function cumulative_details(obj,obj_pos)
            for ii=1:obj.colm_date     
                cumulative_data = obj.Covid_Data{obj_pos,ii+2};
                obj.cumulative_cases(ii) = cumulative_data(1);  %as 1st data is "cases" in 2 element vector
                obj.cumulative_deaths(ii) = cumulative_data(2);
            end
        end 
    end    
end