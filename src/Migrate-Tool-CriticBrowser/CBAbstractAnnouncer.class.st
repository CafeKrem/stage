Class {
	#name : #CBAbstractAnnouncer,
	#superclass : #Object,
	#instVars : [
		'criticBrowser'
	],
	#category : #'Migrate-Tool-CriticBrowser-data-announcer'
}

{ #category : #'as yet unclassified' }
CBAbstractAnnouncer class >> handleAction [
	^ self subclassResponsibility
]

{ #category : #accessing }
CBAbstractAnnouncer class >> runOn: aCriticBrowser [
	^ self subclassResponsibility
]
