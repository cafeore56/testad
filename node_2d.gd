extends Node2D
@onready var admob: Admob = $Admob
@onready var label: Label = $Label

var is_initialize: bool = false

var amount: float = 0:
	set(value):
		amount = value


func _ready() -> void:
	admob.initialize()

func _on_admob_initialization_completed(status_data) -> void:
	is_initialize = true
	if is_initialize:
		print("初期化が完了したよ")

func _load_ads() -> void:
	admob.load_app_open_ad()

	# For cold start/loading screen:
	if admob.is_app_open_ad_available():
		admob.show_app_open_ad()

	admob.load_banner_ad()
	admob.load_interstitial_ad()
	admob.load_rewarded_ad()
	admob.load_rewarded_interstitial_ad()


func _on_bana_pressed() -> void:
	if is_initialize:
		print("押したよ")
		admob.load_banner_ad()
		await admob.banner_ad_loaded
		print("準備完了")
		admob.show_banner_ad()


func _on_ini_pressed() -> void:
	if is_initialize:
		print("押したよ")
		admob.load_interstitial_ad()
		await admob.interstitial_ad_loaded
		print("準備完了")
		admob.show_interstitial_ad()


func _on_rew_pressed() -> void:
	if is_initialize:
		print("押したよ")
		admob.load_rewarded_ad()
		await admob.rewarded_ad_loaded
		print("準備完了")
		admob.show_rewarded_ad()





func _on_admob_rewarded_ad_user_earned_reward(ad_id: String, reward_data: RewardItem) -> void:
	label.text = "報酬ゲッツ"
