sprite_index = oController.textboxFocused == id ? sTextboxFocused : sTextbox;

draw_self();
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fText);
draw_text(x, y, message + (oController.textboxFocused == id ? cursor : ""));