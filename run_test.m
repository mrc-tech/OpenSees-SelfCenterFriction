close all
clear
clc

% run the OpenSEES script
% (OpenSEES binary must be present in the PATH)
!OpenSEES test_material.tcl

disp = load('_disp.out');  % displacements of control node
data = load('_force.out'); % forces inside the element

plot(disp(:,1),data(:,4), 'k', 'linewidth',2);

grid on; grid minor;
xlabel('u');
ylabel('F');
xline(0); yline(0);

