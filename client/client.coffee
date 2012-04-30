# main application
Template.application.show_dod = () ->
	Session.get "show_dod"


# list of all dods
Template.list.dods = () ->
	dods.find()

Template.list_row.events =
	click: () ->
		Session.set "show_dod", @_id


# show dod
Template.dod.title = () ->
	dod = dods.findOne Session.get 'show_dod'
	dod.userstory
	
Template.dod.answers = () ->
	answers.find 
		dod: Session.get 'show_dod'

Template.dod.events =
	'click button.back': () ->
		Session.set "show_dod", false


# answer
Template.answer.question = () ->
	question = questions.findOne @question
	question.question

Template.answer.active_class = (value) ->
	if value == @answer then "active" else ""

Template.answer.events =
	'click button.answer': (evt) ->
		value = $(evt.target).attr "name"
		answers.update @_id, 
			$set: 
				answer: value