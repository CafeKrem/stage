Class {
	#name : #CBAbstractButtonActionTest,
	#superclass : #CBAbstractTest,
	#instVars : [
		'criticBrowserPresenter'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #testing }
CBAbstractButtonActionTest >> isAbstract [ 
	^ self = CBAbstractButtonActionTest 
]

{ #category : #running }
CBAbstractButtonActionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp
]
