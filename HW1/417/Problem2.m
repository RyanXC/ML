
exp_num = 1000; %exp_num:the number of experiments.
iteration = zeros(1,exp_num); %array stored iterations of each learning.
dim = 10; %Dimentions of weight vector.

tra = struct('flag',{},'flagtep',{},'status',{},'value',zeros(1,dim+1));
%flag is the real flag of the point. flag = 1 means the value w*x>t;
%flag is a temporary flag used to determine whether this point is
%classified right or not.
%status means whether this point is classified correctly. 
%If flagtep == flag, status =1. 
%value means x, x0 = 1.

for j = 1: exp_num

w_start= zeros(1,dim+1);
w_start(2:(dim+1)) = rand(1,dim);

%If threshold is equal to 0, use > instead of >=

for i=1:100
tra(i).value(1) = 1;
tra(i).value(2:(dim+1)) = -1+2*rand(1,dim);
tra(i).flag = tra(i).value * w_start'> -w_start(1);
end

w = zeros(1,dim+1); %First weight vector.
t = 0; %The times of uapdating

for i=1:100

tra(i).flagtep = (tra(i).value * w' > -w(1));

% Determine whether this point is classified correctly.
tra(i).status = (tra(i).flag == tra(i).flagtep);

% If find a misclassified point. Then update the w
if tra(i).status == 1
    continue
end

% Update w
    tra(i).status = 1;
    w = w + tra(i).flag * tra(i).value;
    t = t+1;

end

iteration(j) = t;

end

hist(iteration);