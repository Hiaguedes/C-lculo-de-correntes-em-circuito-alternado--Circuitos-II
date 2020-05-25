%------------------------------------------------
%            Trabalho Circuitos II
%                   Grupo 6
%         Hiago Riba Guedes 11620104
%         Luis Felipe Ferreira 11511340
%         Diego Claudino Palmeiras 11310238
%         Handerson Luiz Saggioro 11410564
%         Hellisson Antonio Cordeiro 11410524
%------------------------------------------------
clear all;
clc;

f=input("Informe a frequencia [Hz]\n");
w=2*pi*f;
h=input("Quantas malhas tera o circuito?\n");
K=zeros(h);
F=zeros(h,1);

%Selecionando fontes-----------------------------------------------
printf('---------------------------------------');
printf("\nSerao selecionados agora as fontes\n");
printf('---------------------------------------\n');
op=input("Fonte de corrente ou de tensao? t ou c \n Aperte s pra sair da seleçao \n",'s');
nI=0;
nV=0;

while (op == ('corrente') || op == ('c') || op ==('CORRENTE')||op==('tensao') || op==("t") || op==('TENSAO'))
%------------------------Fontes de corrente-----------------------------------------------------------------
if (op == ('corrente') || op == ('c') || op ==('CORRENTE'))
Mod=input("Insira o modulo da corrente\n");
Ang=input("Insira o angulo de fase [em graus]\n");
Ang=(pi/180)*Ang;
a=Mod*cos(Ang);
b=Mod*sin(Ang);

po=input("Componente esta entre duas malhas? S ou N",'s');
if (po==('S')||po==('s'))
  n=input("Informe a primeira malha\n");
  m=input("Informe a segunda malha\n");
  if(n>h || m>h);
  printf('Erro: componente nao pode estar numa malha maior que a estabelecida inicialmente');
  endif
  P=sort([n,m]);
  n=P(1);
  m=P(2);
  F(n)=F(n)-(a+b*i);
  F(m)=F(m)+(a+b*i);
endif
  
 if (po==('N')||po==('n'))
  n=input("Informe a malha\n");
  %I(n)=F(n);
endif
nI=nI+1;
I(nI)= a + b*i;
op=input("Mais fontes de corrente? c \n Aperte s pra sair da selecao \n",'s');
if(op==('t')||op==('tensao')|| op==('TENSAO'))
op=input("Incorreto: Informe se quer mais fontes de corrente ou se deseja sair\n c ou s",'s');
endif 

%--------------------Fontes de tensao--------------------------------------------------------------------
elseif (op==('tensao') || op==("t") || op==('TENSAO'))
Mod=input("Insira o modulo da tensao\n");
Ang=input("Insira o angulo de fase [em graus]\n");
Ang=(pi/180)*Ang;
a=Mod*cos(Ang);
b=Mod*sin(Ang);

po=input("Componente esta entre duas malhas? S ou N\n",'s');
if (po==('S')||po==('s'))
  n=input("Informe a primeira malha\n");
  m=input("Informe a segunda malha\n ");
  if((n>h) || (m>h));
  printf('Erro: componente nao pode estar numa malha maior que a estabelecida inicialmente\n');
  endif
  P=sort([n,m]);
  n=P(1);
  m=P(2);
  F(n)=F(n)-(a+b*i);
  F(m)=F(m)+(a+b*i);
endif
 if (po==('N')||po==('n'))
  n=input('Informe a malha');
  F(n)=F(n)+a+b*i;
endif
nV=nV+1;
V(nV)= a + b*i;
op=input("Deseja mais fontes de tensao? Digite t \n Aperte s pra sair da seleçao \n",'s');
if (op == ('corrente') || op == ('c') || op ==('CORRENTE'))
  op=input("Incorreto: Informe se quer mais fontes de tensao ou se deseja sair\n t ou s",'s');
endif 
elseif(op==('s'))
printf('Saindo da selecao das fontes');
else 
printf("Incorreto\n");
endif
endwhile 
%-------------------------------------------------------------------
%Selecionando resistores--------------------------------------------
printf('---------------------------------------');
printf("\nSerao selecionados agora os resistores\n");
printf('---------------------------------------\n');
t=input("Tera resistores? S ou N\n",'s');
nR=0;

if (t==('N') ||t==('n'))
printf("nao serao colocados mais resistores \n");
endif 
while(t==('S')||t==('s'))
nR=nR+1;
R(nR)=input("Qual o valor?\n");

po=input("Componente esta entre duas malhas? S ou N\n",'s');
if (po==('S')||po==('s'))
n=input("Informe a primeira malha\n ");
  m=input("Informe a segunda malha\n");
  if(n>h || m>h)
  printf('Erro: componente nao pode estar numa malha maior que a estabelecida inicialmente');
  endif
  P=sort([n,m]);
  n=P(1);
  m=P(2);
  K(n,m)=K(m,n)=K(n,m)-R(nR);
   K(n,n)=K(n,n)+R(nR);
  K(m,m)=K(m,m)+R(nR);
  elseif (po==('n')||po==('N'))
  n=input("Informe a malha\n");
 K(n,n)=K(n,n)+R(nR);
  endif 
  
t=input("Tera mais resistores? S ou N\n",'s');
endwhile
%--------------------------------------------------------------------
%Selecionando capacitores--------------------------------------------
printf('---------------------------------------');
printf("\nSerao selecionados agora os capacitores\n");
printf("---------------------------------------\n");
t1=input("Tera capacitores? S ou N\n",'s');
nC=0;

if (t1==('N') ||t1==('n'))
printf("nao serao colocados mais capacitores \n");
endif 
while(t1==('S')||t1==('s'))
nC=nC+1;
C(nC)=input("Qual o valor?\n");
XC(nC)=-i/(w.*C(nC));

po=input("Componente esta entre duas malhas? S ou N \n",'s');

if (po==('S')||po==('s'))
n=input('Informe a primeira malha\n ');
  m=input('Informe a segunda malha\n ');
  if(n>h || m>h)
  printf('Erro: componente nao pode estar numa malha maior que a estabelecida inicialmente');
  endif
  P=sort([n,m]);
  n=P(1);
  m=P(2);
  K(n,m)=K(m,n)=K(n,m)-XC(nC);
  K(n,n)=K(n,n)+XC(nC);
  K(m,m)=K(m,m)+XC(nC);
  elseif (po==('n')||po==('N'))
  n=input("Informe a malha\n");
 K(n,n)=K(n,n)+XC(nC);
  endif 
t1=input("Tera mais capacitores? S ou N\n",'s');
endwhile 
%--------------------------------------------------------------------
%Selecionando indutores----------------------------------------------
printf('---------------------------------------');
printf("\nSerao selecionados agora os indutores\n");
printf('---------------------------------------\n');
t2=input("Tera indutores? S ou N\n",'s');
nL=0;
if (t2==('N') ||t2==('n'))
printf("nao serao colocados mais indutores \n");
endif 
while(t2==('S')||t2==('s'))
nL=nL+1;
L(nL)=input("Qual o valor?\n");
XL(nL)=i*w.*L(nL);

po=input("Componente esta entre duas malhas? S ou N",'s');

if (po==('S')||po==('s'))
n=input("Informe a primeira malha\n");
  m=input("Informe a segunda malha\n");
  if(n>h || m>h)
  printf('Erro: componente nao pode estar numa malha maior que a estabelecida inicialmente');
  po=input("Componente esta entre duas malhas? S ou N");
endif

  P=sort([n,m]);
  n=P(1);
  m=P(2);
  K(n,m)=K(m,n)=K(n,m)-XL(nL);
  K(n,n)=K(n,n)+XL(nL);
  K(m,m)=K(m,m)+XL(nL);
   %K(n,n)=K(n,n)+XL(nL);
  elseif (po==('N')||po==('n'))
  n=input("Informe a malha\n");
  K(n,n)=K(n,n)+XL(nL);
  
  endif 

t2=input("Tera mais indutores? S ou N\n",'s');
endwhile

%Componentes Selecionados---------------------------------------------
printf("Voce selecionou %i resistores,%i capacitores e %i indutores\n",nR,nC,nL);
for(x=1:nV)
printf(" V(%i)=%.3f + %.3fi V |",x,real(V(x)),imag(V(x)));
endfor
printf('\n');
for(x=1:nI)
printf(" I(%i)=%.3f +%.3fi A |",x,real(I(x)),imag(I(x)));
endfor 
printf('\n');
for(x=1:nR)
printf("  R(%i)=%.2f ohms |",x,R(x));
endfor
printf('\n');
for(x=1:nC)
printf(" C(%i)=%.8f F |",x,C(x));
endfor
printf('\n');
for(x=1:nL)
printf(" L(%i)=%.2f H |",x,L(x));
endfor
%---------------------------------------------------------------------
%Imprimindo resultados------------------------------------------------
I=inv(K)*F;
printf('\n');
printf('-------------------------------------');
printf("\nResultado das correntes nas malhas\n");
printf('-------------------------------------\n');
for(x=1:h)
%printf("I(%i)=%.7f + %.7fi  A\n",x,real(I(x)),imag(I(x)));
printf("I(%i)=%.7f A < %.7f ° \n",x,abs(I(x)),(pi\180)*angle(I(x)) );
endfor 
