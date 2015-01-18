%% config & params
a = 3; 
b = 4;
dir_root = '~/A/code/data';
%%
tmp = load( fullfile(dir_root, 'x.mat') );
z = a*b + tmp.c;
fprintf( 'the result is %d\n', z);
