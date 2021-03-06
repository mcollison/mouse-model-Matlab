function [conditionStr, otuName, otu] = separateOtuVars(otuFileName)
%%
%[GROUPS, OTUNAMES, MEASUREMENTMATRIX] = separateOtuVars(FILENAME) 
%   Returns Groups deining the conditions of each subject/column. 
%   MetaboliteNames that defines the metaboite linked to each row and a 
%   nx59 matrix containing measurements of the corresponding metaboite

%load metabolite data 
metabolite_fid = fopen(otuFileName);
%parse data into string by tab delimiters
metabolite_C = textscan(metabolite_fid, '%s', 'delimiter', '\t');

% separate variables, construct otu array 
for i=1:1532
    for j=1:63
        if i==1
        conditionStr{j}=cell2mat(metabolite_C{1}((i-1)*63+j));
        else
            if j==1
            elseif j==63
                otuName{i-1}=cell2mat(metabolite_C{1}((i-1)*63+j));
            else
                otu(j-1,i-1)=str2double(cell2mat(metabolite_C{1}((i-1)*63+j)));
            end
        end
    end
end
