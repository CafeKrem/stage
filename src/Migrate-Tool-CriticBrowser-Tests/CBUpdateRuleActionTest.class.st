Class {
	#name : #CBUpdateRuleActionTest,
	#superclass : #CBAbstractButtonActionTest,
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-Button'
}

{ #category : #running }
CBUpdateRuleActionTest >> setUp [
	super setUp.
]

{ #category : #tests }
CBUpdateRuleActionTest >> testUpdateButtonHaveSameNumberOfToDo [
	| numberOfTodoBefore |
	self setupSelectionRulesPresenter: criticBrowser.
	numberOfTodoBefore := criticBrowser computeToSort: criticBrowser rule.
	CBUpdateRuleAction runOn: criticBrowser.
	self
		assert: (criticBrowser computeToSort: criticBrowser rule)
		equals: numberOfTodoBefore
]
