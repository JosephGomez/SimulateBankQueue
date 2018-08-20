function y = erlang(x)
	u = rand(1, x);
	deal_time_simple = 0;
	for i = 1:x
		num = log(u(1, i));
		deal_time_simple = deal_time_simple - num; 
	end
	y = deal_time_simple / x;
