% Simultation on Project 7 with CTMC bank queue
% Input departure No. Max
no_departure_gate = input('No departure: ');

% Initialization
queue_length = 0; % customer queue length
queue_length_calc = zeros(1, no_departure_gate);
queue_i = 1;
teller_state = zeros(1, 3);  % teller empty smbol
teller_serve_time = zeros(1, 3);  % each teller serve time
%simple customer timer
arr_time_simple = zeros(1, no_departure_gate); % simple customer arrival time
dep_time_simple = zeros(1, no_departure_gate); % simple customer leaves time
arr_no_simple = 0;
dep_no_simple = 0;
%complex customer timer
arr_time_complex = zeros(1, no_departure_gate); % simple customer arrival time
dep_time_complex = zeros(1, no_departure_gate); % simple customer leaves time
arr_no_complex = 0;
dep_no_complex = 0;
% total
arr_no = 0; % total
dep_no = 0; % total
sim_time_queue = 0; % total time
sim_time_teller(1, 3) = 0;

% 1st time loop
% Input arrival rate
lamba = input('Arrival rate: ');

% Main simultation loop
while arr_no < no_departure_gate
	% arrival
	next_arrival_time = sim_time_queue -log(rand(1, 1)) / lamba;
	arr_no = arr_no + 1;
	sim_time_queue = next_arrival_time; 
	queue_length = queue_length + 1;	
	% identify whether is simple or complex
	identifier_consumer = rand;
	if identifier_consumer < 0.75
		arr_no_simple = arr_no_simple + 1;
		arr_time_simple(arr_no_simple) = sim_time_queue;
	else
		arr_no_complex = arr_no_complex + 1;
		arr_time_complex(arr_no_complex) = sim_time_queue;
	end
		

	% departure
	if queue_length > 0
		if identifier_consumer < 0.75
			% Calculate simple Departure rate - Erlang2
			u = rand(1, 2); % To get rand number matrix	
			deal_time_simple = 0;
			for i = 1:2
                num = log(u(1, i));
				deal_time_simple = deal_time_simple - num; 
			end
			deal_time_simple = deal_time_simple / 2.0;
			flag = 0;
			for i = 1:3
				if i == 1
					if next_arrival_time < sim_time_teller(1, 1)
						continue;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 1) = teller_serve_time(1, 1) + deal_time_simple;
						dep_no_simple = dep_no_simple + 1;
						sim_time_teller(1, 1) = next_arrival_time + deal_time_simple;
						dep_time_simple(1, dep_no_simple) = sim_time_teller(1, 1);
						dep_no = dep_no + 1;
						break;
					end
				end
				if i == 2
					if next_arrival_time < sim_time_teller(1, 2)
						continue;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 2) = teller_serve_time(1, 2) + deal_time_simple;
						dep_no_simple = dep_no_simple + 1;
						sim_time_teller(1, 2) = next_arrival_time + deal_time_simple;
						dep_time_simple(1, dep_no_simple) = sim_time_teller(1, 2);
						dep_no = dep_no + 1;
						break;
					end
				end
				if i == 3
					if next_arrival_time < sim_time_teller(1, 3)
						continue;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 3) = teller_serve_time(1, 3) + deal_time_simple;
						dep_no_simple = dep_no_simple + 1;
						sim_time_teller(1, 3) = next_arrival_time + deal_time_simple;
						dep_time_simple(1, dep_no_simple) = sim_time_teller(1, 3);
						dep_no = dep_no + 1;
						break;
					end
				end
			end
			

        else
			% Calculate complex Departure rate - Erlang5
			u = rand(1, 5); % To get rand number matrix
			deal_time_complex = 0;
			for i = 1:5
				num = log(u(1, i));
				deal_time_complex = deal_time_complex - num; 
			end
			deal_time_complex = deal_time_complex / 6.0;
			flag = 0;
			for i = 1:3
				if i == 1
					if next_arrival_time < sim_time_teller(1, 1)
						continue;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 1) = teller_serve_time(1, 1) + deal_time_complex;
						dep_no_complex = dep_no_complex + 1;
						sim_time_teller(1, 1) = next_arrival_time + deal_time_complex;
						dep_time_complex(1, dep_no_complex) = sim_time_teller(1, 1);
						dep_no = dep_no + 1;
						break;
					end
				end
				if i == 2
					if next_arrival_time < sim_time_teller(1, 2)
						continue;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 2) = teller_serve_time(1, 2) + deal_time_complex;
						dep_no_complex = dep_no_complex + 1;
						sim_time_teller(1, 2) = next_arrival_time + deal_time_complex;
						dep_time_complex(1, dep_no_complex) = sim_time_teller(1, 2);
						dep_no = dep_no + 1;
						break;
					end
				end
				if i == 3
					if next_arrival_time < sim_time_teller(1, 3)
						flag = 1;
					else
						queue_length = queue_length - 1;
						teller_serve_time(1, 3) = teller_serve_time(1, 3) + deal_time_complex;
						dep_no_complex = dep_no_complex + 1;
						sim_time_teller(1, 3) = next_arrival_time + deal_time_complex;
						dep_time_complex(1, dep_no_complex) = sim_time_teller(1, 3);
						dep_no = dep_no + 1;
						break;
					end
				end
			end
			if flag == 1
				continue;
			end
		end
	else
		continue;
	end

	queue_length_calc(1, queue_i) = queue_length;
	queue_i = queue_i + 1;
end

mean(queue_length_calc)
var(queue_length_calc)
hist(queue_length_calc)
wait_time_complex = -arr_time_complex + dep_time_complex;
wait_time_complex2 = zeros(1, dep_no_complex);
for i = 1:dep_no_complex
    wait_time_complex2(1, i) = wait_time_complex(1, i);
end
m_c = mean(wait_time_complex2);
v_c = var(wait_time_complex2);

wait_time_simple = -arr_time_simple + dep_time_simple;
wait_time_simple2 = zeros(1, dep_no_simple);
for i = 1:dep_no_simple
    wait_time_simple2(1, i) = wait_time_simple(1, i);
end
m_s = mean(wait_time_simple2);
v_s = var(wait_time_simple2);


