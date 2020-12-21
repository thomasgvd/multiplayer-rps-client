var xMove = keyboard_check(ord("D")) - keyboard_check(ord("Q"));
var yMove = keyboard_check(ord("S")) - keyboard_check(ord("Z"));

if (xMove != 0) image_xscale = xMove;

x += xMove * SPEED;
y += yMove * SPEED;

// Sprite animation
stretch = 1 + sin(timer * frequency) * amplitude;
timer++;