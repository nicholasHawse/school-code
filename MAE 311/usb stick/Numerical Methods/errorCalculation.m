clear
clc

m = 1:1:100;
table(m)

%step size is h in taylor series


x = Errorish(-1000,80);

function returnedErrorPercent = Errorish(true_value,aproximated_value)

returnedErrorPercent = abs((true_value - aproximated_value)/true_value*100);


errorTolerence = .5*10^(2-n);

end
