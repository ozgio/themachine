class_name Tweenx

var node:Node2D
var tween:Tween

var finished:
	get():
		return tween.finished


func _init(node:Node2D, tween:Tween = null) -> void:
	self.node = node
	if tween == null:
		tween = node.get_tree().create_tween()
	self.tween = tween

func moveToWithSpeed(target:Vector2, pixelsPerSecond:float,
	transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var diff := node.position.distance_to(target)
	var duration:float = diff/pixelsPerSecond
	var t := tween.tween_property(node, 'position', target, duration)
	setTransTypeAndEase(t, transitionType, ease)
	return t

func moveTo(target:Vector2, duration:float,
	transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'position', target, duration)
	setTransTypeAndEase(t, transitionType, ease)
	return t

func moveBy(by:Vector2, duration:float,
	transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'position', by, duration).as_relative()
	setTransTypeAndEase(t, transitionType, ease)
	return t

func fadeOut(duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'modulate:a', 0, duration)
	setTransTypeAndEase(t, transitionType, ease)
	return t

func fadeIn(duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'modulate:a', 1, duration)
	setTransTypeAndEase(t, transitionType, ease)
	return t

func scale(target:Vector2, duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'scale', target, duration)
	setTransTypeAndEase(t, transitionType, ease)
	return t

func scaleBy(by:Vector2, duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'scale', by, duration).as_relative()
	setTransTypeAndEase(t, transitionType, ease)
	return t

func rotateBy(degrees:float, duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var t := tween.tween_property(node, 'rotation_degrees', degrees, duration).as_relative()
	setTransTypeAndEase(t, transitionType, ease)
	return t

func callback(fn: Callable) -> CallbackTweener:
	return tween.tween_callback(fn)

func setTransTypeAndEase(t:PropertyTweener, transitionType:Tween.TransitionType, ease:Tween.EaseType) -> PropertyTweener:
	if transitionType >=0:
		t.set_trans(transitionType)
	if ease >= 0:
		t.set_ease(ease)
	return t


static func fadeInNode(node:Node2D, duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var tx = Tweenx.new(node)
	return tx.fadeIn(duration, transitionType, ease)

static func fadeOutNode(node:Node2D, duration:float, transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var tx = Tweenx.new(node)
	return tx.fadeOut(duration, transitionType, ease)

static func moveNodeBy(node:Node2D, by:Vector2, duration:float,
	transitionType:Tween.TransitionType = -1, ease:Tween.EaseType = -1) -> PropertyTweener:
	var tx = Tweenx.new(node)
	return tx.moveBy(by, duration, transitionType, ease)
