clear 
clc
close all

addpath('../Desktop/Unconstrained/Scratch_Xb10.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi_b10.0_phi_b11.5707963267948966_theta0_b20.0')

output='output0.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi0.01.5707963267948966_theta0_b20.0';

post='postprocessed0.0_Xb20.135_Zb10.0_Zb2-0.036_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.506676527545_CriLeb10.15_CriLeb20.15_phi0.01.5707963267948966_theta0_b20.0';

dataPre =load(output); 
dataPost =load(post); 


j=1200;%cycle step to start with
n=1250;%cycle step to end with


delta_z=zeros(1,n-j);
delta_x=zeros(1,n-j);

z_velocity=zeros(1,n-j);
x_velocity=zeros(1,n-j);

z_accel=zeros(1,n-j);
x_accel=zeros(1,n-j);


delT= (1./(dataPre.f_b2))./250;

pivot_x= dataPost.x_b2(j:n,126);
pivot_z= dataPost.z_b2(j:n,126);


for i=1:n-j-1


    delta_x(1,i)= pivot_x(i+1)-pivot_x(i); %define delta x
    delta_z(1,i)= pivot_z(i+1)-pivot_z(i); %delta z


    x_velocity(1,i+1)= (2.*delta_x(1,i)./delT)-x_velocity(1,i); %calculate x-velocity
    z_velocity(1,i+1)= (2.*delta_z(1,i)./delT)-z_velocity(1,i); %calculate z-velocity

    x_accel(1,i)= ((x_velocity(1,i+1)-x_velocity(1,i))./delT)./1000; %calculate x-acceleration
    z_accel(1,i)= ((z_velocity(1,i+1)-z_velocity(1,i))./delT)./1000; %calculate z-acceleration
end

%%PLOTS%%

time= linspace(j,n,n-j);
subplot(2,2,1)
plot(time,x_velocity,'Color','b'), grid on
xlabel('time')
ylabel('x-velo')
title('X velo plot')

subplot(2,2,2)
plot(time,z_velocity,'Color','b'), grid on
xlabel('time')
ylabel('z-velo')
title('Z velo plot')

subplot(2,2,3)
plot(x_velocity,z_velocity,'Color','b'), grid on %excludde first data point since it is at zero
xlabel('X-velocity')
ylabel('Z-velocity')
title('X vs Z velocity plot')



%%
time= linspace(j,n,n-j);
subplot(2,2,1)
plot(time,x_velocity,'Color','b'), grid on
hold on
plot(time,x_accel,'Color','r'), grid on
xlabel('time')
ylabel('x-accel')
title('X acceleration plot')

subplot(2,2,2)
plot(time,z_velocity,'Color','b'), grid on
hold on
plot(time,z_accel,'Color','r'), grid on
xlabel('time')
ylabel('z-accel')
title('Z acceleration plot')

subplot(2,2,3)
plot(x_velocity,z_velocity,'Color','b'), grid on %excludde first data point since it is at zero
xlabel('X-velocity')
ylabel('Z-velocity')
title('X vs Z velocity plot')

subplot(2,2,4)
plot(x_accel,z_accel,'Color','r'), grid on %excludde first data point since it is at zero
xlabel('X-accel')
ylabel('Z-accel')
title('X vs Z acceleration plot')
% axis("equal")



