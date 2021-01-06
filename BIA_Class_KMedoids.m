%% Code by: Kristina P. Sinaga (kristina.sinaga@binus.edu)
%% Vendor Segmentation

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
    [val, clust] = min(D(rd,:),[],1);
    last = 0;
    while any(clust ~= last)
        [~, ind] = min(D*sparse(1:points_n,clust,1,points_n,cluster_n,points_n),[],1);
        last = clust;
        [val, clust] = min(D(ind,:),[],1);
    end    
    en(itr) = sum(val);
    if en(itr)<thres_kd
        thres_kd=en(itr);
        label=clust;
        index=ind;
        it=itr;
    end    
    
end

for k=1:cluster_n
    ipo{k}=find(clust==k);
    ncc(k)=length(ipo{k});
end

[nc ip]=sort(ncc,'descend');

