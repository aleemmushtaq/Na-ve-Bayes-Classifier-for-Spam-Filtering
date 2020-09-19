function  [Accuracy , Pridict_label ,Confusion_matrix]= test_naive(mean_spam,mean_NSpam,var_spam,var_NSpam,prior_spam,prior_NSpam , data , label)
true_pos =0;
false_pos =0;
false_neg = 0;
true_neg = 0;
pridiction=0;
 [row_size,col_size] = size(data);
for Loop_A = 1 :1: row_size
 testing_data = data(Loop_A , :);
 testing_label = label(Loop_A , :);
 for L1=1:1:col_size
         P_Spam(1,L1)=( (1/( (sqrt(2*pi))*(var_spam( L1 )))*exp(-(( testing_data(1,L1) - mean_spam(L1) )^2 ) / (2*( (var_spam(L1))^2 ) ) ) ) );
         P_N_Spam(1,L1)=( (1/( (sqrt(2*pi))*(var_NSpam(L1 )))*exp(-(( testing_data(1,L1) - mean_NSpam(L1) )^2 ) / (2*( (var_NSpam(L1))^2 ) )  )   ) );
 end
 tmp1=1;      
 tmp2=1;
 for L1=1:1:col_size
     tmp1 = tmp1*P_Spam(1,L1);
     tmp2 =tmp2*P_N_Spam(1,L1); 
 end 
 E_S_P = prior_spam*tmp1; 
 E_NS_P = prior_NSpam*tmp2;

 if E_S_P > E_NS_P
     pridiction =1;
 end
 if E_S_P < E_NS_P;
     pridiction =0;
 end
 if E_S_P == E_NS_P;
         pridiction =0;
 end
 Pridict_label(1,Loop_A)=(pridiction); 
%% Table
 if testing_label == 0 && pridiction ==0
     true_neg = true_neg+1;
 end
 if testing_label == 1 && pridiction ==1
     true_pos = true_pos+1;
 end
 if testing_label == 1 && pridiction ==0
     false_neg = false_neg+1;
 end
 if testing_label == 0 && pridiction ==1
     false_pos =false_pos+1;    
 end
end
Confusion_matrix(1,1) =   true_neg;      Confusion_matrix(1,2) = false_pos ;
Confusion_matrix(2,1) =   false_neg ;    Confusion_matrix(2,2) =  true_pos;
Accuracy = 100*((true_neg + true_pos)/(true_neg + true_pos+false_neg +false_pos ));
end