%search code to select force profiles based on input signal
tic
clc
clear


a_need= 1.8399;
b_need= 0.17758;
c_need= 0.052573;
d_need= -0.095868;
P_coords_in= [-0.19927, 0.9157];

load('Parameters.mat')


Q=Parameters.Q_coords;

search = find(Q(:,1)>=(P_coords_in-0.001) & Q(:,1) <= (P_coords_in+0.001));

for i_s=1:length(search)
    A_val=table2array(Parameters(search(i_s),"A_vect"));
    B_val=table2array(Parameters(search(i_s),"B_vect"));
    C_val=table2array(Parameters(search(i_s),"C_vect"));
    D_val=table2array(Parameters(search(i_s),"D_vect"));

    amp= table2array(Parameters(search(i_s),"Amplitudes"));
    bias= table2array(Parameters(search(i_s), 'Bias_name'));
    phase= table2array(Parameters(search(i_s), 'Phase_name'));
    Force_profile= [phase, bias, amp];

    if A_val<= a_need+0.01 && A_val>= a_need-0.01 && B_val<= b_need+0.01 && B_val>= b_need-0.01 && C_val<= c_need+0.01 && C_val>= c_need-0.01 && D_val<= d_need+0.01 && D_val>= d_need-0.01
        
        message=["Switch to" Force_profile "force profile"];
        disp(message)

        break
    else
        message=['Not in the ' Force_profile ' condition'];
        disp(message)
    end

end
toc