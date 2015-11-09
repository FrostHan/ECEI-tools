function ind = findNearest(x, desiredVal)
    [m,n] = size(x);   %%%% 先确定x的大小
    erro = abs(x(:)-desiredVal);  %%%% 计算误差值，矩阵需要拉成一维向量
    min_e = min(erro);  %%%% 找到最小误差
    temp = reshape(erro,m,n);  %%%%% 将一维向量恢复成矩阵
    [a,b] = find(temp==min_e);  %%%%% 找到最小误差对应的下标
    ind = [a b];  %%%% 返回 a 为下标的行，b 为下标中的列

end