"
A CBBrowseCriticActionTest is a test class for testing the behavior of CBBrowseCriticAction
"
Class {
	#name : #CBBrowseCriticActionTest,
	#superclass : #CBAbstractButtonActionTest,
	#instVars : [
		'isMessageCall'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #running }
CBBrowseCriticActionTest >> testSelectedCriticIsNilShouldCallInformMethod [
	| mock compiledMethod mockEntity |
	self setupSelectionRulesPresenter.
	self setSelectedIndexCriticsPresenter.
	self assertSelectedItemMustBeNotNil.
	mockEntity := Mock new.
	mock := Mock new.
	isMessageCall := false.
	Any stub anyMessage willReturn: mockEntity.
	mock stub selectedCritic willReturn: mockEntity.
	mockEntity stub browse will: [ isMessageCall := true ].
	CBBrowseCriticAction runOn: mock.
	self assert: isMessageCall
]

{ #category : #running }
CBBrowseCriticActionTest >> testSelectedCriticIsNotNilShouldCallBrowser [
	| mock compiledMethod mockEntity |
	self setupSelectionRulesPresenter.
	self setSelectedIndexCriticsPresenter.
	self assertSelectedItemMustBeNotNil.
	mockEntity := Mock new.
	mock := Mock new.
	isMessageCall := false.
	Any stub anyMessage willReturn: mockEntity.
	mock stub selectedCritic willReturn: mockEntity.
	mockEntity stub browse will: [ isMessageCall := true ].
	CBBrowseCriticAction runOn: mock.
	self assert: isMessageCall
]
