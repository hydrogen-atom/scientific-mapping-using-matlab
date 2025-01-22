% 读取 CSV 文件
tbl = readtable('cleaned_climate.csv','Range','A2');

time = tbl{:,2};
% 提取表格中的第 4 列数据，并将其转换为数值数组存储在 avgTemp 中
avgTemp = tbl{:,4};
minTemp = tbl{:,5};
maxTemp = tbl{:,6};
co2 = tbl{:,12};
% 设置颜色

% 绘制草图
Line1 = line(time, avgTemp);
Line2 = line(time,minTemp);
Line3 = line(time,maxTemp);
% 添加坐标轴

Line4 = line(time,co2);

set(Line1, 'LineStyle', '-','LineWidth', 1,  'Color', 'red')
set(Line2, 'LineStyle', '-','LineWidth', 1,  'Color', 'blue')
set(Line3, 'LineStyle', '-','LineWidth', 1,  'Color', 'green')
set(Line4, 'LineStyle', '-','LineWidth', 1,  'Color', 'black')


set(gca, 'Box', 'off', ...                                % 边框
         'LineWidth', 1,...                               % 线宽
         'XGrid', 'off', 'YGrid', 'on', ...               % 网格
         'TickDir', 'out', 'TickLength', [.01 .01], ...   % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...    % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])     % 坐标轴颜色
% 坐标轴刻度调整
set(gca, 'XTick', 0:5:60,  'YTick', -10:5:50,...            % 刻度位置、间隔
         'Xlim' ,[0 60],'Ylim' ,[-10 50], ...                % 坐标轴范围
         'Xticklabel',{0:1:60},...                         % X坐标轴刻度标签
         'Yticklabel',{-10:5:50})                          % Y坐标轴刻度标签
% 设置第一个坐标轴的属性

hXLabel = xlabel('time/(5 months)');
hYLabel = ylabel('temp');
hLegend = legend([Line1,Line2,Line3,Line4],'avgTemp','minTemp','maxTemp','co2');
% 刻度标签字体和字号
set(gca, 'FontName', 'Times', 'FontSize', 9)
% X、Y 轴标签及 Legend 的字体字号 
set([hXLabel, hYLabel], 'FontName',  'Helvetica')
set([hXLabel, hYLabel], 'FontSize', 10)
% 背景颜色
%set(gca,'Color',[.2 .1 .1])


ax2 = axes('Position',get(gca,'Position'),'YAxisLocation','right','Color','none','YLim',[350 450]);
set(ax2, 'XTick', [], 'YTick', 350:25:450,...
        'YColor', 'black', 'YGrid', 'off', 'YTickLabel', 350:25:450);
% 关闭新轴的 x 轴刻度显示
set(ax2, 'XTickLabel', []);
% 将 Line4 与新的 y 轴关联
set(Line4,'Parent',ax2);
% 为新的 y 轴添加标签
ylabel(ax2,'CO2 Level');

