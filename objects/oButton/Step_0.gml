if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	if (oController.connect()) {
		room_goto(rGame);
	} else {
		oController.display_error_message();
	}
}