show_debug_message("load received : " + string(async_load[? "id"]) + " - type : " + string(async_load[? "type"]) + " from " + string(async_load[? "ip"]) + ":" + string(async_load[? "port"]));

switch (async_load[? "type"]) {
	case network_type_non_blocking_connect:
		connected = async_load[? "succeeded"];
		show_debug_message("connection success : " + string(connected));
		check_credentials();
		break;
	case network_type_data:
		manage_server_response(async_load);
		break;
	default: break;
}
