function pcolorECEI(ECEI,n)

figure('position',[ 1013 191 619 696])

pcolor(ECEI.x,ECEI.y,ECEI.pdata(:,:,n));
colorbar;
title(['shot',int2str(ECEI.shot),'  t=',num2str(ECEI.t(n)),'s']);
xlabel('minor radius/cm','fontsize',10);
ylabel('vertical distance/cm','fontsize',10);




end