enum TEXTBOX_TYPE { USERNAME, PASSWORD }

textboxFocused = undefined;
usernameTextbox = undefined;
passwordTextbox = undefined;
messageObj = undefined;

username = "";
password = "";

function change_focus(_type) {
	if (_type == TEXTBOX_TYPE.PASSWORD) {
		textboxFocused = passwordTextbox;
		username = keyboard_string;
		keyboard_string = password;
	} else {
		textboxFocused = usernameTextbox;
		password = keyboard_string;
		keyboard_string = username;
	}
}

function connect() {
	// Send connection request with username / password
	
	return false;
}

function display_error_message() {
	messageObj = instance_find(oMessage, 0);
	if (instance_exists(messageObj)) {
		messageObj.text = "Incorrect username or password.";
	}
}