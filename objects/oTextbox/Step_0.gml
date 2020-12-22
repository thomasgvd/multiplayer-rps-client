if (oController.textboxFocused == id) {
	if (string_length(keyboard_string) < limit) {
	    message = keyboard_string;
	} else {
	    keyboard_string = message;
	}
	if (myType == TEXTBOX_TYPE.USERNAME) oController.username = message;
	else oController.password = message;
} else {
	if (myType == TEXTBOX_TYPE.USERNAME) message = oController.username;
	else message = oController.password;

	if (mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		oController.change_focus(myType);
	}
}
