function ind = findNearest(x, desiredVal)
    [m,n] = size(x);   %%%% ��ȷ��x�Ĵ�С
    erro = abs(x(:)-desiredVal);  %%%% �������ֵ��������Ҫ����һά����
    min_e = min(erro);  %%%% �ҵ���С���
    temp = reshape(erro,m,n);  %%%%% ��һά�����ָ��ɾ���
    [a,b] = find(temp==min_e);  %%%%% �ҵ���С����Ӧ���±�
    ind = [a b];  %%%% ���� a Ϊ�±���У�b Ϊ�±��е���

end