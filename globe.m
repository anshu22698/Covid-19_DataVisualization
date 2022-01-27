classdef globe < handle  %class "globe" is handle class
    properties (Access = {?globe, ?Covid_19_Data_Visualization})
       cumulative_cases   (1,:) {mustBeNonnegative}  
       daily_cases   (1,:) {mustBeNonnegative} 
       cumulative_deaths  (1,:) {mustBeNonnegative} 
       daily_deaths  (1,:) {mustBeNonnegative} 
       Covid_Data    
       colm_date   (1,1) {mustBeNonnegative}
       first_last_date (1,2) string 
    end
    
    properties (Access = ?Covid_19_Data_Visualization)
       country_names (1,:) string = []
       country_pos (1,:) {mustBePositive} =[]
        
    end
    
    methods
        function obj = globe()
             load qkrt-BxiRTeK7fgcYsU3vw_924002543e084e8fa745395261e942ed_covid_data.mat covid_data
             obj.Covid_Data = covid_data;
             [r,c] = size(obj.Covid_Data);  %row and column of data
             obj.colm_date = c-2; %total number of column with dates i.e. actual data of covid-19
             obj.first_last_date = [string(obj.Covid_Data{1,3}), string(obj.Covid_Data{1,end}) ];  %first and last date of data
            
             if ~isa(obj,"country")   %if "obj" is not of class "country"              
                 for ii=2:r
                     if isempty(obj.Covid_Data{ii,2}) %first row with country name has empty state/region 
                        %storing country names and their position 
                        obj.country_names=[obj.country_names, obj.Covid_Data{ii,1}] ;
                        obj.country_pos = [obj.country_pos,ii];
                     end
                 end
                             
                 for ii=1:obj.colm_date
                     cumulative_data = [0 0 ];
                     for jj = obj.country_pos
                         %cumulative data for world by adding cumulative
                         %data of each country for one day and repeating it
                         %to obtain it for all dates
                        
                        cumulative_data = cumulative_data + obj.Covid_Data{jj,ii+2};   
                     end
                     obj.cumulative_cases(ii) = cumulative_data(1);
                     obj.cumulative_deaths(ii) = cumulative_data(2);
                 end 
                 obj.cumulative_to_daily();  %calculating daily data      
            end
        end  %constructor ends 
             
        %convert cumulative data to daily basis data
        function cumulative_to_daily(obj)
            cases = obj.cumulative_cases; deaths = obj.cumulative_deaths;        
            % in data there are some points in which cumulative deaths decrease. 
            % e.g.  In Alabama, (row = 268), in column 249,250,251  deaths are : 2506,2491,2501
            daily_c = cases-[0,cases(1:end-1)];
            daily_d = deaths -[0,deaths(1:end-1)];
            daily_c(daily_c<0) = 0;
            daily_d(daily_d<0) = 0 ;
            obj.daily_cases = daily_c;
            obj.daily_deaths = daily_d;
        end
    end 
end