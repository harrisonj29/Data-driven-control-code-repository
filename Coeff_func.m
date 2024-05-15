%function to generate coefficients to be implemented into Coeff generator
function [a1,b,c,d,p_avg,Ref_P, Ref_Q] = Coeff_func(data_pre)                    

    y = data_pre.L_b1;
    x = data_pre.T_b1;

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
    a1= sqrt(coeffs(2)+6*(c^2));
    b= sqrt((a1^4)/(4*abs(coeffs(4))));
    d= (2*(b^2)*coeffs(5))/(a1^4);


    n=750;
    chord=data_pre.c_b2;
    z_diff=zeros(1,n);
    angle_rad=zeros(1,n);
    angle_deg=zeros(1,n);
    delT= (1./(data_pre.f_b2))./250;
    j=1;

    % for i=2:n
    %     z_diff(1,i)= data_post.z_b1(i+501,1)-data_post.z_b1(i+500,1);
    %     angle_rad(1,i)= asin(z_diff(1,i)./chord);
    %     angle_deg(1,i)= angle_rad(1,i).* (180./pi);
    %     if i ==n
    %         break
    %     end
    % 
    %     if angle_deg(1,i)>=0 && angle_deg(1,i-1)<0
    %         points(1,j)=i;
    %         j=j+1;
    %     end
    % end
    % 
    % p_avg= sum(points)./(length(points)); %geneate pavg
    % 
    % %make it it the first cycle
    % for i=5
    %     if p_avg>250
    %         p_avg= p_avg-250;
    %     else
    %         break
    %     end
    % end

    p_avg=188; %this P_avg is always 188 since the frequency is fixed, thus there is no need to calcualte it for each point. 
                %Instead we just want to track the corrdinates of 188 for each point

    Ref_P= [x(p_avg),y(p_avg)]; %Coordinates of reference points
    Ref_Q= [x(p_avg+125), y(p_avg+125)]; %Coordinates of the opposite (goal) reference point

    %create fit measure
    B_pred= Phi* coeffs; %calculate predicted y^4 value based on coeffs
    
    fit_measure= norm(B - B_pred)/norm(B); %Percent err(closer to 0 is better, closer to .3 is not good)
    r_matrix= corrcoef(B_pred,B); %r^2 based fit measure
  
end