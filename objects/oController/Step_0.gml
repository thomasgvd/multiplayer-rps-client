if (room == rConnect) {
	// Initialize textbox ids
	if (usernameTextbox == undefined || passwordTextbox == undefined) {
		if (instance_exists(oTextbox)) {
			for (var i = 0; i < instance_number(oTextbox); i++) {
				var textbox = instance_find(oTextbox, i);
			
				if (instance_exists(textbox) && textbox.myType = TEXTBOX_TYPE.USERNAME) usernameTextbox = textbox;
				if (instance_exists(textbox) && textbox.myType = TEXTBOX_TYPE.PASSWORD) passwordTextbox  = textbox;
			}
		}
	} else if (textboxFocused == undefined) {
		textboxFocused = usernameTextbox;
	}
	
	if (keyboard_check_pressed(vk_tab)) {
		if (textboxFocused == usernameTextbox) {
			change_focus(TEXTBOX_TYPE.PASSWORD);
		} else {
			change_focus(TEXTBOX_TYPE.USERNAME);
		}
	}
}