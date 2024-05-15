%generates and plots coeffs for one case at a time

clear 
clc
close all

addpath('../Desktop/Cluster Datafile/(1.5, 0.2)/0 Phase shift, -4˚ bias, 0.75hz, at (1.5,0.2)/Scratch_Xb10.0_Xb20.135_Zb10.0_Zb20.018_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.217147083234_CriLeb10.15_CriLeb20.15_phi_b10.0_phi_b10_theta0_b26.213372137099814/')

output='output0.0_Xb20.135_Zb10.0_Zb20.018_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.217147083234_CriLeb10.15_CriLeb20.15_phi0.00_theta0_b26.213372137099814';

post='postprocessed0.0_Xb20.135_Zb10.0_Zb20.018_cb10.09_cb20.09_fb10.75_Acb10.380007395659_fb20.75_Acb20.217147083234_CriLeb10.15_CriLeb20.15_phi0.00_theta0_b26.213372137099814';

dataPre =load(output); 
dataPost =load(post); 


%Load data
y= load(output,'L_b2'); % Loads the Lift data
x= load(output,'T_b2'); % Loads the Thrust data


x=struct2cell(x);
y=struct2cell(y);

x=cell2mat(x);
y=cell2mat(y);

x= x(1,500:1251); %excluding data from the first two cycles (ie. before steady state)
y= y(1,500:1251); %excluding data from the first two cycles (ie. before steady state)



phi_1 = y.^3; %where y is lift force
phi_2 = y.^2; %where y is lift force
phi_3 = y; 
phi_4 = -(x.^2); %where x is the thrust
phi_5 = x;
phi_6 = ones(1,length(x));

% Assemble Phi matrix.  Note that the phi vectors need to be transposed.
Phi = [phi_1' phi_2' phi_3' phi_4' phi_5' phi_6'];

% Apply Pseudoinverse function to solve
B=(y.^4)'; % First create the colomn vector of zeros to complete the equation

coeffs= pinv(Phi)*B;

c= coeffs(1)/4;
%a=sqrt((coeffs(3)-(4*(c^3)))./(-2*c));
a1= sqrt(coeffs(2)+6*(c^2));
b= sqrt((a1^4)/(4*abs(coeffs(4))));
d= (2*(b^2)*coeffs(5))/(a1^4);


%create fit measure
B_pred= Phi* coeffs; %calculate predicted y^4 value based on coeffs

fit_measure= norm(B - B_pred)/norm(B) %Percent err(closer to 0 is better, closer to .3 is not good)
r_matrix= corrcoef(B_pred,B);
fit_v2= r_matrix(1,2) %r^2 based fit measure


%generate reference points
n=750;
chord=dataPre.c_b2;
z_diff=zeros(1,n);
angle_rad=zeros(1,n);
angle_deg=zeros(1,n);
omega=zeros(1,n);

delT= (1./(dataPre.f_b2))./250;


j=1;


for i=2:n
    z_diff(1,i)= dataPost.z_b1(i+501,1)-dataPost.z_b1(i+500,1);

    angle_rad(1,i)= asin(z_diff(1,i)./chord);
    angle_deg(1,i)= angle_rad(1,i).* (180./pi);

    if i ==n
        break
    end
    %omega(1,i)= (angle_rad(1,i)-angle_rad(1,i-1))./delT;
    
    if angle_deg(1,i)>=0 && angle_deg(1,i-1)<0 %&& omega(1,i)<0
        points(1,j)=i;
        j=j+1;
    end
end

p_avg= sum(points)./(length(points));

for i=5
if p_avg>250
    p_avg= p_avg-250;
else
    break
end
end


%simulation data
plot(x,y), grid on
xlim([0,3])
xlabel('Thrust')
ylabel('Lift')
title('Body 2 Lift vs. Thrust')
axis("equal")

hold on
%reference point
plot(x(p_avg),y(p_avg),'*','Color','r')
% plot(x(p_avg+20),y(p_avg+20),'*','Color','b') %just used to see direction of cycle
plot(x(p_avg+125),y(p_avg+125),'*','Color','g')
% plot(x(p_avg+155),y(p_avg+155),'*','Color','y') %just used to see direction of cycle




%Regression curve
t= linspace(-pi,pi);
x1=b.*sin(2.*t)+d;
y1=a1.*cos(t)+c;
plot(x1,y1), grid on



