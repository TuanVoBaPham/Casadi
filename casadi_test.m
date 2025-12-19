import casadi.*
x=SX.sym('w');  % decision variables 
obj=x^2-6*x+13; % cost function
g=[];           % parameters
p=[];           % vector tham so
OPT_variables=x;   % single decision variable
nlp_prob=struct('f',obj,'x',OPT_variables,'g',g,'p',p);
% configure cho solver
opts=struct;    
opts.ipopt.max_iter=100;    % tao 100 vong lap, IOPT se dung khi dat so vong lap
opts.ipopt.print_level=0;   % muc do hien thi thong tin
opts.print_time=0;          % thoi gian tinh toan
opts.ipopt.acceptable_tol=1e-8; % sai so cho phep
opts.ipopt.acceptable_obj_change_tol=1e-6; % nguong thay doi nho nhat cua ham muc tieu
solver=nlpsol('solver','ipopt',nlp_prob,opts);
% configure constraints
args=struct;
args.lbx=-inf;
args.ubx=inf;
args.lbg=-inf;
args.ubg=inf;
args.p=[];
args.x0=-0.5;
sol=solver('x0',args.x0,'lbx',args.lbx,'ubx',args.ubx,'lbg',args.lbg,'ubg',args.ubg,'p',args.p);
x_sol=full(sol.x);  % get the solution
min_value=full(sol.f); % get the value function
disp(x_sol)
disp(min_value)