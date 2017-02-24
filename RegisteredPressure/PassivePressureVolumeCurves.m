%% Passive pressure volume curve generation
% This function plots the passive pressure volume curve for all studies in 
% the analysis. 
% Author: ZJW
% Date: 21 Feb 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all
study_names =  {'STF_16', 'STF_17', 'STF_18','STF_19', 'STF_20',  'MR_250250'...
    , 'MR_293293', 'MR_119119', 'MR_054054', 'MR_104104', 'MR_236236', 'MR_269269','MR_087087', ...
    'MR_091091', 'MR_124124', 'MR_126126', 'STF_01', 'STF_02', 'STF_08', 'STF_09', 'STF_13', ...
    'MR_042042', 'STF_10', 'STF_11', 'MR_262262', 'STF_06', 'STF_12', 'MR_160160'};

figure_offset = figure;
hold on
figure_no_offset = figure;
hold on
count = 1;
for i = study_names
    load([char(i), '_mri.mat']);
    load([char(i), '_lvp.mat']);
    if count < 6
        colour = 'r';
    elseif count < 17 
        colour = 'b';
    else 
        colour = 'g';
    end
    style = [colour, '.-'];
    figure(figure_offset);
    h_offset(count) = plot(mri.V([mri.DS:end, mri.ED]), output.LVP_average([mri.DS:end, mri.ED])*7.5,style);
    h_text = text(mri.V(mri.ED), output.LVP_average(mri.ED)*7.5, i);
    set(h_text, 'Interpreter', 'none');
    figure(figure_no_offset);
    h_no_offset(count) = plot(mri.V([mri.DS:end, mri.ED]), output.LVP_no_offset_average([mri.DS:end, mri.ED])*7.5, style);
    h_text = text(mri.V(mri.ED), output.LVP_no_offset_average(mri.ED)*7.5, i);
    set(h_text, 'Interpreter', 'none');
    count = count + 1;
end
figure(figure_offset);
title('Passive pressure volume curve');
ylabel('Pressure (mmHg)');
xlabel('Volume (mL)');
set(gca, 'DefaultTextInterpreter', 'none');
legend(h_offset([1, 6, 17]),  'Control', 'HFpEF', 'HFrEF');

figure(figure_no_offset);
title('Passive pressure volume curve');
ylabel('Pressure (mmHg)');
xlabel('Volume (mL)');
set(gca, 'DefaultTextInterpreter', 'none');
legend(h_no_offset([1, 6, 17]),  'Control', 'HFpEF', 'HFrEF');

print(figure_offset, '-djpeg', 'PassivePressureVolume_offset');
print(figure_no_offset, '-djpeg', 'PassivePressureVolume_no_offset');
