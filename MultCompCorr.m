% Li and Li correction, as well as bonferroni and cheverud
% Written M. Zeineh 2020

% put all of your raw data in the variable all, with each row being an
% subject, and each column a different metric (i.e. ca1 volume, dg volume,
% etc.)

allData=xlsread('LiLiMultCompCorr.xlsx','csv');

% Compute correlation matrix
r=corrcoef(allData);

% Then eigenvalues
e=eig(r);

% Original stata code for the above:
%matrix accum R = ca1 ca23dg subiculum ercprc if (nashsfinalexcluderight  == 0 & nashsfinalexcludeleft==0 ) &nashsbaseline == 1, nocons dev
%matrix R = corr(R)
%matrix eigenvalues r c = R
%matrix list r

%Now from the paper
M=length(e);
V=var(e);
gamma=0.05;
bonferroni=1-(1-gamma)^(1/M);
Meff=1+(M-1)*(1-V/M);
cheverud=1-(1-gamma)^(1/Meff);

% Li+Li
eLi=e;
for i=1:length(eLi)
    eLi(i)=(eLi(i)>=1) + eLi(i) - floor(eLi(i));
end
MeffLi=sum(eLi);
Li=1-(1-gamma)^(1/MeffLi);

%
disp(['For ',num2str(length(e)),' comparisons:']);
disp(['   Bonferroni threshold:', num2str(bonferroni)]);
disp(['   Cheverud threshold:', num2str(cheverud)]);
disp(['   Li threshold:', num2str(Li)]);


