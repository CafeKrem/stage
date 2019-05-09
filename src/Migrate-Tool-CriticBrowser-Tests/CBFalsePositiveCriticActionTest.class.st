"
A CBFalsePositiveCriticActionTest is a test class for testing the behavior of CBFalsePositiveCriticAction
"
Class {
	#name : #CBFalsePositiveCriticActionTest,
	#superclass : #CBAbstractButtonActionTest,
	#instVars : [
		'isMessageCall'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #running }
CBFalsePositiveCriticActionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp
]

{ #category : #running }
CBFalsePositiveCriticActionTest >> testIfNotNilShouldCallInformMethod [
	| mock |
	
	isMessageCall := false.
	self setupSelectionRulesPresenter.
	criticBrowserPresenter criticsPresenter selectIndex: 1.
	criticBrowserPresenter selectedCritic ifNil: [ self fail ].
	mock := Mock new.
	mock stub selectedCritic willReturn: #().	"it just to do not have a nil"
	(mock stub markAsFalsePositiveForCurrentRule: Any)
		will: [ isMessageCall := true ].
	CBFalsePositiveCriticAction runOn: mock.
	self assert: isMessageCall
]

{ #category : #running }
CBFalsePositiveCriticActionTest >> testIfNotNilShouldCallMarkAsFalsePositiveMethod [
	| mock |
	self setupSelectionRulesPresenter.
	isMessageCall := false.
	self setSelectedIndexCriticsPresenter.
	self assertSelectedItemMustBeNotNil.
	mock := Mock new.
	mock stub selectedCritic willReturn: #().	"it just to do not have a nil"
	(mock stub markAsFalsePositiveForCurrentRule: Any)
		will: [ isMessageCall := true ].
	CBFalsePositiveCriticAction runOn: mock.
	self assert: isMessageCall
]
