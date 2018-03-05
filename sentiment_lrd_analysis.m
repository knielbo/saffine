
clf;clc;close all;clear all

x1 =load('senti_vectors/Dorian_Grey.txt');
x2 =csvread('senti_vectors/Gone_Girl.txt');
x3 =csvread('senti_vectors/Madame_Bovary.txt');
x4 =csvread('senti_vectors/pamela.txt');  % 2 scaling
x5 =csvread('senti_vectors/Portrait_of_the_Artist.txt');
x6 =csvread('senti_vectors/Pride_and_Prejudice.txt');
x7 =csvread('senti_vectors/Romeo_and_Juliet.txt');
x8 =csvread('senti_vectors/The_Da_Vinci_Code.txt');
x9 =csvread('senti_vectors/The_Firm.txt');
x10 =csvread('senti_vectors/The_Notebook.txt');
x11 =csvread('senti_vectors/Ulysses.txt');
y1 = load('senti_vectors/Heart_of_Darkness-sentiment');
y2 = load('senti_vectors/player_of_games_sentiment');
y3 = load('senti_vectors/Apocalypse_Now-sentiment');

ww = y2;
figure; plot(ww);

% step_size = 1;
% q = 2;
% order = 1;
% k1=1; k2=7;
% p1=7; p2=12; %floor(log2(length(ww)))-1;
% figure; hold on;
% result3 = multi_detrending(integrate1(ww), step_size, q, order); 
% plot(result3(1,:), result3(2,:),'ob','markersize',8);
% re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
% plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2);
% re3 = polyfit(result3(1,p1:p2), result3(2,p1:p2),1)
% plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2);
% text(3.5,-.5,'H_s=0.57','fontsize',15);
% text(8.5,2.8,'H_l=0.74','fontsize',15);
% xlabel('log_2w','fontsize',16);
% ylabel('log_2F(w)','fontsize',16);
% set(gca,'fontsize',16);
% box on;

% step_size = 1;
% q = 2;
% order = 1;
% k1=1; k2=7;
% p1=7; p2=12; %floor(log2(length(ww)))-1;
% figure; hold on;
% result3 = multi_detrending(integrate1(ww), step_size, q, order); 
% plot(result3(1,:), result3(2,:),'ob','markersize',8);
% re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
% plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2);
% re3 = polyfit(result3(1,p1:p2), result3(2,p1:p2),1)
% plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2);
%  text(3.5,-.1,'H_s=0.63','fontsize',15);
%  text(8.5,3.6,'H_l=0.97','fontsize',15);
% xlabel('log_2w','fontsize',16);
% ylabel('log_2F(w)','fontsize',16);
% set(gca,'fontsize',16);
% box on;

% step_size = 1;
% q = 2;
% order = 1;
% k1=1; k2=7;
% p1=7; p2=10; %floor(log2(length(ww)))-1;
% figure; hold on;
% result3 = multi_detrending(integrate1(ww), step_size, q, order); 
% plot(result3(1,:), result3(2,:),'ob','markersize',8);
% re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
% plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2);
% re3 = polyfit(result3(1,p1:p2), result3(2,p1:p2),1)
% plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2);
%   text(3.5,-.1,'H_s=0.64','fontsize',15);
%   text(8.5,3.6,'H_l=0.52','fontsize',15);
% xlabel('log_2w','fontsize',16);
% ylabel('log_2F(w)','fontsize',16);
% set(gca,'fontsize',16);
% box on;

% step_size = 1;
% q = 2;
% order = 1;
% k1=1; k2=9;
% p1=9; p2=13; %floor(log2(length(ww)))-1;
% figure; hold on;
% result3 = multi_detrending(integrate1(ww), step_size, q, order); 
% plot(result3(1,:), result3(2,:),'ob','markersize',8);
% re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
% plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2);
% re3 = polyfit(result3(1,p1:p2), result3(2,p1:p2),1)
% plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2);
%   text(4.5,-.1,'H_s=0.62','fontsize',15);
%   text(10.2,3.6,'H_l=0.81','fontsize',15);
% xlabel('log_2w','fontsize',16);
% ylabel('log_2F(w)','fontsize',16); 
% xlim([0 13])
% set(gca,'fontsize',16);
% box on;

step_size = 1;
q = 2;
order = 1;
k1=1; k2=7;
p1=7; p2=12; %floor(log2(length(ww)))-1;
figure; hold on;
result3 = multi_detrending(integrate1(ww), step_size, q, order); 
plot(result3(1,:), result3(2,:),'ob','markersize',8);
re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2);
re3 = polyfit(result3(1,p1:p2), result3(2,p1:p2),1)
plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2);
   text(4.5,-.1,'H_s=0.60','fontsize',15);
   text(9.2,3.,'H_l=0.72','fontsize',15);
xlabel('log_2w','fontsize',16);
ylabel('log_2F(w)','fontsize',16); 
xlim([0 13])
set(gca,'fontsize',16);
box on;

%          set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 4.5]);
%   print('-depsc2', 'player_of_games_H.eps');
%   print('-djpeg', 'player_of_games_H.jpg'); 
%   
  
% [t afa_var] = afa_var_time(ww);
% figure; plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8);
% xlabel('log_2 t','fontsize',16);
% ylabel('log_2 Var(t)','fontsize',16);
% %r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
% r_trend = polyfit(log2(t(2:end-2)),log2(afa_var(2:end-2)),1)
% (2 + r_trend(1))/2
