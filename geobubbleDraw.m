% 读取 GeoJSON 文件
jsonStr = fileread('POSTFIRE.geojson'); % 读取文件内容
data = jsondecode(jsonStr); % 解析 JSON 数据

% 提取 features
features = data.features;

% 初始化经纬度数组
lats = zeros(length(features), 1); % 纬度
lons = zeros(length(features), 1); % 经度

% 遍历 features，提取 Latitude 和 Longitude
for i = 1:length(features)
    lats(i) = features(i).properties.Latitude; % 提取纬度
    lons(i) = features(i).properties.Longitude; % 提取经度
end

% 过滤掉超出范围的纬度值
validIdx = lats >= -90 & lats <= 90; % 有效的纬度索引
lats = lats(validIdx); % 过滤后的纬度
lons = lons(validIdx); % 过滤后的经度
features = features(validIdx); % 过滤后的 features

% 提取 DAMAGE 属性值
damageValues = arrayfun(@(x) string(x.properties.DAMAGE), features, 'UniformOutput', false);
damageValues = [damageValues{:}]; % 将 cell 数组转换为字符串数组

% 将 DAMAGE 值转换为分类变量
damageCategories = categorical(damageValues);

% 定义颜色映射
colors = lines(numel(categories(damageCategories))); % 使用 lines 颜色映射，生成与分类数量相同的颜色

% 创建地理气泡图
figure;
g = geobubble(lats, lons, ones(size(lats)), damageCategories, 'Title', 'The California Wildfire '); % 设置颜色变量

% 设置气泡颜色
g.BubbleColorList = colors; % 设置颜色列表

% 自定义气泡大小范围（固定大小）
g.BubbleWidthRange = [5, 5]; % 气泡大小固定为 5

% 设置地图底图
geobasemap('streets');

% 添加图例
legendLabels = categories(damageCategories); % 获取分类标签
legendColors = colors; % 提取颜色

% 在当前图窗中添加图例
hold on;
for i = 1:length(legendLabels)
    % 绘制不同颜色的点（不可见，仅用于图例）
    scatter(nan, nan, 100, legendColors(i, :), 'filled', 'DisplayName', legendLabels(i));
end
hold off;

% 显示图例
legend('show', 'Location', 'northeastoutside');
title('Damage Level Legend'); % 图例标题
