%%
% I   = single( rand(512,512,200, 8) );
% ker = single( rand(9,9,9, 8, 12) ); 
% Z   = single( rand(504,504,192, 12) );

N = 4;
I   = single( rand(256,256,100, 8, N) );
ker = single( rand(5,5, 5, 8,12) ); 
Z   = single( rand(252,252,96, 12, N) );

%% cpu: naive
% for i = 1 : 8
%   for j = 1 : 12
%     tic
%     Z(:,:,:, j) = convn( I(:,:,:,i), ker(:,:,:,i,j), 'valid' );
%     toc
%   end
% end
%% cpu: block
tic
parfor j = 1 : 12
  Z(:,:,:, j, :) = convn( I, ker(:,:,:,:,j), 'valid' );
end
toc;

%% gpu: naive
% for i = 1 : 8
%   for j = 1 : 12
%     tic
%     Z(:,:,:, j) = gather(convn( gpuArray( I(:,:,:,i) ),...
%                                 gpuArray( ker(:,:,:,i,j) ),...
%                                 'valid' ));
%     toc
%   end
% end
%% gpu: block
% blksz = 8;
% for ib = 1 : (8/blksz)
%   ibeg = blksz*(ib-1) + 1;
%   iend = blksz*(ib-1) + blksz;
%   
%   for j = 1 : 12
%     tic
%     Z(:,:,:, j, :) = gather(convn( gpuArray( I(:,:,:,ibeg:iend,:) ),...
%                                    gpuArray( ker(:,:,:,ibeg:iend, j) ),...
%                                    'valid' ));
%     toc
%   end
% end

% for j = 1 : 12
%   tic
%   Z(:,:,:, j, :) = gather(convn( gpuArray(I),...
%                                  gpuArray( ker(:,:,:,:, j) ),...
%                                  'valid' ));
%   toc
% end
