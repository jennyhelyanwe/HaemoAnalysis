% Plot end diastolic pressure as boxplots. 
close all
clear
study_names = {'STF_16', 'STF_17', 'STF_18','STF_19', 'STF_20',  'MR_250250'...
    , 'MR_293293', 'MR_119119', 'MR_054054', 'MR_104104', 'MR_236236', 'MR_269269','MR_087087', ...
    'MR_091091', 'MR_124124', 'MR_126126', 'STF_01', 'STF_02', 'STF_08', 'STF_09', 'STF_13', ...
    'MR_042042', 'STF_10', 'STF_11', 'MR_262262', 'STF_06', 'STF_12', 'MR_160160'};
fig = figure;
hold on
EDP = [];
grp = [];
fidw = fopen('MeanEDP_SEM.txt', 'w');
fprintf(fidw, 'Study name\tMean EDP offset (mmHg)\tSEM (mmHg)\n');
num = 1;
HFpEF = [];
HFrEF = [];
control = [];
for i = study_names
    filename = [char(i) '_registered_LVP.txt'];
    fid = fopen(filename, 'r');
    line = fgetl(fid); % Get first line with EDP. 
    line = strsplit(line);
    temp = [];
    for j = 1:length(line)-2
        temp = [temp str2double(line{j+1})];
        EDP = [EDP str2double(line{j+1})];
        if num < 6
            plot(num, str2double(line{j+1})*7.5, 'r.', 'MarkerSize', 20);
            control = [control str2double(line{j+1})];
        elseif num < 17
            plot(num, str2double(line{j+1})*7.5, 'b.', 'MarkerSize', 20);
            HFpEF = [HFpEF str2double(line{j+1})];
        else
            plot(num, str2double(line{j+1})*7.5, 'g.', 'MarkerSize', 20);
            HFrEF = [HFrEF str2double(line{j+1})];
        end
            
    end
    if num < 6
        plot(num, mean(temp)*7.5, 'rs', 'LineWidth', 10);
    elseif num < 17
        plot(num, mean(temp)*7.5, 'bs', 'LineWidth', 10);
    else
        plot(num, mean(temp)*7.5, 'gs', 'LineWidth', 10);
    end
    
    label = cell(1, length(line)-2);
    label(:) = i;
    grp = [grp, label];
    fclose(fid);
    mean_edp = mean(temp*7.5);
    sem_edp = std(temp*7.5)/sqrt(length(temp));
    fprintf(fidw, '%s\t%f\t%f\n', char(i), mean_edp, sem_edp);
    num = num + 1;
end
fclose(fidw);
%boxplot(EDP*7.5, grp);
set(gca, 'XTickLabelRotation', 90);
set(gca, 'XTickLabel', study_names);
set(gca, 'XTick', [1:28]);
set(gca, 'TickLabelInterpreter', 'none');
set(gca, 'fontsize', 16);
ylabel('LV-EDP (kPa)');
title('Offset EDP');
%set(gca, 'linewidth', 2);
print(fig, '-djpeg', 'EDP_offset_scatter_plot');
