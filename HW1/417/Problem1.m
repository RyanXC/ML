function[]=Problem1()
clear all;
close all;

% Fliping 1000 fair coins.

%1 means Head
%x is the frequency of heads for each coins.
% x = sum(randi([0 1],10,1000))/10;
% 
% c_1 = 1; v_1 = x(1);%c1 is the first coin flipped.
% c_rand = randi([2,1000],1); v_rand = x(c_rand);%c_rand is a coin you choose at random.
% [v_min,c_min] = min(x); %c_min is the coin that had the minimum frequency of heads.
% 
% Now, u should be 1/2
coin_num = 1000; % The number of coins
exp_num = 100000; %The number of experiment

global u v_1 v_rand v_min;

u = 0.5;
N = 10;
for i=1:exp_num
    
    x = sum(randi([0 1],N,coin_num))/N; %x is the frequency of heads for each coins.
    
    c_1 = 1; %c1 is the first coin flipped.
    v_1(i) = x(c_1);
    
    c_rand = randi([1,coin_num],1); %c_rand is a coin you choose at random. 
    v_rand(i) = x(c_rand);
    
    [v_min(i),c_min] = min(x); %c_min is the coin that had the minimum frequency of heads.
end

x_axis = 0:0.1:1;

figure
subplot(2,3,1);
hist(v_1,x_axis);title('distribution of v_1');xlim([-0.05,1.05]);xlabel('frequence');ylabel('times');
subplot(2,3,2);
hist(v_rand,x_axis);title('distribution of v_r_a_n_d');xlim([-0.05,1.05]);xlabel('frequence');ylabel('times');
subplot(2,3,3);
hist(v_min,x_axis);title('distribution of v_m_i_n');xlim([-0.05,1.05]);xlabel('frequence');ylabel('times');

e_range = 0:0.001:0.5;

[P_1,P_rand,P_min] = Hoeffding(e_range);
bound = 2*exp(-2*(e_range.^2)*N);

subplot(2,3,4);
plot(e_range,P_1,'LineWidth',1.5);hold on;plot(e_range,bound,'LineWidth',1.5);title('Hoeffding inequality of v_1');
xlabel('e');ylabel('Value');legend('Probability','Boundary');

subplot(2,3,5);
plot(e_range,P_rand,'LineWidth',1.5);hold on;plot(e_range,bound,'LineWidth',1.5);title('Hoeffding inequality of v_r_a_n_d');
xlabel('e');ylabel('Value');legend('Probability','Boundary');

subplot(2,3,6);
plot(e_range,P_min,'LineWidth',1.5);hold on;plot(e_range,bound,'LineWidth',1.5);title('Hoeffding inequality of v_m_i_n');
xlabel('e');ylabel('Value');legend('Probability','Boundary');

end

function[P1,P2,P3] = Hoeffding(e)
global u v_1 v_rand v_min;
for i=1:length(e)
P1(i) = length(find(abs(v_1 - u)>e(i)))/numel(v_1); %P is the probability of |v-u|>e for v_1
P2(i) = length(find(abs(v_rand - u)>e(i)))/numel(v_rand);
P3(i) = length(find(abs(v_min - u)>e(i)))/numel(v_min);
end
end