clear;clc;
load('demo_data.mat'); load('mask_ref.mat'); load('mask_seq.mat');

  
[N1, N2, T] = size(demo_data);
u_T_groundtruth_all = demo_data;
 
t0 = 1;
u0_gt = u_T_groundtruth_all(:, :, t0);

sig0 = 2;
Fu0 = MRI_forward_centered(u0_gt,sampling_mask_u0);
Fu0 = Fu0 + sig0*(randn(size(Fu0))+1i* randn(size(Fu0)));
lambda = 1.1; alpha1 = 1 ; alpha0 = 3;
sigma = 0.21; tau = 0.21; 

[u0_star, ~] = MRI_reconstruction_TGV([N1, N2], Fu0, sampling_mask_u0, ...
    lambda, alpha0, alpha1, sigma, tau);

rec_u0_matrix = reshape(u0_star, N1, N2);

 

u_T_groundtruth_seq = u_T_groundtruth_all;
u_T_groundtruth_seq(:, :, t0) = [];
 
sig = 2;
f_seq = cell(T-1,1);
for t=1:T-1
f_seq{t} = MRI_forward_centered(u_T_groundtruth_seq(:,:,t),sampling_mask_seq(:,:,t));
f_seq{t} = f_seq{t} +sig*(randn(size(f_seq{t}))+1i*randn(size(f_seq{t})) );
end
u0 = repmat(abs(u0_star), [1, T]);
u0(:, t0) = [];  
 
u_initial = zeros(N1 * N2, T - 1);
for t = 1:T-1
    u_initial(:, t) = MRI_backward_centered(f_seq{t}, sampling_mask_seq(:, :, t));
end
 
eta = 2; sigma = 0.1; tau = 0.1; alpha = 10;
beta =1; A = [3, 1]; gma = 0.5 ;

u_rec = DMRI_rec(u0, u_initial, f_seq, sampling_mask_seq, eta, sigma, tau, alpha, beta, gma, A);



 
