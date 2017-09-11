function output = Fresnel_Prop(input)

% Computation points
n_pts = input.n_pts;
mid   = n_pts/2 + 1;
nz    = input.nz;
zs    = linspace(input.zmin,input.zmax,nz);
res   = input.res;

% Ti:Saph parameters
lambda = input.lambda;   % wavelength in microns
k0     = 2*pi/lambda;    % microns^-1
I0     = input.eta*input.e0/(input.t0*pi*input.r0^2); % on-optic intensity

% Output data
output.Int_max  = zeros(nz,1);     % Maximum on axis intensity
output.Int_line = zeros(nz,n_pts); % Lineout intensity
output.r_thresh = zeros(nz,1);     % Maximum radius exceeding ionization threshold for central lobe

if input.store_all
    output.image = zeros(n_pts,n_pts,nz);
end

if input.ionization
    output.ion_cont_adk = zeros(nz,n_pts);
    output.ion_cont_ppt = zeros(nz,n_pts);
    output.max_ints = zeros(nz,1);
    output.max_Efld = zeros(nz,1);
    output.max_Ions_adk = zeros(nz,1);
    output.max_Ions_ppt = zeros(nz,1);
    output.max_Keld = zeros(nz,1);
end
    

% Fresnel Calculation
for i = 1:nz
    fprintf('Step %i of %i.\n',i,nz);
    
    z = zs(i);
    
    % Fresnel input plane
    r_max = lambda*z/(2*res);
    r = linspace(-r_max,r_max,n_pts);
    [X,Y] = meshgrid(r,r);
    [phi,rr] = cart2pol(X,Y);    
    dr = r(2)-r(1);
    
    % Fresnel image plane
    f = linspace(-lambda*z/(2*dr),lambda*z/(2*dr),n_pts);
    
    if strcmp(input.type,'AFTB') || strcmp(input.type,'AFTB2')
        
        % Optical phase and amplitude modulation
        AMP_PSI = Amplitude_Phase(rr,input,z);
        
        % Illumination
        AMP = Illumination(rr,phi,input);
        
        % Field
        field = AMP.*AMP_PSI;
        
    else
        
        % Optical phase
        PSI = Optics(rr,phi,input);
        
        % Aberations
        PSI = Aberations(rr,phi,input,PSI,r_max);
        
        % Illumination
        AMP = Illumination(rr,phi,input);
        
        % Field
        field = AMP.*exp(-1i*PSI);
        
    end
    
    % fresnel term
    fresnel = exp(1i*k0*z)*exp(1i*k0*rr.^2/(2*z))/(1i*lambda*z);
    
    % fresnel diffraction
    image     = dr^2*fftshift(fft2(field.*fresnel));
    intensity = I0*abs(image.*conj(image));
    
    % Record on-axis and lineout intensity
    output.Int_max(i)    = intensity(mid,mid);
    output.Int_line(i,:) = intensity(mid,:);
    if input.store_all
        output.image(:,:,i) = intensity;
    end
    
    if input.ionization
        output.I0 = I0;
        [PPT,ADK,kGamma] = ionFun(input.E_ion,output.Int_line(i,:),1000*lambda,0.001,input.t0);
        output.ion_cont_adk(i,:) = ADK;
        output.ion_cont_ppt(i,:) = PPT;
        output.max_ints(i) = max(output.Int_line(i,:));
        output.max_Efld(i) = EfromI(output.max_ints(i));
        output.max_Ions_adk(i) = max(output.ion_cont_adk(i,:));
        output.max_Ions_ppt(i) = max(output.ion_cont_ppt(i,:));
        output.max_Keld(i) = min(kGamma);
    end
    
end

output.z_axis = zs;
output.x_axis = f;  