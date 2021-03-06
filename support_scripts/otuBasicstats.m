function [averages, stderrors, category] = otuBasicstats(matrix, groups)
for i=1:61
    group{i}=groups{i+1};
end

%separate groups using indexing
str1='';
j=0;
index{1}=1;

for i=1:length(matrix(:,1))
    str2=group{i};
    bool=strcmp(str1,str2);
    if bool==0
        if j>0
            for h=1:length(category(:,1))
                if strcmp(category{h,1},str2)
                    j=h;
                end
            end
            if j==t
                j=length(category(:,1))+1;
                index{j}=1;
                category{j,2}(index{j})=i;
                category{j,1}=str2;
                index{j}=index{j}+1;
            else
                category{j,2}(index{j})=i;
                category{j,1}=str2;
                index{j}=index{j}+1;
            end
        else
            j=1;
            category{j,2}(index{j})=i;
            category{j,1}=str2;
            index{j}=index{j}+1;
        end
    else
        category{j,2}(index{j})=i;
        index{j}=index{j}+1;
    end
    str1=str2;
    t=j;
end

%use indexing to calculate averages 
for k=1:length(matrix(1,:))
    vector=matrix(:,k);
    for i=1:length(category)
        category{i,1};
        aver(i) = mean(vector(category{i,2}));
        standev(i) = std(vector(category{i,2}));
        stderror(i) = standev(i)/sqrt(length(category{i,2}));
    end
    averages(k,:)=aver;
    stderrors(k,:)=stderror;
end