
function  call_dark3Dbar_log()

addpath(genpath('./subFunctions'))

% set plot font and line sizes
fSize = 20;
lSize = 2;

% select color scheme
chartColors1 = rgb('BlueViolet'); 
chartColors2 = rgb('Lavender');

% load and structure data
load fisheriris

numFlowers = 10;
irisL_s = meas(1:numFlowers,1);
irisW_s = meas(1:numFlowers,2);
irisL_p = meas(1:numFlowers,3);
irisW_p = meas(1:numFlowers,4);

% *3D bar plot*

X = [irisW_p, irisL_p, irisW_s, irisL_s];
f1 = figure;
b = bar3(X);
for g = 1:length(b) 
    zdata = b(g).ZData;
    b(g).CData = zdata;
    b(g).FaceColor = 'interp';
    b(g).EdgeColor = 'none';
    b(g).FaceAlpha = 0.70;
end
set(gca, 'XTick', [1 2 3 4])
set(gca, 'XTickLabel', {'petal width' 'petal length' 'sepal width' ...
    'sepal length'})
a1 = get(gca,'XTickLabel');
set(gca,'XTickLabel',a1,'fontsize',fSize)

% % uncomment to assign yTick labels
% set(gca, 'YTick', [1 2 3 4 5 6])
% set(gca, 'YTickLabel', {'Iris 1' 'Iris 2' 'Iris 3' 'Iris 4' 'Iris 5' ...
%     'Iris 6'})

% uncomment to make z-axis log-scale
baseline = 0.001;
for i = 1 : numel(b)
    z = get(b(i), 'ZData');
    z(z == 0) = baseline;
    set(b(i), 'ZData', z)
end
set(gca,'Zscale','log')

ylim([0 numFlowers+1])

zUpper = 6;

% uncomment to make z-axis log-scale
zlim([0.001 zUpper])

% % comment to make z-axis log-scale
% zlim([0 zUpper])
xlabel('feature')
ylabel('observation')
zlabel('distance [cm]')

colors_p = [linspace(chartColors2(1),chartColors1(1),3)', ...
    linspace(chartColors2(2),chartColors1(2),3)', ...
    linspace(chartColors2(3),chartColors1(3),3)'];
% c = hot(10); % can be used to determine color triplets
% J = customcolormap([0 0.5 1], [1 1 1; 1 1 0; 1 0 0]);  
J = customcolormap([0 0.5 1], colors_p);    
c = colorbar;
c.Color = 'w'; % make colorbar text white
caxis([0 zUpper])  % set colorbar range
colormap(J);
% colormap hot % pink

% % comment for to make z-axis log-scale
% set(gca,'ZTick',(0:2:6))

% uncomment for to make z-axis log-scale
% only values affected
set(gca,'ZTick',[0.001 0.01 0.05 zUpper]);
% what will appear in those places
set(gca,'ZTickLabel',[0.001 0.01 0.05 zUpper]); 

set(gca,'linewidth',lSize)
% box on
darkBackground(f1,[0 0 0],[1 1 1])
% get(f3,'Position')
% move right | move up | expand right | expand up
set(gcf, 'Position',  [100, -150, 1600, 850])
% horizontal rotation | vertical rotation 
view(290,30)
hold on
ax = axis;

% x-axis, feature (i.e. petal length, petal width, etc.)
% y-axis, observation (i.e. iris 1, iris 2, etc.)
% z-axis, measurement value (i.e. distance [cm])
% in 'axis' each of the axis ranges are contained in the form,
%   [x0 x1 y0 y1 z0 z1]
% 'plot3' requires two inputs 
% 'plot3(X1 X2, Y1 Y2, Z1 Z2)'

% this is the top, back line facing the feature label
% 'plot3(x1*[1,1], ...' --> means no change in position in x-axis
% '[y0 y1], ...' --> means change in position in y-axis from 'y0' to 'y1'
% '[z1 z1]')' --> means no change in position in z-axis
plot3(ax(2)*[1,1],ax(3:4),ax(6)*[1,1],'w','linewidth',lSize)
% plot3(ax(2)*[1,1],[ax(3) numFlowers+1],ax(6)*[1,1],'w','linewidth',lSize)

% this is the top, back line facing the feature type label
plot3(ax(1:2),ax(4)*[0,0],ax(6)*[1,1],'w','linewidth',lSize)

% this is the side, front line opposing the p-value label
% plot3(ax(2)*[1,1],7*[1,1],ax(5:6),'w','linewidth',lSize)
% uncomment to make z-axis log-scale
plot3(ax(2)*[1,1],ax(4)*[1,1],[0.001 ax(6)],'w','linewidth',lSize)
% plot3(ax(2)*[1,1],ax(4)*[1,1],ax(5:6),'w','linewidth',lSize)

% % comment or adjust to make z-axis log-scale
% hold on
% txtCV0 = num2str(max(irisL_s),'%.1f');
% txtCV1 = num2str(max(irisL_p),'%.1f');
% text(-2.5,0,0,['sepal length_{max} = ' txtCV0, char(10), ...
%     'petal length_{max} = ' txtCV1], 'Color', 'w', 'FontSize', fSize, ...
%     'FontWeight', 'bold','HorizontalAlignment', 'Left')

% to save the figure in darkmode
set(gcf, 'inverthardcopy', 'off') 

end
