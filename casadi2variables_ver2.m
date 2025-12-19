import casadi.*

% --- Bước 1: Định nghĩa biến quyết định ---
x = SX.sym('x');   % biến x
y = SX.sym('y');   % biến y

% Gom 2 biến vào vector
vars = [x; y];

% --- Bước 2: Định nghĩa hàm mục tiêu ---
obj = x^2 + y^2 - 4*x - 6*y + 13;
% thêm ràng buộc: x+y=1, x>=0, y>=0

% --- Bước 3: Định nghĩa ràng buộc ---
g = x + y - 1;   % ràng buộc bằng 0

% --- Bước 4: Tạo cấu trúc bài toán NLP ---
nlp_prob = struct('f', obj, 'x', vars, 'g', g, 'p', p);

% --- Bước 5: Cấu hình IPOPT ---
opts = struct;
opts.ipopt.max_iter = 100;
opts.ipopt.print_level = 0;
opts.print_time = 0;
opts.ipopt.acceptable_tol = 1e-8;
opts.ipopt.acceptable_obj_change_tol = 1e-6;

% --- Bước 6: Tạo solver ---
solver = nlpsol('solver', 'ipopt', nlp_prob, opts);

% --- Bước 7: Ràng buộc ---
arg = struct;
args.x0 = [0.5; 0.5];
args.lbx = [0; 0];        % x >= 0, y >= 0
args.ubx = [inf; inf];
args.lbg = 0;             % x + y - 1 = 0  (lower bound = 0)
args.ubg = 0;             % upper bound = 0


% --- Bước 8: Chạy solver ---
sol = solver('x0', args.x0, 'lbx', args.lbx, 'ubx', args.ubx);

% --- Bước 9: Lấy nghiệm ---
x_sol = full(sol.x);      % nghiệm tối ưu [x*, y*]
min_value = full(sol.f);  % giá trị cực tiểu

% --- Hiển thị kết quả ---
disp('Nghiem toi uu [x*, y*] = ');
disp(x_sol);

disp('Gia tri cuc tieu f(x*, y*) = ');
disp(min_value);
