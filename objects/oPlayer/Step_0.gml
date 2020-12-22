// Sprite animation
stretch = 1 + sin(timer * frequency) * amplitude;
timer++;

// Able to move while in game room
if (room == rGame) {
	var xMove = keyboard_check(ord("D")) - keyboard_check(ord("Q"));
	var yMove = keyboard_check(ord("S")) - keyboard_check(ord("Z"));

	if (xMove != 0) image_xscale = xMove;
	
	if ((bbox_left <= 0 && xMove == -1) || (bbox_right >= room_width && xMove == 1)) xMove = 0;
	if ((bbox_bottom >= room_height && yMove == 1) || (bbox_top <= 0 && yMove == -1)) yMove = 0;

	x += xMove * SPEED;
	y += yMove * SPEED;
// Choosing attacks while in fighting room
} else if (room == rFight) {
}