%TREATMENTEFFECTS Test whether the population distributions are normal then 
%calculates differential stats for comparing across tretament groups and 
%produces the figures to show differences in distributions. 

%% Initial configuration 
close all
clear all

%set filename and path to the file on your computer
[metaboliteFileName, otuFileName] = fileNameCheck('results2.txt', 'otu_table3.txt');

%separate variables 
[mconditionStr, metaboliteName, metabolite] = separateMetaboliteVars(metaboliteFileName);

%add insulin:gluose ratio 
for i=1:59
    metabolite(27,i)=metabolite(18,i)/metabolite(1,i);
end
metaboliteName{27}='Insulin:Glucose ratio';

%compute averages and errors 
[norm, maverages, mstderrors, mcategory] = metaboliteBasicstats(metabolite,mconditionStr);

%% Generate stats and graphs between lean and obese controls 
%graphs and stats for glucose (1) insulin (18) active GLP-1 (25) total
%GLP-1 (26) and insulin:glucose ratio (27). Matrix indexes in brackets.
variableIndex = [1 18 25 26 27];
logswitch = [0 0 0 0 1];

%treatment groups: Lean control (1) obese control (2) gram positive
%antibiotic (3) high dose gram negative anitbiotic (4) low dose gram
%negative antibiotic (5) olligofructosccharide supplement (6)
groups = [1 2 3 4 5 6];
%groups = [2 3 4 5 6];

%plot graphs horizontally or vertically
horizontal=1;

%normalisation tests
normalisationTest(variableIndex, mcategory, norm, metaboliteName, logswitch, groups, horizontal);

%box plots and stats 
[pvalues, string_answers] = generateBoxPlotsAndAnovaPValue(variableIndex, mcategory, metaboliteName, logswitch, groups);