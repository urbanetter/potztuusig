# main application
Template.application.mode = (mode) ->
	Session.equals "mode", mode
	
Template.application.mode_active = (test) ->
	if Session.equals "mode", test then "active" else ""

# Routing with Backbone.Router
ApplicationRouter = Backbone.Router.extend
	routes:
		'dods': 'dods'
		'dod/:jira': 'dod'
		'questions': 'questions'
		'question/:question': 'question'
		'sets': 'sets'
		'set/:set': 'set'
	dods: () ->
		Session.set 'mode', 'dods'
	dod: (jira) ->
		Session.set 'mode', 'dod'
		dod = dods.findOne
			jira: jira
		Session.set 'dod_id', dod._id
	question: (question) ->
		Session.set 'mode', 'question'
		Session.set 'question_id', question
	questions: () ->
		Session.set 'mode', 'questions'
	set: (set) ->
		Session.set 'set_id', set
		Session.set 'mode', 'set'

router = new ApplicationRouter

$(document).on "click", "[data-mode]", () ->
	mode = $(this).attr "data-mode"
	router.navigate mode,
		trigger: true
	false

Meteor.startup () ->
	Session.set "mode", "dods"
	Backbone.history.start
		pushStart: true