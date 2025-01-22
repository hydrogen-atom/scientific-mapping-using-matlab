% 读取 CSV 文件
tbl = readtable('climate_change_dataset.csv');
% 创建一个新的表格对象用于存储清洗后的数据
cleaned_tbl = tbl;

% 填充缺失值
cleaned_tbl = fillmissing(cleaned_tbl,'linear');

% 检测和去除异常值
for i = 1:size(cleaned_tbl,2)
    if isnumeric(cleaned_tbl{:,i})
        column = cleaned_tbl{:,i};
        mean_val = mean(column);
        std_val = std(column);
        lower_limit = mean_val - 3*std_val;
        upper_limit = mean_val + 2*std_val;
        % 找到超出范围的值
        outliers = column < lower_limit | column > upper_limit;
        % 将异常值替换为 NaN
        column(outliers) = NaN;
        % 再次填充异常值所在位置
        column = fillmissing(column,'linear');
        % 将处理后的列重新赋值给新表格
        cleaned_tbl{:,i} = column;
    end
end

% 显示修改后的表格
disp(cleaned_tbl);

% 显示处理后的表格
disp(tbl);