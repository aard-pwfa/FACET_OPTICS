%% Example usage
Ui = 5.39; % ionization energy in eV
I = 1E16; % laser intensity in W/cm^2
Z = 1; % ionization level
lambda = 800; % wavelength in nm

n = neff(Z,Ui); % effective quantum number
Elas = EfromI(I); % laser field in GV/m

k = 100;

[wPPT,aFunction,nPhoton,keldysh] = ionRatePPT(Ui,I,lambda,k);
wADK = ADKrate(Ui,I);

%% Try for a bunch of intensities

I = linspace(1E11,1E15,1000);
wPPTs = zeros(size(I));
KELDs = zeros(size(I));
wADKs = zeros(size(I));
eLASs = zeros(size(I));

for i=1:numel(I)
    
    [w,a,nu,k] = ionRatePPT(Ui,I(i),lambda,k);
    wPPTs(i) = w;
    KELDs(i) = k;
    
    eLASs(i) = EfromI(I(i));
    wADKs(i) = ADKrate(Ui,I(i));
    
end

%% Plot results

figure(1);
clf;
a=loglog(I,wADKs,'r--','linewidth',2);
set(gca,'ylim',[1e-150 1e30]);
set(gca,'fontsize',14)
xlabel('Intensity [W/cm^2]','fontsize',16);
ylabel('Ionization Rate [s^{-1}]','fontsize',16);
hold on;
axes('xaxislocation','top','yaxislocation','right','color','none', 'xscale', 'log', 'yscale', 'log');
hold on;
b=loglog(I,wPPTs,'b--','linewidth',2);
set(gca,'ylim',[1e-150 1e30]);
set(gca,'fontsize',14)
set(gca,'yticklabel',{});
set(gca,'xticklabel',{num2str(30), num2str(10), num2str(3), num2str(1), num2str(0.3)});
xlabel('\gamma','fontsize',20)

legend([a b],'ADK','PPT','location','southeast')



%%
figure(2);
loglog(I,wADKs,'r--',I,wPPTs,'b--','linewidth',2);

%%
I = linspace(1E13,1E15,100);
k10 = zeros(size(I));
k100 = zeros(size(I));
k1000 = zeros(size(I));
%KELDs = zeros(size(I));
%wADKs = zeros(size(I));
%eLASs = zeros(size(I));
wADKs = zeros(size(I));

for i=1:numel(I)
    
    [w,a,nu,k] = ionRatePPT(Ui,I(i),lambda,10);
    k10(i) = w;
    [w,a,nu,k] = ionRatePPT(Ui,I(i),lambda,100);
    k100(i) = w;
    [w,a,nu,k] = ionRatePPT(Ui,I(i),lambda,1000);
    k1000(i) = w;
    wADKs(i) = ADKrate(Ui,I(i));

    
end

%%

loglog(I,k10,'g',I,k100,'c',I,k1000,'m',I,wADKs,'k--','linewidth',2);
xlabel('Intensity [W/cm^{-2}]')
ylabel('Ionization Rate [s^{-1}]')
legend('k = 10','k = 100','k = 1000','ADK','location','northwest')
set(gca,'fontsize',16)
%loglog(I,k10,'m');

%%
Ui = 5.39; % ionization energy in eV
lambda = 800; % wavelength in nm
I = linspace(1E13,1E16,100);
wPPTs = zeros(size(I));
wADKs = zeros(size(I));
kelds = zeros(size(I));
nPhot = zeros(size(I));
kVals = zeros(numel(I),1001);
kLast = zeros(size(I));
aLims = zeros(size(I));

aDelta = 0.001;

for i=1:numel(I)
    
    [wPPT,wADK,kGamma,nu,ks,k,aLim] = ionRateALL(Ui,I(i),lambda,aDelta);
    wPPTs(i) = wPPT;
    wADKs(i) = wADK;
    kelds(i) = kGamma;
    nPhot(i) = nu;
    kLast(i) = k;
    kVals(i,:) = ks;
    aLims(i) = aLim;
end

%%
figure(1);
loglog(I,wPPTs,'r--',I,wADKs,'k--','linewidth',2);
xlabel('Intensity [W/cm^{-2}]')
ylabel('Ionization Rate [s^{-1}]')
legend('PPT','ADK','location','northwest')
set(gca,'fontsize',16)

figure(2);
plot(I,kelds,'b','linewidth',2);

figure(3);
plot(I,kLast,'b','linewidth',2);

figure(4);
plot(I,nPhot,'b','linewidth',2);

figure(5);
plot(I,aLims,'b','linewidth',2);

figure(6);
imagesc(log(kVals'));