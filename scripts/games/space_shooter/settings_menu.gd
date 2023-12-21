extends Control


signal game_settings_menu_back
signal game_settings_change_skin

func _on_btn_back_pressed():
	emit_signal("game_settings_menu_back")


func _on_btn_modify_skin_pressed():
	emit_signal("game_settings_change_skin")
