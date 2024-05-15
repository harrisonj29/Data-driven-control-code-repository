clear
clc

tic

path = '../Desktop/Cluster DataFile/(1.25,0.2)';
file = dir(path);
L=length(file);

%find number of extraneous files in Folder
aux_num = 0;
for i = 1:L
    if strncmp(file(i).name, '.', 1) == 1
        aux_num = aux_num + 1;
    end
end

A_vect=zeros(10,1);
B_vect=zeros(10,1);
C_vect=zeros(10,1);
D_vect=zeros(10,1);

Amplitudes= zeros(10,1);

%Reference_point=zeros(10,1);

P_coords= zeros(10,2);
Q_coords= zeros(10,2);

for idx= aux_num+1:aux_num+4
    n= (idx-(aux_num+1))*5;
    file = dir(path);
    name= file(idx).name
    new_path = append(path,'/',name);
    file= dir(new_path);
    out_name= file(aux_num+1).name;
    % post_name= file(aux_num+2).name;
    output_path = append(new_path,'/',out_name);
    % Post_path = append(new_path,'/',post_name);
   
    out_file= dir(output_path);
    % post_file= dir(Post_path);
    l= length(out_file);
    %find number of extraneous files in outputs
    o_num=0;
    for i = 1:l
        if strncmp(out_file(i).name, '.', 1) == 1
            o_num = o_num + 1;
        end
    end
    
    p_num=0;
    for i = 1:l
        if strncmp(out_file(i).name, '.', 1) == 1
            p_num = p_num + 1;
        end
    end
    
    
    % reuse code for coefficient generation in an output folder
    o_p_diff=p_num-o_num;

    for swim_idx = 1+o_num:l
        data_pre = load(fullfile(out_file(swim_idx).folder,(out_file(swim_idx).name)));
        %data_post = load(fullfile(post_file(swim_idx+o_p_diff).folder,(post_file(swim_idx+o_p_diff).name))); %POST FILES MUST BE SORTED IN THE SAME ORDER AS THE OUTPUTS TO WORK!!
        
        if contains(out_file(swim_idx).name, 'Acb20.217') == 1
            out_file(swim_idx).name
            row_position=1+n;

            [a1,b,c,d,p_avg,Ref_P, Ref_Q] = Coeff_func(data_pre); %call coefficient calculating function 
           
            A_vect(row_position,1)=a1;
            B_vect(row_position,1)=b;
            C_vect(row_position,1)=c;
            D_vect(row_position,1)=d;

            % Reference_point(row_position,1)= p_avg;

            p_coords= num2str(Ref_P);
            p_coords= convertCharsToStrings(p_coords);
            % P_coords1(row_position,1)= p_coords; %string representation of both coords
            P_coords(row_position,1:2)= Ref_P; %two colomn vector of both coords

            q_coords= num2str(Ref_Q);
            q_coords= convertCharsToStrings(q_coords);
            % Q_coords1(row_position,1)= q_coords; %string representation of both coords
            Q_coords(row_position,1:2)= Ref_Q; %two colomn vector of both coords

            Amplitudes(row_position,1)=0.217;

            Name= convertCharsToStrings(name(1:3));
            Phase_name(row_position,1)= Name;

            B_Name= convertCharsToStrings(name(9:12));
            Bias_name(row_position,1)= B_Name;

        elseif contains(out_file(swim_idx).name, 'Acb20.304') == 1
            row_position=2+n;
            
            [a1,b,c,d,p_avg,Ref_P, Ref_Q] = Coeff_func(data_pre); %call coefficient calculating function 
           
            A_vect(row_position,1)=a1;
            B_vect(row_position,1)=b;
            C_vect(row_position,1)=c;
            D_vect(row_position,1)=d;

            % Reference_point(row_position,1)= p_avg;

            p_coords= num2str(Ref_P);
            p_coords= convertCharsToStrings(p_coords);
            % P_coords1(row_position,1)= p_coords; %string representation of both coords
            P_coords(row_position,1:2)= Ref_P; %two colomn vector of both coords

            q_coords= num2str(Ref_Q);
            q_coords= convertCharsToStrings(q_coords);
            % Q_coords1(row_position,1)= q_coords; %string representation of both coords
            Q_coords(row_position,1:2)= Ref_Q; %two colomn vector of both coords
            
            Amplitudes(row_position,1)=0.304;

            Name= convertCharsToStrings(name(1:3));
            Phase_name(row_position,1)= Name;

            B_Name= convertCharsToStrings(name(9:12));
            Bias_name(row_position,1)= B_Name;

        elseif contains(out_file(swim_idx).name, 'Acb20.38') == 1
            row_position= 3+n;
            
            [a1,b,c,d,p_avg,Ref_P, Ref_Q] = Coeff_func(data_pre); %call coefficient calculating function 
           
            A_vect(row_position,1)=a1;
            B_vect(row_position,1)=b;
            C_vect(row_position,1)=c;
            D_vect(row_position,1)=d;

            % Reference_point(row_position,1)= p_avg;

            p_coords= num2str(Ref_P);
            p_coords= convertCharsToStrings(p_coords);
            % P_coords1(row_position,1)= p_coords; %string representation of both coords
            P_coords(row_position,1:2)= Ref_P; %two colomn vector of both coords

            q_coords= num2str(Ref_Q);
            q_coords= convertCharsToStrings(q_coords);
            % Q_coords1(row_position,1)= q_coords; %string representation of both coords
            Q_coords(row_position,1:2)= Ref_Q; %two colomn vector of both coords

            Amplitudes(row_position,1)=0.38;

            Name= convertCharsToStrings(name(1:3));
            Phase_name(row_position,1)= Name;

            B_Name= convertCharsToStrings(name(9:12));
            Bias_name(row_position,1)= B_Name;

        elseif contains(out_file(swim_idx).name, 'Acb20.5066') == 1
            row_position=4+n;
            
            [a1,b,c, d,p_avg] = Coeff_func(data_pre); %call coefficient calculating function 
           
            A_vect(row_position,1)=a1;
            B_vect(row_position,1)=b;
            C_vect(row_position,1)=c;
            D_vect(row_position,1)=d;

            % Reference_point(row_position,1)= p_avg;

            p_coords= num2str(Ref_P);
            p_coords= convertCharsToStrings(p_coords);
            % P_coords1(row_position,1)= p_coords; %string representation of both coords
            P_coords(row_position,1:2)= Ref_P; %two colomn vector of both coords

            q_coords= num2str(Ref_Q);
            q_coords= convertCharsToStrings(q_coords);
            % Q_coords1(row_position,1)= q_coords; %string representation of both coords
            Q_coords(row_position,1:2)= Ref_Q; %two colomn vector of both coords

            Amplitudes(row_position,1)=0.5066;

            Name= convertCharsToStrings(name(1:3));
            Phase_name(row_position,1)= Name;

            B_Name= convertCharsToStrings(name(9:12));
            Bias_name(row_position,1)= B_Name;


        elseif contains(out_file(swim_idx).name, 'Acb20.76') == 1
            row_position=5+n;
            
            [a1,b,c,d,p_avg,Ref_P, Ref_Q] = Coeff_func(data_pre); %call coefficient calculating function 
           
            A_vect(row_position,1)=a1;
            B_vect(row_position,1)=b;
            C_vect(row_position,1)=c;
            D_vect(row_position,1)=d;

            % Reference_point(row_position,1)= p_avg;

            p_coords= num2str(Ref_P);
            p_coords= convertCharsToStrings(p_coords);
            % P_coords1(row_position,1)= p_coords; %string representation of both coords
            P_coords(row_position,1:2)= Ref_P; %two colomn vector of both coords

            q_coords= num2str(Ref_Q);
            q_coords= convertCharsToStrings(q_coords);
            % Q_coords1(row_position,1)= q_coords; %string representation of both coords
            Q_coords(row_position,1:2)= Ref_Q; %two colomn vector of both coords


            Amplitudes(row_position,1)=0.76;  

            Name= convertCharsToStrings(name(1:3));
            Phase_name(row_position,1)= Name;
            
            B_Name= convertCharsToStrings(name(9:12));
            Bias_name(row_position,1)= B_Name;

        end  
    end
end


Parameters= table(Phase_name, Bias_name ,Amplitudes, A_vect,B_vect, C_vect, D_vect,P_coords,Q_coords);
disp(Parameters)
save Parameters Parameters

toc
