extends CanvasLayer

func update_score(score):
	$Score.text = str(score)

func update_progress_bar(percentige):
	var progressbar = $ProgressBar
	progressbar.value = progressbar.max_value *	percentige
