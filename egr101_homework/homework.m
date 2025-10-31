c = -1;
x = 0;
N = 1000;
for idx = N
    while x <= 1
        x = x + rand;
        c = c+1;
    end
    j = [c,idx];
end
plot(j,N)