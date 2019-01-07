%Semnal dreptunghiular cu perioada P=40s, numar de coeficienti N=50 si durata semnalelor D=13
 
P = 40; 
D = 13; 
N = 50;
w0 = 2*pi/P;
td = 0:0.001:D; %esantionare semnal original
xd = square((2*pi/13)*td,1)/13+2; %semnal original
t = 0:0.001:P*4; %esantionare semnal modificat
x = zeros(1,length(t)); %initializare semnal modificat cu valori nule
x(t<=D) = xd;
%valorile nule inlocuite cu valori din semnalul original
 
figure(1);
plot(t,x),title('x(t)');
hold on;
for k = -N:N % suma dupa k
    x2 = xd; 
    x2 = x2 .* exp(-1i*k*w0*td); %inmultire element cu element a 2 matrice
    X(k+N+1) = 0; %initializare cu valoare nula
    for i = 1:length(td)-1
        X(k+N+1) = X(k+N+1) + (td(i+1)-td(i)) * (x2(i)+x2(i+1))/2; %reconstructia realizata cu ajutorul coeficientilor
    end
end
 
for i = 1:length(t) % suma dupa i
    xf(i) = 0; %initializare cu valoare nula
    for k=-N:N
        xf(i) = xf(i) + (1/P) * X(k+51) * exp(1i*k*w0*t(i)); 
    end
    
end
plot(t,real(xf),'--'); %afisarea semnalului reconstruit cu ajutorul a N coeficienti
 
 
figure(2);
v1=-50*w0:w0:50*w0; %vector necesar afisarii 
yy=spline(v1/2*pi,abs(X),v1);
stem(v1/2*pi,abs(X)),title('Spectrul lui x(t)');
hold on
plot(v1/2*pi,abs(X),'o',v1,yy,':');
