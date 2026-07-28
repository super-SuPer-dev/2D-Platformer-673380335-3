extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("move")
	self.body_entered.connect(fun)

func fun(body: Node2D) -> void:
	var player = body as Player
	if player:
		player.use_potion("jump")
		AudioManager.potion_drink_sfx.play()
		queue_free()
