%training function of naive base classifier
function [mean_spam,mean_NSpam,var_spam,var_NSpam,prior_spam,prior_NSpam]=train_naive(Data,Labels)

data=Data;
data_labels=Labels;
[rows,column]=size(data);
sp_sum=0;
 
 count=0;

  count1=0;
  N_sp_sum=0;
  spp_sum=0;
   N_spp_sum=0;
for i=1:1:column
    for j=1:rows
        if(data_labels(j,1)==1)
            count=count+1;
       sp_sum=sp_sum+data(j,i);
        
        end
        if(data_labels(j,1)==0)
            count1=count1+1;
            N_sp_sum= N_sp_sum+data(j,i);
          
           
        end
        
       
    end
    mean_spam(i)=sp_sum/count;
    mean_NSpam(i)=N_sp_sum/count1;
     count=0;
    count1=0;
    N_sp_sum=0;
    sp_sum=0;
end

for i=1:1:column
    for j=1:rows
        if(data_labels(j,1)==1)
            count=count+1;
       spp_sum=spp_sum+(data(j,i)-mean_spam(i))^2;
        
        end
        if(data_labels(j,1)==0)
            count1=count1+1;
            N_spp_sum= N_spp_sum+(data(j,i)-mean_NSpam(i))^2;
          
           
        end
        
       
    end
     var_spam(i)=spp_sum/count;
    var_NSpam(i)=N_spp_sum/count1;
    count=0;
    count1=0;
     N_spp_sum=0;
      spp_sum=0;
end
countspam=0;
countnspam=0;
for k=1:rows
    if(Labels(k)==1)
        countspam=countspam+1;
    else
        countnspam=countnspam+1;
    end
end
prior_spam=countspam/(countspam+countnspam);
prior_NSpam=countnspam/(countspam+countnspam);

end