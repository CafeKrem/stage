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
CBFalsePositiveCriticActionTest >> testSelectedCriticIsNilShouldCallInformMethod [
	| mock |
	mock := MockCriticBrowser2SelectedCriticReturnNil new.
	CBFalsePositiveCriticAction runOn: mock.
	self deny: mock callFalsePositiveMethod.
	
]

{ #category : #tests }
CBFalsePositiveCriticActionTest >> testSelectedCriticNotNilShouldCallMarkAsFalsePositiveForCurrentRule [
	| mock |
	mock := MockCriticBrowser new.
	CBFalsePositiveCriticAction runOn: mock.
	self assert: mock callFalsePositiveMethod.
	
]
