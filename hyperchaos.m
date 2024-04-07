function K=hyperchaos(key_array,hw)


K=zeros(hw,6);
a=0.3;b=1.5;c=8.5;d=-2;d1=0.9;e=1;f=-0.1;r=1;alp=1;beta=0.2;k=0;
K(1,:)=key_array;

h=0.005;
    for i=1:hw-1
        k1=d1*(alp+beta*K(i,6)^2)*K(i,2)-a*K(i,1);
        k2=d1*(alp+beta*(K(i,6)+h/2*k1)^2)*(K(i,2)+h/2*k1)-a*(K(i,1)+h/2*k1);
        k3=d1*(alp+beta*(K(i,6)+h/2*k2)^2)*(K(i,2)+h/2*k2)-a*(K(i,1)+h/2*k2);
        k4=d1*(alp+beta*(K(i,6)+h*k3)^2)*(K(i,2)+h*k3)-a*(K(i,1)+h*k3);
        K(i+1,1)=K(i,1)+h/6*(k1+2*k2+2*k3+k4);
        
        L1=d*K(i,2)+c*K(i,1)-K(i,1)*K(i,3)+K(i,5);
        L2=d*(K(i,2)+h/2*L1)+c*(K(i,1)+h/2*L1)-(K(i,1)+h/2*L1)*(K(i,3)+h/2*L1)+(K(i,5)+h/2*L1);
        L3=d*(K(i,2)+h/2*L2)+c*(K(i,1)+h/2*L2)-(K(i,1)+h/2*L2)*(K(i,3)+h/2*L2)+(K(i,5)+h/2*L2);
        L4=d*(K(i,2)+h*L3)+c*(K(i,1)+h*L3)-(K(i,1)+h*L3)*(K(i,3)+h*L3)+(K(i,5)+h*L3);
        K(i+1,2)=K(i,2)+h/6*(L1+2*L2+2*L3+L4);
        
        M1=-b*K(i,3)+K(i,1)^2;
        M2=-b*(K(i,3)+h/2*M1)+(K(i,1)+h/2*M1)^2;
        M3=-b*(K(i,3)+h/2*M2)+(K(i,1)+h/2*M2)^2;
        M4=-b*(K(i,3)+h*M3)+(K(i,1)+h*M3)^2;
        K(i+1,3)=K(i,3)+h/6*(M1+2*M2+2*M3+M4);
        
        N1=e*K(i,2)+f*K(i,4);
        N2=e*(K(i,2)+h/2*N1)+f*(K(i,4)+h/2*N1);
        N3=e*(K(i,2)+h/2*N2)+f*(K(i,4)+h/2*N2);
        N4=e*(K(i,2)+h*N3)+f*(K(i,4)+h*N3);
        K(i+1,4)=K(i,4)+h/6*(N1+2*N2+2*N3+N4);
        
        F1=-r*K(i,1)-k*K(i,5);
        F2=-r*(K(i,1)+h/2*F1)-k*(K(i,5)+h/2*F1);
        F3=-r*(K(i,1)+h/2*F2)-k*(K(i,5)+h/2*F2);
        F4=-r*(K(i,1)+h*F3)-k*(K(i,5)+h*F3);
        K(i+1,5)=K(i,5)+h/6*(F1+2*F2+2*F3+F4);
        
        T1=K(i,2);
        T2=K(i,2)+h/2*T1;
        T3=K(i,2)+h/2*T2;
        T4=K(i,2)+h*T3;
        K(i+1,6)=K(i,6)+h/6*(T1+2*T2+2*T3+T4);
        
    end


    
    
