# list of all dods
Template.dods.dods = () ->
	dods.find()

Template.dods.events =
	'click button.new': () ->
		Session.set "dod_id", false
		Session.set "mode", "dod_edit"

Template.dods_row.events =
	'click button.view': () ->
		Session.set "dod_id", @_id
		Session.set "mode", "dod"
	'click button.edit': () ->
		Session.set "dod_id", @_id
		Session.set "mode", "dod_edit"
	'click button.delete': () ->
		Session.set "dod_id", false
		dods.remove @_id


# edit dods
Template.dod_edit.title = () ->
	dod = dods.findOne Session.get("dod_id")
	dod.title if dod?

Template.dod_edit.jira = () ->
	dod = dods.findOne Session.get("dod_id")
	dod.jira if dod?

Template.dod_edit.is_new = () ->
	Session.equals "dod_id", false
	
Template.dod_edit.sets = () ->
	sets.find()
	
Template.dod_edit.events =
	'click button.save': () ->
		record = 
			title: $('#title').val()
			jira: $('#jira').val()
		isNew = Session.equals "dod_id", false
		if isNew
			set = sets.findOne $('#set').val()
			record.set = set.title
			id = dods.insert record
			Session.set "dod_id", id
			dodQuestions = questions.find
				set: set._id
			dodQuestions.forEach (question) ->
				answers.insert
					dod: id
					question: question._id
					answer: ''
		else
			# update dod
			dods.update @_id,
				$set
					title: record.title
					jira: record.jira
		Session.set "mode", "dod"

Template.dod.title = () ->
	dod = dods.findOne Session.get "dod_id"
	dod.title if dod?

Template.dod.jira = () ->
	dod = dods.findOne Session.get "dod_id"
	dod.jira if dod?

Template.dod.answers = () ->
	answers.find
		dod: Session.get("dod_id")

Template.dod.events =
	'click button.back': () ->
		Session.set "mode", "dods"

# answer
Template.answer.question = () ->
	question = questions.findOne @question
	question.question

Template.answer.type = (value) ->
	question = questions.findOne @question
	question.type == value

Template.answer.active_class = (value) ->
	if value == @answer then "active" else ""

Template.answer.events =
	'click button.answer, keyup input, focusout input': (evt) ->
		value = $(evt.target).attr "name"
		answers.update @_id, 
			$set: 
				answer: value
	'keyup input, focusout input': (evt) ->
		value = $(evt.target).val()
		answers.update @_id, 
			$set: 
				answer: value
