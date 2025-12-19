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