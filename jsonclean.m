% 读取 GeoJSON 文件
jsonStr = fileread('POSTFIRE.geojson'); % 读取文件内容
data = jsondecode(jsonStr); % 解析 JSON 数据

% 提取 features
features = data.features;

% 提取 DAMAGE 属性值
damageValues = arrayfun(@(x) string(x.properties.DAMAGE), features, 'UniformOutput', false);

% 将 cell 数组转换为字符串数组
damageValues = [damageValues{:}];

% 获取 DAMAGE 的唯一值
uniqueDamageValues = unique(damageValues);

% 显示结果
disp('DAMAGE 属性的唯一值：');
disp(uniqueDamageValues);