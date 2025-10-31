

trials = 10000; % number of trials to run

s_total = 0; % create a var to tally the piece size
m_total = 0;
l_total = 0;

for i = 1:trials % do the stuff trials number of times

    [small,medium,large] = crayonBreak(); % call function store output in small medium and large

    s_total = s_total + small; %add the value you get from tyhe function to the total 
    m_total = m_total + medium;
    l_total = l_total + large;

end

disp(s_total/trials); % displays the avg size of eatch piece
disp(m_total/trials);
disp(l_total/trials);

% small piece avg = 0.1106 medium piece avg = 0.2782 large piece = 0.6112 
