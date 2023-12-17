extends Control

signal game_resume
signal game_restart
signal game_settings_menu_go

func _on_btn_resume_pressed():
	emit_signal("game_resume")


func _on_btn_restart_pressed():
	emit_signal("game_restart")


func _on_btn_settings_pressed():
	emit_signal("game_settings_menu_go")
