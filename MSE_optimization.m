import casadi.*
x=[0,45,90,135,180];
y=[667,661,757,871,1210];
line_width=1.5;
fontsize_labels=15;
set(0,'DefaultAxesFontName','Times New Roman')
set(0,'DefaultAxesFontSize',fontsize_labels)
figure(1)
plot(x,y,'*b','linewidth',line_width);
hold
xlabel('x')
ylabel('y')
grid on
m = SX.sym('m'); % decision variable (slope)
c = SX.sym('c'); % decision variable (y-intersection)
obj = 0;
for i = 1:length(x) 
    obj = obj + (y(i)-(m*x(i)+c))^2;
end
g = []; % Optimization constraints 
P = []; % Optimization problem parameters
OPT_variables = [m,c]; % Two decision parameters
nlp_prob = struct('f',obj,'x',OPT_variables,'g',g,'p',P);
opts = struct;
opts.ipopt.max_iter = 1000;
opts.ipopt.print_level = 0;
opts.print_time = 0;
opts.ipopt.tol = 1e-8;
opts.ipopt.acceptable_obj_change_tol = 1e-6;
solver = nlpsol('solver','ipopt',nlp_prob,opts);
args = struct;    % unconstrained optimization
args.lbx = -inf;  % unconstrained optimization
args.ubx = inf;   % unconstrained optimization
args.lbg = -inf;  % unconstrained optimization
args.ubg = inf;   % unconstrained optimization
args.p = [];      % no parametes
args.x0 = [0.5,1];
sol = solver('x0',args.x0,'lbx',args.lbx,'ubx',args.ubx,'lbg',args.lbg,'ubg',args.ubg,'p',args.p);
x_sol = full(sol.x);  % get the solution
min_value = full(sol.f); % get the value function
x_line = 0:1:180;
m_sol = x_sol(1);
c_sol = x_sol(2);
y_line = m_sol*x_line + c_sol;
figure(1)
plot(x_line,y_line,'-k','linewidth',line_width);
hold on
legend('Data points','y=2.88\cdot x + 574')
