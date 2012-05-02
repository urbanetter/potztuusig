Template.questions.sets = () ->
	sets.find().map (elem) ->
		setQuestions = questions.find
			set: elem._id
		result =
			_id: elem._id
			title: elem.title
			count: setQuestions.count()
		result	
		
	
Template.questions.events =
	'click button.new': () ->
		Session.set "set_id", false
		Session.set "mode", "set_edit"
			
Template.questions_row.events =
	'click button.view': () ->
		router.navigate "set/" + @_id, true
	'click button.edit': () ->
		Session.set "set_id", @_id
		Session.set "mode", "set_edit"
	'click button.delete': () ->
		Session.set "set_id", null
		sets.remove @_id


Template.set_edit.title = () ->
	set = sets.findOne Session.get "set_id"
	if set? then set.title else ""

Template.set_edit.description = () ->
	set = sets.findOne Session.get "set_id"
	if set? then set.description else ""

Template.set_edit.events =
	'click button.save': () ->
		record = 
			title: $('#title').val()
			description: $('#description').val()
		if Session.get "set_id"
			sets.update Session.get("set_id"), record
		else
			id = sets.insert record
			Session.set "set_id", id
		Session.set "mode", "questions"

Template.set.title = () ->
	set = sets.findOne Session.get("set_id")
	set.title if set?

Template.set.questions = () ->
	questions.find
		set: Session.get "set_id"

Template.set.events =
	'click button.new': () ->
		Session.set "question_id", false
		Session.set "mode", "question_edit"

Template.set_row.events =
	'click button.edit': () ->
		Session.set "question_id", @_id
		Session.set "mode", "question_edit"
	'click button.delete': () ->
		Session.set "question_id", false
		questions.remove @_id

Template.question_edit.question = () ->
	question = questions.findOne Session.get "question_id"
	question.question if question?

Template.question_edit.selected = (value) ->
	question = questions.findOne Session.get "question_id"
	return "" unless question?
	if value == question.type then "selected" else ""

Template.question_edit.events =
	'click button.save': () ->
		record = 
			question: $('#question').val()
			type: $('#type').val()
			set: Session.get "set_id"
		if Session.get "question_id"
			questions.update Session.get("question_id"), record
		else
			id = questions.insert record
			Session.set "question_id", id
		Session.set "mode", "set"