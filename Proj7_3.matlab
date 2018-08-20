% Simultation on Project 7 with CTMC bank queue
% Input departure No. Max
no_departure_gate = input('No departure: ');

% Initialization
queue_length = 0; % customer queue length
queue_length_calc = zeros(1, no_departure_gate);
queue_i = 1;

teller_state = zeros(1, 3);  % teller empty smbol
teller_serve_time = zeros(1, 3);  % each teller serve time
teller_queue = zeros(1, 3); % each teller queue length

% 3 teller queues to calculate each dealing time in the queue
teller_dealing_queue = zeros(3, no_departure_gate);
teller_queue_finished = zeros(1, 3);
rest_time_deal = zeros(1, 3);   % dealing with number during this period but resing time
%simple customer timer
arr_time_simple = zeros(1, no_departure_gate); % simple customer arrival time
dep_time_simple = zeros(1, no_departure_gate); % simple customer leaves time
arr_no_simple = 0;
dep_no_simple = 0;
deal_time_simple = zeors(1, no_departure_gate);
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
	arriving_time = -log(rand(1, 1)) / lamba
	next_arrival_time = sim_time_queue + arriving_time;
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
		queue_length = queue_length - 1;
		min_teller_queue = min(teller_queue);
		[row, column] = find(teller_queue == min_teller_queue);
		deal_zone = arriving_time;
		if identifier_consumer < 0.75
			deal_time_simple = erlang(2);

			% Things during this arriving with each teller doing
			for i = 1:3
				rest_time_deal(1, i) = rest_time_deal(1, i) - arriving_time;
				if rest_time_deal(1, i) > 0
				else
					resting_time = -rest_time_deal(1, i);
					teller_queue_finished(1, i) = teller_queue_finished(1, i) + 1;
					teller_queue(1, i) = teller_queue(1, i) - 1;
					while(resting_time > 0)
						if (teller_queue(1, i) > 0)
							resting_time = resting_time - teller_dealing_queue(i, teller_queue_finished + 1);
							if(resting_time > 0)
								teller_queue_finished(1, i) = teller_queue_finished(1, i) + 1;
								teller_queue(1, i) = teller_queue(1, i) - 1;
								continue;
							else
								rest_time_deal = 0;
						else

					end 
				if teller_queue(1, i) > 0
					while(deal_zone > 0)
						deal_zone = deal_zone
					end
				else




		else
			deal_time_complex = erlang(5);
		end
	else
		continue;
	end
end			

wait_time_complex = arr_time_complex - dep_time_complex;
wait_time_simple = arr_time_simple - dep_time_simple;



