%% Make an image stack with several asymetric
% PSF masks and with no mask

sizeM=1024;
mask0=ones(sizeM);
titlepos=[sizeM/2 300];

circ = getnhood(strel('disk', 5, 0));
circ = getnhood(strel('disk', 5, 4));
%circ=1-circ;

% % Sellent 3x3 Coded Aperture
tmp=[1,0,0;0,0,1;1,1,0];
mask0=imresize(tmp,[sizeM sizeM],'nearest');

% % Engineered 2 - shuldman's
% tmp=[1,0,0,1;0,0,1,1;1,1,0,0;1,1,0,0];
% mask0=imresize(tmp,[sizeM sizeM],'nearest');
% 
% % upper left quad
% region=round(sizeM*8/16);
% mask0(1:region,1:region)=0;


%%
figure(901)
imagesc(mask0); colorbar; colormap gray;
handle=title('MASK'); set(handle,'Position',[titlepos(1),titlepos(2)]);

xfn=fftshift(fft2(mask0));
figure(902)
imagesc(real(xfn)); colorbar; colormap gray;
handle=title('FFT of MASK');

E0=zeros(1024);
E0(509:517,509:517)=circ;
E0=1-E0;
[E1,H]=propagate(E0,632.8E-9,-1E-3,5E-6/5);
psf=(fftshift(fft2(H)));
E1Holo = (1+2*real(E1)+abs(E1).^2);
figure(903); imagesc(E0,[0 max(E0(:))]); colorbar; colormap gray;
handle=title('Initial Image'); set(handle,'Position',[titlepos(1),titlepos(2)]);
figure(904); imagesc(E1Holo,[0 max(E1Holo(:))]); colorbar; colormap gray;
handle=title('Regular Hologram'); set(handle,'Position',[titlepos(1),titlepos(2)]);

[E1eng,Heng]=propagate_mask(E0,632.8E-9,-1E-3,5E-6/5,'mask',mask0);
psf=(fftshift(fft2(Heng)));
E1engHolo = (1+2*real(E1eng)+abs(E1eng).^2);
figure(905); imagesc(E1engHolo,[0 max(E1engHolo(:))]); colorbar; colormap gray;
handle=title('Engineered Hologram'); set(handle,'Position',[titlepos(1),titlepos(2)]);

E2eng=propagate_mask(E1engHolo,632.8E-9,1E-3,5E-6/5,'mask',mask0);
E2engReconstr=abs(E2eng).^2;
figure(906); imagesc(E2engReconstr,[0 max(E2engReconstr(:))]); colorbar; colormap gray;
handle=title('Reconstruction of Eng Hologram'); set(handle,'Position',[titlepos(1),titlepos(2)]);

%
E2engTwin=propagate_mask(E1engHolo,632.8E-9,-1E-3,5E-6/5,'mask',mask0);
E2engReconstrTwin=abs(E2engTwin).^2;
figure(907); imagesc(E2engReconstrTwin,[0 max(E2engReconstrTwin(:))]); colorbar; colormap gray;
handle=title('TWIN Reconstruction of Eng Hologram'); set(handle,'Position',[titlepos(1),titlepos(2)]);


