function [y] = fibinachi(N)
% fibinachi sequence

if (N == 1 || N == 2)

    y = 1;

else

    y = fibinachi(N-1) + fibinachi(N-2);

end