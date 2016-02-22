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

% Threshold
thresh = input.thresh;

% Output data
output.Int_max  = zeros(nz,1);     % Maximum on axis intensity
output.Int_line = zeros(nz,n_pts); % Lineout intensity
output.r_thresh = zeros(nz,1);     % Maximum radius exceeding ionization threshold for central lobe
if input.store_all
    output.image = zeros(n_pts,n_pts,nz);
end

% Fresnel Calculation
for i = 1:nz;
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
    
    % Optical phase
    PSI = Optics(rr,phi,input);
    
    % Aberations
    PSI = Aberations(rr,phi,input,PSI,r_max);
    
    % Illumination
    AMP = Illumination(rr,phi,input);
    
    % Field
    field = AMP.*exp(-1i*PSI);
    
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
    
    % Calculate plasma radius
    abv_thresh = intensity(mid,:) > thresh;
    r_ind      = find(abv_thresh(mid:end)==0,1);
    if ~isempty(r_ind)
        output.r_thresh(i) = f(mid+r_ind-1);
    end
    
end

output.z_axis = zs;
output.x_axis = f;  