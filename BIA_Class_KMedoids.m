%% Code by: Kristina P. Sinaga (kristina.sinaga@binus.edu)

clear all;close all;clc

points = xlsread('VendorDat.xlsx');
points_n   = size(points,1);
points_dim = size(points,2);

cluster_n=2;

%% DEFINING INPUT DATA 

points_n   = size(points,1);
points_dim = size(points,2);
% cluster_n =length(unique(label));


D=squareform(pdist(points));

t_max=10;
thres_kd=0.0001;


for itr =1:t_max
    
    rng(10);
    rd=randsample(points_n,cluster_n);
    [val, lab] = min(D(rd,:),[],1);
    last = 0;
    while any(lab ~= last)
        [~, ind] = min(D*sparse(1:points_n,lab,1,points_n,cluster_n,points_n),[],1);
        last = lab;
        [val, lab] = min(D(ind,:),[],1);
    end    
    en(itr) = sum(val);
    if en(itr)<thres_kd
        thres_kd=en(itr);
        label=lab;
        index=ind;
        it=itr;
    end    
    
end

for itr=1:cluster_n
    ipo{itr}=find(lab==itr);
    ncc(itr)=length(ipo{itr});
end

[nc ip]=sort(ncc,'descend');

