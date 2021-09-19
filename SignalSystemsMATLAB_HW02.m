%% Problem 1

%% Part 1
clear;clc

% definig symbolic functions
syms t;
f1 = 5*exp(-5*t);
f2 = 5*t*exp(-5*t);
f3 = t*sin(2*t)+exp(-2*t);
f4 = 5*t^2*exp(-5*t);

% calculating Laplace
F1 = laplace(f1);
F2 = laplace(f2);
F3 = laplace(f3);
F4 = laplace(f4);

% Showing answers
pretty(F1)
pretty(F2)
pretty(F3)
pretty(F4)

%% Part 2
clear;clc

% definig symbolic Laplace functions
syms s;
F1 = 28/(s*(s+8));
F2 = (s-5)/(s*(s+2)^2);
F3 = 10/((s+1)^2*(s+3));
F4 = 2*(s+1)/(s*(s^2+s+2));

% calculating iLaplace
f1 = ilaplace(F1);
f2 = ilaplace(F2);
f3 = ilaplace(F3);
f4 = ilaplace(F4);

% Showing answers
pretty(f1)
pretty(f2)
pretty(f3)
pretty(f4)

%% Part 3
clear;clc

% defining laplace transfer function
sys = tf(25,[1 4 25])

% Ploting
subplot(2,2,1)
impulse(sys)
subplot(2,2,3)
step(sys)
subplot(2,2,[2,4])
bodeplot(sys)

%% Problem 2

%% Part 1,2,3
clear; clc

H1 = tf(1,[1,20,10,400]);
H2 = tf(1,[1,12.5,10,10,1]);
H3 = tf(1,[1,5,125,100,100,20,10]);
H4 = tf(1,[1,125,100,100,20,10]);

% Plotting Step Response
figure(2)
subplot(2,2,1)
step(H1);
title('Step Response of H1(s)');

subplot(2,2,2)
step(H2);
title('Step Response of H2(s)');

subplot(2,2,3)
step(H3);
title('Step Response of H3(s)');

subplot(2,2,4)
step(H4);
title('Step Response of H4(s)');

% Plotting Poles
figure(1)
subplot(2,2,1)
pzplot(H1);
title('Pole-Zero Map H1(s)');

subplot(2,2,2)
pzplot(H2);
title('Pole-Zero Map H2(s)');

subplot(2,2,3)
pzplot(H3);
title('Pole-Zero Map H3(s)');

subplot(2,2,4)
pzplot(H4);
title('Pole-Zero Map H4(s)');

% Ploting pulse response of H3 & H4
figure(3)
impulse(H3)
hold on
impulse(H4)
legend('impulse of H3','impulse of H4')

% displaying properties of signals in command window
disp('Properties Of H1');
damp(H1)
disp(' ');
disp('Properties Of H2');
damp(H2)
disp(' ');
disp('Properties Of H3');
damp(H3)
disp(' ');
disp('Properties Of H4');
damp(H4)

%% Part 4
clear;clc

G = tf([1 1],[1 5 6]);

% defining symbolic inputs
syms t
x1(t) = dirac(t)';
x2(t) = heaviside(t);
x3(t) = sin(2*t)*heaviside(t);
x4(t) = exp(-t)*heaviside(t);

% Way 1 : first calculating Laplace of x(t) and then find answer using
% impulse answer of X*G system

% showing Laplace
X1 = laplace(x1)
X2 = laplace(x2)
X3 = laplace(x3)
X4 = laplace(x4)

X1 = tf(1,1);
X2 = tf(1,[1,0]);
X3 = tf(2,[1,0,4]);
X4 = tf(1,[1,1]);

% Plotting Responses
figure(1)
subplot(2,2,1)
impulse(G*X1);
title('Response for x1(t)');

subplot(2,2,2)
impulse(G*X2);
title('Response for x2(t)');

subplot(2,2,3)
impulse(G*X3);
title('Response for x3(t)');

subplot(2,2,4)
impulse(G*X4);
title('Response for x4(t)');

% Way 2 (extra) : first we find impulse answer function of G using ilaplace
% function and then convolve them with inputs to find output

syms s r
G = (s+1)/(s^2+5*s+6);
g(t) = ilaplace(G)
g(t) = g(t)*heaviside(t);

% calculating convolution of g(t) and x(t)
y1(t) = int(g(r)*x1(t-r),r,-inf,inf)
y2(t) = int(g(r)*x2(t-r),r,-inf,inf)
y3(t) = int(g(r)*x3(t-r),r,-inf,inf)
y4(t) = int(g(r)*x4(t-r),r,-inf,inf)

% Plotting calculated y answers
figure(2)
subplot(2,2,1)
fplot(y1,[0 5]);
ylim([-0.5 1])
title('Plot of y1(t) = h(t)*x1(t)');

subplot(2,2,2)
fplot(y2,[0 5]);
ylim([0 0.3])
title('Plot of y2(t) = h(t)*x2(t)');

subplot(2,2,3)
fplot(y3,[0 150]);
ylim([-0.4 0.4])
title('Plot of y3(t) = h(t)*x3(t)');

subplot(2,2,4)
fplot(y4,[0 6]);
ylim([0 0.15])
title('Plot of y4(t) = h(t)*x4(t)');

%% Part 5
clear;clc

G = tf([10,4],[1,4,4]);

t = (0:0.0001:10)';
step(G,t)
y = step(G,t);

final_value = y(length(y))
max_value = max(y)
t_max_value = find(y==max_value)*0.0001
t_first_time_further_half_of_final_value = find(y>final_value/2, 1 )*0.0001

%% Problem 3
clear;clc
H_part1 = tf(1,[1,1,-2]);

figure(1)
pzplot(H_part1)
title('Pole Zero Map H(part1)');
disp('Properties Of H_part1');
damp(H_part1)

H_part2 = feedback(H_part1,1);

figure(2)
pzplot(H_part2)
title('Pole Zero Map H(part2)');
disp('Properties Of H_part2');
damp(H_part2)

figure(3)
for k = -10:2:10
H_part3 = feedback(H_part1*k,1);
pzplot(H_part3)
hold on
title(['Pole Zero Map H(part3) k = ',num2str(k)]);
xlim([-5 5])
ylim([-5 5])
pause(0.5);
end

figure(4)
rlocus(H_part1);


%% Problem 4
% simulink