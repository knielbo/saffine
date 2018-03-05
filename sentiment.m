
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
ww = xlsread('senti_vectors/alexcross');

% len = length(ww(:,2));
% figure;
% subplot(311); plot(ww(:,1)); hold on; plot(ww(:,2),'r'); box on; axis tight;
% xlabel('Narrative time','fontsize',16);
% ylabel('Sentiment','fontsize',16);
% set(gca,'fontsize',15);
% legend('human data','Syuzhet data');
%
% w = 4*floor(len/20)+1;
% [noise_ww_1, trend_ww_1] = detrending_method(ww(:,1), w, 2);
% trend_ww_1 = (trend_ww_1 - min(trend_ww_1))/(max(trend_ww_1)-min(trend_ww_1));
% trend_ww_1 = 2*trend_ww_1 - 1;
% subplot(312); plot(trend_ww_1,'b','linewidth',2); hold on;
%  [noise_ww_1, trend_ww_1] = detrending_method(ww(:,2), w, 2);
%   trend_ww_1 = (trend_ww_1 - min(trend_ww_1))/(max(trend_ww_1)-min(trend_ww_1));
%  trend_ww_1 = 2*trend_ww_1 - 1;
%   plot(trend_ww_1,'r','linewidth',2); box on; axis tight;
%   xlabel('Narrative time','fontsize',16);
% ylabel('Sentiment','fontsize',16);
% set(gca,'fontsize',15);
%   legend('human data','Syuzhet data');

% w = 4*floor(len/8)+1;
%  [noise_ww_1, trend_ww_1] = detrending_method(ww(:,1), w, 2);
%   trend_ww_1 = (trend_ww_1 - min(trend_ww_1))/(max(trend_ww_1)-min(trend_ww_1));
%  trend_ww_1 = 2*trend_ww_1 - 1;
% subplot(313); plot(trend_ww_1,'b','linewidth',2); hold on;
%  [noise_ww_1, trend_ww_1] = detrending_method(ww(:,2), w, 2);
%   trend_ww_1 = (trend_ww_1 - min(trend_ww_1))/(max(trend_ww_1)-min(trend_ww_1));
%  trend_ww_1 = 2*trend_ww_1 - 1;
%   plot(trend_ww_1,'r','linewidth',2); box on; axis tight;
%   xlabel('Narrative time','fontsize',16);
% ylabel('Sentiment','fontsize',16);
% set(gca,'fontsize',15);
%   legend('human data','Syuzhet data');
%
%      set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 8]);
%   print('-depsc2', 'Alex_cross_run.eps');
%   print('-djpeg', 'Alex_cross_run.jpg');
%
%   pause;
      %  plot(ww(:,2),'r');

step_size = 1;
q = 2;
order = 1;
k1=1; k2=12;
p1=10; p2=13;
figure; hold on;
result3 = multi_detrending(integrate1(ww(:,2)), step_size, q, order);
plot(result3(1,:), result3(2,:),'o','markersize',8,'linewidth',2);
re3 = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
plot(result3(1,k1:k2), re3(1)*result3(1,k1:k2)+re3(2),'r','linewidth',2)
%plot(result3(1,p1:p2), result3(2,p1:p2),'og','markersize',8);
%plot(result3(1,p1:p2), re3(1)*result3(1,p1:p2)+re3(2),'r','linewidth',2)
xlabel('log_2w','fontsize',16);
ylabel('log_2F(w)','fontsize',16);
set(gca,'fontsize',15);
% text(6.3,.5,'H_s = 0.59','fontsize',15);
% text(11.3,4,'H_l = 0.90','fontsize',15);
% box on;
%      set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 5]);
%   print('-depsc2', 'AFA_the_firm.eps');
%   print('-djpeg', 'AFA_the_firm.jpg');
%

%pause;

i1 = 2; i2 = 10;
[t afa_var] = afa_var_time(ww(:,2));
figure; plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8); hold on;
xlabel('log_2 t','fontsize',16);
ylabel('log_2 Var(t)','fontsize',16);
%r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
r_trend = polyfit(log2(t(i1:i2)),log2(afa_var(i1:i2)),1)
%rr = polyfit(log2(t(i2:i2+7)),log2(afa_var(i2:i2+7)),1)
plot(log2(t(i1:i2)), r_trend(1)*log2(t(i1:i2))+r_trend(2),'r','linewidth',2);
%
% %
  pause;

%w=11;

%  fig for x3
len=length(x3);
  figure; subplot(2,1,1); hold on; plot(x3,'b');

  w = 2*floor(len/400)+1;
 [noise_x3_1, trend_x3_1] = detrending_method(x3, w, 2);
 plot(trend_x3_1,'g','linewidth',2);
% w = 2401;
w = 2*floor(len/10)+1
 [noise_x3, trend_x3] = detrending_method(x3, w, 2);
 plot(trend_x3,'r','linewidth',2);
 xlim([0 len]); box on;
 legend('Original','t = L/400','t = L/10','orientation','horizontal');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
 title('Madame Bovary');
 text(300,8.5,'(a)','fontsize',17);

 subplot(2,1,2); hold on;
 trend_x3 = (trend_x3 - min(trend_x3))/(max(trend_x3)-min(trend_x3));
 trend_x3 = 2*trend_x3 - 1;
   plot(trend_x3, 'r','linewidth',2);

  % w = 2901;
   w = 6*floor(len/8)+1
   [noise_x3, trend_x3] = detrending_method(trend_x3, w, 2);
   trend_x3 = (trend_x3 - min(trend_x3))/(max(trend_x3)-min(trend_x3));
 trend_x3 = 2*trend_x3 - 1;
    plot(trend_x3, 'k','linewidth',2);
  xlim([0 len]); box on;
 legend('filtered (t = L/10)','filtered (t = 3L/8)','location','southwest');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
  text(len-500,0.83,'(b)','fontsize',17);

   set(gcf, 'PaperOrientation', 'portrait');
    set(gcf, 'PaperPosition', [0.25 0.25 8 8]);
  print('-depsc2', 'matt_madame_bovaryt.eps');
  print('-djpeg', 'matt_madame_bovaryt.jpg');

 % figure for  Apocalypse_Now
 len=length(y3);
  figure; subplot(2,1,1); hold on; plot(y3,'b');

  w = 2*floor(len/200)+1;
 [noise_y3_1, trend_y3_1] = detrending_method(y3, w, 2);
 plot(trend_y3_1,'g','linewidth',2);
% w = 2401;
w = 2*floor(len/10)+1
 [noise_y3, trend_y3] = detrending_method(y3, w, 2);
 plot(trend_y3,'r','linewidth',2);
 xlim([0 len]); box on;
 legend('Original','t = L/200','t = L/10','orientation','horizontal');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
 title('Apocalypse Now');
 text(150,3.3,'(a)','fontsize',17);

 subplot(2,1,2); hold on;
 trend_y3 = (trend_y3 - min(trend_y3))/(max(trend_y3)-min(trend_y3));
 trend_y3 = 2*trend_y3 - 1;
   plot(trend_y3, 'r','linewidth',2);

  % w = 2901;
   w = 4*floor(len/8)+1
   [noise_y3, trend_y3] = detrending_method(trend_y3, w, 2);
   trend_y3 = (trend_y3 - min(trend_y3))/(max(trend_y3)-min(trend_y3));
 trend_y3 = 2*trend_y3 - 1;
    plot(trend_y3, 'k','linewidth',2);
  xlim([0 len]); box on;
 legend('filtered (t = L/10)','filtered (t = L/4)','location','southwest');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
  text(len-250,0.83,'(b)','fontsize',17);

   set(gcf, 'PaperOrientation', 'portrait');
    set(gcf, 'PaperPosition', [0.25 0.25 8 8]);
  print('-depsc2', 'Apocalypse_Now.eps');
  print('-djpeg', 'Apocalypse_Now.jpg');

  % figure for  Gone girl
 len=length(x2);
  figure; subplot(2,1,1); hold on; plot(x2,'b');

  w = 2*floor(len/200)+1;
 [noise_x2_1, trend_x2_1] = detrending_method(x2, w, 2);
 plot(trend_x2_1,'g','linewidth',2);
% w = 2401;
w = 2*floor(len/10)+1
 [noise_x2, trend_x2] = detrending_method(x2, w, 2);
 plot(trend_x2,'r','linewidth',2);
 xlim([0 len]); box on;
 ylim([-6 6]);
 legend('Original','t = L/200','t = L/10','orientation','horizontal');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
 title('Gone Girl');
 text(180,5.1,'(a)','fontsize',17);

 subplot(2,1,2); hold on;
 trend_x2 = (trend_x2 - min(trend_x2))/(max(trend_x2)-min(trend_x2));
 trend_x2 = 2*trend_x2 - 1;
   plot(trend_x2, 'r','linewidth',2);

  % w = 2901;
   w = 4*floor(len/8)+1
   [noise_x2, trend_x2] = detrending_method(trend_x2, w, 2);
   trend_x2 = (trend_x2 - min(trend_x2))/(max(trend_x2)-min(trend_x2));
 trend_x2 = 2*trend_x2 - 1;
    plot(trend_x2, 'k','linewidth',2);
  xlim([0 len]); box on;
 legend('filtered (t = L/10)','filtered (t = L/4)','location','southwest');
 xlabel('Time','fontsize',20);
 ylabel('Sentiment','fontsize',20);
 set(gca,'fontsize',16);
  text(len-750,0.83,'(b)','fontsize',17);

   set(gcf, 'PaperOrientation', 'portrait');
    set(gcf, 'PaperPosition', [0.25 0.25 8 8]);
  print('-depsc2', 'Gone_Girl.eps');
  print('-djpeg', 'Gone_Girl.jpg');


%  sx3 = integrate_withmean(x3);
%  figure; plot(sx3);
%
%  sx3_1 = integrate1(x3);
%  figure; plot(sx3_1);

%  len=length(x3);
%  w = 2*floor(len/10)+1;
%  [noise_x3, trend_x3] = detrending_method(x3, w, 2);
 %figure; hold on; %plot(x3,'b');
 %  plot(trend_x3, 'r','linewidth',2);

 % AFA
y = load('senti_vectors/Apocalypse_Now-sentiment');

   step_size = 1;
q = 2;
order = 1;

figure; hold on;
   result3 = multi_detrending(integrate1(y), step_size, q, order);

k1 = 1; k2 = 9;
re = polyfit(result3(1,k1:k2), result3(2,k1:k2),1)
plot(result3(1,:), result3(2,:),'or','markersize',8);
plot(result3(1,k1:k2),re(1)*result3(1,k1:k2)+re(2),'b','linewidth',2);
xlim([0 11 ]);
xlabel('log_2w','fontsize',16);
ylabel('log_2F(w)','fontsize',16);
set(gca,'fontsize',15);


% trying variance time
[varm M] = var_time(y);
figure; plot(log2(M),log2(varm)); hold on;
rr = polyfit(log2(M(1:512)),log2(varm(1:512)),1)

% ll = length(y); NN = floor(ll/4);
% t = []; var_trend = [];
% for i = 1:NN
%    w = 2*i + 1;
%    [noise_y, trend_y] = detrending_method(y, w, 2);
%    t = [t i+1];
%    var_trend = [var_trend var(trend_y)];
% end
% ll = length(y); NN = floor(log2(ll/2));
% t = []; var_trend = [];
% for i=1:NN
%  w = 2^i + 1;
%  [noise_y, trend_y] = detrending_method(y, w, 2);
%  var_trend = [var_trend var(trend_y)];
%  t = [t w];
% end
% figure; hold on;
% plot(log2((t(2:end)-1)/2),log2(var_trend(2:end)),'o','markersize',8);

% $$$ try afa var_time
figure; hold on;

subplot(2,2,1); hold on;
[t afa_var] = afa_var_time(x3);
plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8);
xlabel('log_2 t','fontsize',16);
ylabel('log_2 Var(t)','fontsize',16);
r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
plot(log2(t(2:end)),r_trend(1)*log2(t(2:end))+r_trend(2),'r','linewidth',2);
plot(log2(t(2:end)),-log2(t(2:end))+r_trend(2),'--g','linewidth',2);
text(5,-2.5,'2H-2 = -0.63','fontsize',15);
text(4,-9,'2H-2 = -1','fontsize',15);
text(1.1,-12.7,'(a) Madame Bovary','fontsize',15);
box on;
xlim([0.7 10.1]);
set(gca,'fontsize',15);

subplot(2,2,2); hold on;
[t afa_var] = afa_var_time(x5);
plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8);
xlabel('log_2 t','fontsize',16);
ylabel('log_2 Var(t)','fontsize',16);
r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
plot(log2(t(2:end)),r_trend(1)*log2(t(2:end))+r_trend(2),'r','linewidth',2);
plot(log2(t(2:end)),-log2(t(2:end))+r_trend(2),'--g','linewidth',2);
text(5,-1.4,'2H-2 = -0.47','fontsize',15);
text(5,-9,'2H-2 = -1','fontsize',15);
text(1.1,-12.7,'(b) Portrait of the Artist','fontsize',15);
box on;
xlim([0.7 10.1]);
set(gca,'fontsize',15);

subplot(2,2,3); hold on;
[t afa_var] = afa_var_time(x2);
plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8);
xlabel('log_2 t','fontsize',16);
ylabel('log_2 Var(t)','fontsize',16);
r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
plot(log2(t(2:end)),r_trend(1)*log2(t(2:end))+r_trend(2),'r','linewidth',2);
plot(log2(t(2:end)),-log2(t(2:end))+r_trend(2),'--g','linewidth',2);
text(5,-3.,'2H-2 = -0.70','fontsize',15);
text(4,-9,'2H-2 = -1','fontsize',15);
text(1.1,-12.7,'(c) Gone Girl','fontsize',15);
box on;
xlim([0.7 10.1]);
set(gca,'fontsize',15);


subplot(2,2,4); hold on;
[t afa_var] = afa_var_time(x8);
plot(log2(t(2:end)),log2(afa_var(2:end)),'o','markersize',8);
xlabel('log_2 t','fontsize',16);
ylabel('log_2 Var(t)','fontsize',16);
r_trend = polyfit(log2(t(2:end)),log2(afa_var(2:end)),1)
plot(log2(t(2:end)),r_trend(1)*log2(t(2:end))+r_trend(2),'r','linewidth',2);
plot(log2(t(2:end)),-log2(t(2:end))+r_trend(2),'--g','linewidth',2);
text(5,-4.,'2H-2 = -0.64','fontsize',15);
text(3,-9,'2H-2 = -1','fontsize',15);
text(1.1,-12.7,'(d) The Da Vinci Code','fontsize',15);
box on;
xlim([0.7 10.1]);
set(gca,'fontsize',15);

   set(gcf, 'PaperOrientation', 'portrait');
    set(gcf, 'PaperPosition', [0.25 0.25 8 6]);
  print('-depsc2', 'vartime_4_novel.eps');
  print('-djpeg', 'vartime_4_novel.jpg');

%y = xlsread('senti_vectors/anc089_sentiment.xls');
%y = xlsread('senti_vectors/player_of_games_sentiment.xls');
%y = xlsread('senti_vectors/Apocalypse_Now-sentiment.xls');
y = load('senti_vectors/Apocalypse_Now-sentiment');
figure; plot(y);

w=29;
 [noise_y, trend_y] = detrending_method(y, w, 2);
 figure; hold on; plot(y,'b');
   plot(trend_y, 'r','linewidth',2.5);
w=501;
 [noise_y, trend_y] = detrending_method(y, w, 2);
   plot(trend_y, 'g','linewidth',2.5);
   xlabel('Time','fontsize',16);
   ylabel('Sentiment','fontsize',16);
   box on; axis tight;
   title('Apocalypse Now','fontsize',16);
   set(gca,'fontsize',15);
   set(gcf, 'PaperOrientation', 'portrait');
    set(gcf, 'PaperPosition', [0.25 0.25 6 4.5]);
  print('-depsc2', 'Apocalypse_Now-sentiment.eps');
  print('-djpeg', 'Apocalypse_Now-sentiment.jpg');



% data fields: time, motion, R,G,B, hue, saturation, brightness
% most important: R,G,B, hue, saturation: 3:7

% step_size = 1;
% q = 2;
% order = 1;
% figure; hold on;
%
% for j=20:20
%     fname = strcat('k_pop_series_data/z(',num2str(j),').txt');
%     z = load(char(fname));
%
% result3 = multi_detrending(integrate1(z(:,3)), step_size, q, order);
% re3 = polyfit(result3(1,:), result3(2,:),1)
% plot(result3(1,:), result3(2,:),'or','markersize',8);
%
% result4 = multi_detrending(integrate1(z(:,4)), step_size, q, order);
% re4 = polyfit(result4(1,:), result4(2,:),1)
% plot(result4(1,:), result4(2,:),'dg','markersize',8);
%
% result5 = multi_detrending(integrate1(z(:,5)), step_size, q, order);
% re5 = polyfit(result5(1,:), result5(2,:),1)
% plot(result5(1,:), result5(2,:),'>b','markersize',8);
%
% result6 = multi_detrending(integrate1(z(:,6)), step_size, q, order);
% re6 = polyfit(result6(1,:), result6(2,:),1)
% plot(result6(1,:), result6(2,:),'<k','markersize',8);
%
% result7 = multi_detrending(integrate1(z(:,7)), step_size, q, order);
% re7 = polyfit(result7(1,:), result7(2,:),1)
% plot(result7(1,:), result7(2,:),'xm','markersize',8);
%
% plot(result3(1,:),re3(1)*result3(1,:)+re3(2),'r','linewidth',2);
% plot(result4(1,:),re4(1)*result4(1,:)+re4(2),'g','linewidth',2);
% plot(result5(1,:),re5(1)*result5(1,:)+re5(2),'b','linewidth',2);
% plot(result6(1,:),re6(1)*result6(1,:)+re6(2),'k','linewidth',2);
% plot(result7(1,:),re7(1)*result7(1,:)+re7(2),'m','linewidth',2);
%
% end
% legend('R','G','B','hue','saturation','location','northwest');
% box on;
% set(gca,'fontsize',16);
% xlabel('log_2w','fontsize',18);
% ylabel('log_2F(w)','fontsize',18);
% xlim([0 7]);
%  set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 4.5]);
%   print('-depsc2', 'video_20_H.eps');
%   print('-djpeg', 'video_20_H.jpg');
%
%
% figure; hold on;
% plot(z(:,3),'r','linewidth',1.5);
% plot(z(:,4),'g','linewidth',1.5);
% plot(z(:,5),'b','linewidth',1.5);
% plot(z(:,6),'k','linewidth',1.5);
% plot(z(:,7),'m','linewidth',1.5);
% legend('R','G','B','hue','saturation','orientation','horizontal');
% set(gca,'fontsize',16);
% xlabel('frame number','fontsize',18);
% ylabel('signal','fontsize',18);  box on;
%  set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 7 5]);
%   print('-depsc2', 'video_data_20.eps');
%   print('-djpeg', 'video_data_20.jpg');
%
%
% H = [];
% % figure; hold on;
% for j=1:100
%     fname = strcat('k_pop_series_data/z(',num2str(j),').txt');
%     z = load(char(fname));
%
% %k1=1; k2=7; k3=8; k4=13;
% %result = multi_detrending(integrate1(data(10000:25000)), step_size, q, order);
% %result = multi_detrending(data(10000:25000), step_size, q, order);
%
% for i=3:7
% result = multi_detrending(integrate1(z(:,i)), step_size, q, order);
% re1 = polyfit(result(1,1:6), result(2,1:6),1);
% H = [H re1(1)];
% % plot(result(1,:), result(2,:),'-or','markersize',8);
% % result = multi_detrending(integrate1(z(:,3)), step_size, q, order);
% % re1 = polyfit(result(:,1), result(:,2),1)
% %  plot(result(1,:), result(2,:),'-dg','markersize',8);
% %  result = multi_detrending(integrate1(z(:,4)), step_size, q, order);
% %  re1 = polyfit(result(:,1), result(:,2),1)
% %  plot(result(1,:), result(2,:),'->b','markersize',8);
% %  pause
% end
% end
%
% hr = H(1:5:end);
% hg = H(2:5:end);
% hb = H(3:5:end);
% h_hue = H(4:5:end);
% h_saturation = H(5:5:end);
% figure; hold on;
% plot(hr,'r');
% plot(hg,'g');
% plot(hb,'b');
% plot(h_hue,'k');
% plot(h_saturation,'m');

% [np_hr nx_hr]=kernal_pdf(hr,10);
% [np_hg nx_hg]=kernal_pdf(hg,10);
% [np_hb nx_hb]=kernal_pdf(hb,10);
% [np_h_hue nx_h_hue]=pdf_law(h_hue,10);
% [np_h_saturation nx_h_saturation]=pdf_law(h_saturation,10);
% figure; hold on;
% plot(nx_hr,np_hr,'r','linewidth',2);
% plot(nx_hg,np_hg,'g','linewidth',2);
% plot(nx_hb,np_hb,'b','linewidth',2);
% plot(nx_h_hue,np_h_hue,'k','linewidth',2);
% plot(nx_h_saturation,np_h_saturation,'m','linewidth',2);

% using ksdensity
% [np_hr nx_hr]=ksdensity(hr);
% [np_hg nx_hg]=ksdensity(hg);
% [np_hb nx_hb]=ksdensity(hb);
% [np_h_hue nx_h_hue]=ksdensity(h_hue);
% [np_h_saturation nx_h_saturation]=ksdensity(h_saturation);
% figure; hold on;
% plot(nx_hr,np_hr,'r','linewidth',2);
% plot(nx_hg,np_hg,'g','linewidth',2);
% plot(nx_hb,np_hb,'b','linewidth',2);
% plot(nx_h_hue,np_h_hue,'--k','linewidth',2);
% plot(nx_h_saturation,np_h_saturation,'--m','linewidth',2);
% legend('R','G','B','hue','saturation');
% xlim([0.2 1.4]); box on
% set(gca,'fontsize',16);
% xlabel('H','fontsize',18);
% ylabel('PDF','fontsize',18);
% set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 5]);
%   print('-depsc2', 'video_H_pdf_1_6.eps');
%   print('-djpeg', 'video_H_pdf_1_6.jpg');

 %fitting three straight lines; rei(1) is the Hurst parameter
  %re1 = polyfit(result(1,k1:k2), result(2,k1:k2),1)
  %re2 = polyfit(result(1,k3:k4), result(2,k3:k4),1)

% %x=load('soil_361.txt');
% x=xlsread('soil_361');
% %x=load('NO3N.txt');
%
% d4 = x(:,4);
% d14 = x(:,14);
% figure; plot(d4,d14,'o','markersize',6);
%
% [dd4,ind] = sort(d4);
% dd14 = d14(ind);
% figure; hold on;
%    plot(dd4,dd14,'o','markersize',6);
%
% w=121;
%  [detrended_data, trend_d14] = detrending_method_general(dd4,dd14, w, 2);
%    plot(dd4,trend_d14, 'r','linewidth',2);
% xlabel('Elevation','fontsize',18);
% ylabel('NO3N','fontsize',18);
%  set(gca,'fontsize',16);
%  box on;
%
%     set(gcf, 'PaperOrientation', 'portrait');
%     set(gcf, 'PaperPosition', [0.25 0.25 6 5]);
%   print('-depsc2', 'ecology_data.eps');
%   print('-djpeg', 'ecology_data.jpg');
%
%
%
