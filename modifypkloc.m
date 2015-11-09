function pkloc2=modifypkloc(pkloc,sawtoothlength)

pkloc2=pkloc;
for i=1:floor((length(pkloc)-1)/1.4)
    ll=pkloc(i+1)-pkloc(i);
    nn=floor(ll/sawtoothlength(2)+1);
    if nn>1
        for j=1:nn-1
        newloc(j)=pkloc(i)+floor(ll/nn)*j;
        end
        pkloc2=[pkloc2,newloc];
    end
end
    pkloc2=sort(pkloc2,'ascend');
end
