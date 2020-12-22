if (oController.waitingForServerResponse <= 0 && mouse_check_button_pressed(mb_left) && point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	oController.connect();
}

if (oController.waitingForServerResponse > 0) sprite_index = sButtonPressed;
else if (alarm[0] <= 0) sprite_index = sButton;