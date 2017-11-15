%FFAPLOT plot the ffa graph
%   FFAPLOT plots the ffa graph given a, b, k
%
%
function [] = ffaplot(a, b, k)
    if ~all([size(a) == size(b), size(a) == size(k), size(b) == size(k)])
        error('Input arrays size should agree!!!');
    end

    % hold on;
    for i = 1:length(a)
        t = 1:100;
        q = b(i) + a(i) / k(i) * (1 - (-log(1 - 1 ./ t)) .^ k(i));

        loglog(t, q, 'DisplayName', ['stream ', num2str(i)]);
        hold on
    end
    grid on
    xlabel('Return period (yr)');
    ylabel('Flood magnitude (cfs)');
    legend('show');
    hold off;
end
