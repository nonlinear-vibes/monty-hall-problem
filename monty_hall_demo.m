%% MONTY_HALL_DEMO  Monte Carlo for two Monty Hall variants
% Part A: Standard formulation of the problem (the host always reveals 
%         a goat, then offers a switch).
%         Switching wins → 2/3; Staying wins → 1/3.
% Part B: Random host (chooses a door uniformly from the tow doors you didn't pick).
%         If he opens the car, the round is invalid and we discard it.
%         Switch = Stay = 1/2.

% Parameters
N = 1000;

%% Part A: Standard host (goat reveal guaranteed)
win_switch = zeros(1,N);
win_stay   = zeros(1,N);

for j = 1:N
    
    doors     = randperm(3);    % value 1 = car, 2/3 = goats
    your_pick = randi(3);

    % possible door to open
    open_door = randi(3);

    % if it is your pick or contains the car, open another one instead
    while open_door == your_pick || doors(open_door) == 1
        open_door = randi(3);
    end

    closed_door = setdiff(1:3, [your_pick open_door]);

    if doors(your_pick) == 1 % you stick to your initial pick
        win_stay(j) = 1;
    end
    your_pick = closed_door; % you switch doors
    if doors(your_pick) == 1
        win_switch(j) = 1;
    end
end

win_ratio_switch = cumsum(win_switch)./(1:N);
win_ratio_stay   = cumsum(win_stay)./(1:N);

%% Part B: Random host 
win_switch_R = zeros(1,N);
win_stay_R   = zeros(1,N);

v = 1;  % number of valid rounds (host happened to open a goat)

while v < N

    doors = randperm(3);
    your_pick = randi(3);

   % possible door to open
    open_door = randi(3);

    % if it is your pick, open another one instead
    % it can possibly be a goat
    while open_door == your_pick
        open_door = randi(3);
    end

    closed_door = setdiff(1:3, [your_pick open_door]);

    % valid trials only
    if doors(open_door) ~= 1 
        if doors(your_pick) == 1
            win_stay_R(v) = 1;
        elseif doors(closed_door) == 1
            win_switch_R(v) = 1;
        end
        v = v+1;
    end

end

win_ratio_switch_R = cumsum(win_switch_R)./(1:N);
win_ratio_stay_R   = cumsum(win_stay_R)./(1:N);

%% Plots
% Panel A
figure
subplot(2,1,1); hold on; grid on; box on;
plot(1:N, win_ratio_switch, '-', 'LineWidth', 1.3);
plot(1:N, win_ratio_stay,   '-', 'LineWidth', 1.3);
yline(2/3, '--'); yline(1/3, '--');
legend('Switch','Stay', 'Location','northeast');
title('A) Standard host (always reveals a goat)');
xlabel('Rounds'); ylabel('Success probability');

% Panel B
subplot(2,1,2); hold on; grid on; box on;
plot(1:N, win_ratio_switch_R, '-', 'LineWidth', 1.3);
plot(1:N, win_ratio_stay_R,   '-', 'LineWidth', 1.3);
yline(1/2, '--');
legend('Switch','Stay', 'Location','northeast');
title('B) Random host (conditioned on goat reveal)');
xlabel('Valid rounds'); ylabel('Success probability');