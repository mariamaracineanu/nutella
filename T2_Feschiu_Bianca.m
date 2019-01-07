%Semnal dreptunghiular cu perioada P=40s, numar de coeficienti N=50 si
%durata semnalelor D=7

P = 40; 
D = 7; 
N = 50;
w0 = 2*pi/P;
 
%esantionam semnalul original:
tORG = 0:0.001:D; 
 
%semnalul dreptunghiular original:
xORG = square((2*pi/7)*tORG,1)/7+2; 
 
%esantionam semnalul modificat:
t = 0:0.001:P*7; 
 
%initializam semnalul modificat cu valori nule:
x = zeros(1,length(t)); 
 
 
x(t<=D) = xORG;  %valorile nule sunt inlocuite cu valori din semnalul original
 
figure(1);
 
plot(t,x),title('x(t)');
hold on;
 
for k = -N:N  % suma dupa k
    x1 = xORG;  %x_t e semnalul realizat dupa formula SF data
    x1 = x1 .* exp(-1i*k*w0*tORG);  %inmultirea a doua matrice element cu element
    X(k+N+1) = 0;  %initializare cu valoare nula
    for i = 1:length(tORG)-1
        X(k+N+1) = X(k+N+1) + (tORG(i+1)-tORG(i)) * (x1(i)+x1(i+1))/2; %reconstructia realizata cu ajutorul coeficientilor
    end
end
 
for i = 1:length(t) % suma dupa i
    xFINIT(i) = 0; %initializare cu valoare nula
    for k=-N:N
        xFINIT(i) = xFINIT(i) + (1/P) * X(k+51) * exp(1i*k*w0*t(i));  %reconstructia realizata cu ajutorul coeficientilor
    end
    
end
plot(t,real(xFINIT),'--'); %afisarea semnalului reconstruit cu ajotrul celor N coeficienti
 
figure(2);
v=-50*w0:w0:50*w0;  %vector necesar afisarii spectrului
yy=spline(v/2*pi,abs(X),v);
stem(v/2*pi,abs(X)),title('Spectrul lui x(t)');
hold on
plot(v/2*pi,abs(X),'o',v,yy,':');
