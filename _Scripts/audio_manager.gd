# This script is an autoload, that can be accessed from any other script!

extends Node

@onready var jump_sfx = $JumpSfx
@onready var coin_pickup_sfx = $CoinPickup
@onready var death_sfx = $DeathSfx
@onready var respawn_sfx = $RespawnSfx
@onready var level_complete_sfx = $LevelCompleteSfx
@onready var click_sfx = $ClickSfx
@onready var hit_sfx = $HitSfx
@onready var shoot_sfx = $ShootSfx
@onready var enemy_death_sfx = $EnemyDeathSfx
@onready var failed_sfx = $FailedSfx

@onready var yeah_sfx = $YeahSfx

@onready var potion_drink_sfx = $PotionDrinkSfx

@onready var coin_sfx = $Points/CoinSfx
@onready var gem_sfx = $Points/GemSfx
