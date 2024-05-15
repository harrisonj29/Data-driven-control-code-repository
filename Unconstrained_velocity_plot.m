clear 
clc
close all

addpath('../Desktop/Unconstrained/Scratch_Xb10.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi_b10.0_phi_b11.5707963267948966_theta0_b20.0')

output='output0.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi0.01.5707963267948966_theta0_b20.0';

post='postprocessed0.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi0.01.5707963267948966_theta0_b20.0';

dataPre =load(output); 
dataPost =load(post); 


j=1;%cycle step to start with
n=1250;%cycle step to end with


z_diff=zeros(1,n-j);
x_diff=zeros(1,n-j);
z_velo_diff= zeros(1,n-j);
x_velo_diff= zeros(1,n-j);

z_velocity=zeros(1,n-j);
x_velocity=zeros(1,n-j);

z_accel=zeros(1,n-j);
x_accel=zeros(1,n-j);

delT= (1./(dataPre.f_b2))./250;

pivot_x= dataPost.x_b2(j:n,126);
pivot_z= dataPost.z_b2(j:n,126);

pivot_x= (pivot_x');
pivot_z= pivot_z';

for i=2:(n-j)

    % X_diff(1,i)= pivot_x(1,i+1)-pivot_x(1,i); %define delta x
    % Z_diff(1,i)= pivot_z(1,i+1)-pivot_z(1,i); %delta z

    x_diff(1,i)= pivot_x(1,i)-pivot_x(1,i-1); %define delta x
    z_diff(1,i)= pivot_z(1,i)-pivot_z(1,i-1); %delta z

    x_velocity(1,i)= x_diff(1,i)./delT; %calculate x-velocity
    z_velocity(1,i)= z_diff(1,i)./delT; %calculate z-velocity

    % i
    % x_velocity(1,i-1)
    % x_velocity(1,i)
    x_velo_diff(1,i)= x_velocity(1,i)-x_velocity(1,i-1);
    z_velo_diff(1, i)= z_velocity(1,i)-z_velocity(1,i-1);

    x_accel(1,i)= (x_velo_diff(1,i)./delT); %calculate x-acceleration
    z_accel(1,i)= (z_velo_diff(1,i)./delT); %calculate z-acceleration

end


pivot_x= (pivot_x(1,3:(n-j)-1));
pivot_z= pivot_z(1,3:(n-j)-1);

x_velocity=(x_velocity(1,3:(n-j)-1));
z_velocity=z_velocity(1,3:(n-j)-1);

x_accel=x_accel(1,3:(n-j)-1);
z_accel=z_accel(1,3:(n-j)-1);


%%PLOTS%%
time= linspace(j,n,(n-j)-3);
subplot(2,2,1)
plot(time,pivot_x,'Color','g'), grid on
hold on
plot(time,x_velocity,'Color','b'), grid on
plot(time,x_accel,'Color','r'), grid on
xlabel('time')
ylabel('x')
title('X position, velocity and acceleration plot')
legend('x position','x velocity','(x accel)/100')

subplot(2,2,2)
plot(time,pivot_z,'Color','g'), grid on
hold on
plot(time,z_velocity,'Color','b'), grid on
plot(time,z_accel,'Color','r'), grid on
xlabel('time')
ylabel('z')
title('z position, velocity and acceleration plot')
legend('z position','z velocity','(z accel)/100')

subplot(2,2,3)
plot(x_velocity,z_velocity,'Color','b'), grid on %excludde first data point since it is at zero
xlabel('X-velo')
ylabel('Z-velo')
title('X vs Z velo plot')

subplot(2,2,4)
plot(x_accel,z_accel,'Color','r'), grid on %excludde first data point since it is at zero
xlabel('X-accel')
ylabel('Z-accel')
title('X vs Z accel plot')
