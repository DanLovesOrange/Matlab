%% Create a Coded Aperture for PSF Engineering in the Fresnel Propagator

sizeM=1024;
mask=ones(sizeM);

%% Sellent 3x3 Coded Aperture
tmp=[1,0,0;0,0,1;1,1,0];
mask=imresize(tmp,[sizeM sizeM],'nearest');


%%% upper left quad (most of)
% region=round(sizeM*7/16);
% mask(1:region,1:region)=0;

%%% upper left quad including low freqs
% region=round(sizeM*8/16);
% mask(1:region,1:region)=0;

%%% upper middle including low freqs
% region=round(sizeM*8/16);
% mask(1:region,256:768)=0;

%%% upper middle (most of)
% region=round(sizeM*7/16);
% mask(1:region,512-region/2:511+region/2)=0;

%%% lower middle including low freqs
% region=round(sizeM*8/16);
% mask(end-region:end,256:768)=0;

%%% lower middle (most of)
% region=round(sizeM*15/32);
% mask(end-region:end,256:768)=0;