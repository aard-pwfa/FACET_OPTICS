%%
Ui = 5.39; % ionization energy in eV
lambda = 800; % wavelength in nm

AU_consts;
IonEng_au = Ui/AU_Eh;
lambda_au = lambda/AU_a0;
omega_au  = 2*pi*AU_c/lambda_au;
F0_GV = AU_F*atomField(IonEng_au);

FBSI_GV = fBSI(IonEng_au);

%%
I = linspace(1E11,1E14,1000);
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