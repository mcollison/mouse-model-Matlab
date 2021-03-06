%MODELVALIDATION Test whether the distributions are normal then calculates 
%differential stats for validating the diabetic mouse model and produces 
%and formats the figures for publication

%% Initial configuration 
close all
clear all
path(path,'./support_scripts/')

%set filename and path to the file on your computer
[metaboliteFileName, otuFileName] = fileNameCheck('results2.txt', 'otu_table3.txt');

%separate variables 
[mconditionStr, metaboliteName, metabolite] = separateMetaboliteVars(metaboliteFileName);



%add insulin:gluose ratio 
for i=1:59 
    metabolite(27,i)=metabolite(18,i)/metabolite(1,i);
end

%correct metabolite labels
metaboliteName{1} = 'glucose';
metaboliteName{18} = 'insulin';
metaboliteName{27}='insulin:glucose';

%compute averages and errors 
[norm, maverages, mstderrors, mcategory] = metaboliteBasicstats(metabolite,mconditionStr);

%% Generate stats and graphs between lean and obese controls 
%graphs and stats for glucose (1) insulin (18) active GLP-1 (25) total
%GLP-1 (26) and insulin:glucose ratio (27). Matrix indexes in brackets. 
variableIndex = [1 18 25 26 27];
logswitch = [0 0 0 0 0];

%treatment groups: Lean control (1) obese control (2) gram positive
%antibiotic (3) high dose gram negative anitbiotic (4) low dose gram
%negative antibiotic (5) olligofructosccharide supplement (6)
groups = [1 2];

%plot graphs horizontally or vertically
horizontal=1;

%normalisation tests
[h1, hs1] = normalisationTest(variableIndex, mcategory, norm, metaboliteName, logswitch, groups, horizontal);

%box plots and stats 
[pvalues, string_answers, h2, hs2] = generateBoxPlotsAndTtest2PValue(variableIndex, mcategory, metaboliteName, logswitch);


%% Final formatting and save to pdf file
figure(h1)
axesHandles = get(gcf,'children');
set(axesHandles,'fontsize', 5)
for i=1:length(axesHandles)
    title = get(axesHandles(i), 'title');
    set(title, 'fontsize', 7)
    ylabel(axesHandles(i),'Probability')
end
figuresize(15, 10, 'centimeters') %updated script using Matt's magic number!
saveas(gcf, 'pdf_figures/model_validation_diabetic_markers_normalisation_test', 'pdf')

figure(h2)
figuresize(15, 10, 'centimeters')
%set( get(hs2(1),'YLabel'), 'String', 'mgdL^{-1}' );
%should include more units as ylabels here when they are available
saveas(gcf, 'pdf_figures/model_validation_diabetic_markers', 'pdf')