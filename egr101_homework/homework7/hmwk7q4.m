clear;clc;

for index = 1:1000000
    x = 0;
    count = 0;
    while x < 1
        x = rand + x;
        count = count +1;
    end

    storage(index) = count;

    y(index) = mean(storage);


end
mean(storage)
semilogx(storage)