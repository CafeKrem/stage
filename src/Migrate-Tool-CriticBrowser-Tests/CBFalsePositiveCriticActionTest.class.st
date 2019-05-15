"
A CBFalsePositiveCriticActionTest is a test class for testing the behavior of CBFalsePositiveCriticAction
"
Class {
	#name : #CBFalsePositiveCriticActionTest,
	#superclass : #CBAbstractButtonActionTest,
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-Button'
}

{ #category : #running }
CBFalsePositiveCriticActionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp
]

{ #category : #tests }
CBFalsePositiveCriticActionTest >> testSelectedCriticNotNilShouldCallMarkAsFalsePositiveForCurrentRule [
	| mock |
	criticBrowserPresenter := MockCriticBrowserFalsePositiveButton new.
	self setupSelectionRulesPresenter.
	criticBrowserPresenter  criticsPresenter selectedIndex: 1.
	criticBrowserPresenter  selectedCritic ifNil: [ self fail ].
	CBFalsePositiveCriticAction runOn: mock.
	self assert: mock messageCall equals: 1
]
