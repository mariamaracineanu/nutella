%Semnal triunghiular cu Perioada P = 40 s, Durata semnalelor D = 4 si Numar de coeficienti = 50

P = 40; 
D = 4; 
N = 50;
%pulsatia semnalului:
w0 = 2*pi/P; 
%esantionarea semnalului original:
tr = 0:0.02:D; 
%semnalul triunghiular original:
xr = sawtooth((pi)*tr,0.5)+0.5;
%esantionarea semnalului modificat:
t = 0:0.02:P/6;
x = zeros(1,length(t)); 
x(t<=D) = xr; 
figure(1);
plot(t,x),title('x(t)'); 
hold on;


for k = -N:N 
    x2 = xr; %x2 e semnalul realizat dupa formula SF data
    x2 = x2 .* exp(-1i*k*w0*tr); %inmultire element cu element a doua matrice
    X(k+N+1) = 0; 
    for i = 1:length(tr)-1
        X(k+N+1) = X(k+N+1) + (tr(i+1)-tr(i)) * (x2(i)+x2(i+1))/2; %reconstructia folosind coeficientii
    end
end

for i = 1:length(t) 
    xf(i) = 0; 
    for k=-N:N
        xf(i) = xf(i) + (1/P) * X(k+51) * exp(1i*k*w0*t(i));  %reconstructia folosind coeficientii
    end
end
%afisare reconstructie semnal folosind N coeficienti:
plot(t,xf,'--'); 

figure(2);
w=-50*w0:w0:50*w0; %w este vectorul ce ne va permite afisarea spectrului functiei
stem(w/(2*pi),abs(X)),title('Spectrul lui x(t)'); %afisarea spectrului
