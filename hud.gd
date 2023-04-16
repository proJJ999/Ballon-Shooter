extends CanvasLayer

func update_score(score):
	$Score.text = str(score)

func update_progressbar(percentige):
	var progressbar = $ProgressBar
	progressbar.value = progressbar.max_value *	percentige
	
func update_lifebar(count):
	$Lifebar.set_lives(count)
