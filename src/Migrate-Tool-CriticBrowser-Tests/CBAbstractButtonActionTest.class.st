Class {
	#name : #CBAbstractButtonActionTest,
	#superclass : #CBAbstractTest,
	#instVars : [
		'criticBrowserPresenter'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-Button'
}

{ #category : #setUp }
CBAbstractButtonActionTest >> environement [
	^ RBPackageEnvironment
		packageName: 'Migrate-Tool-CriticBrowser-environementTest'
]

{ #category : #setUp }
CBAbstractButtonActionTest >> instanceOfCriticBrowser [
	^ FusionSingleCodeCriticResultList2AndCriticBrowser2
]

{ #category : #testing }
CBAbstractButtonActionTest >> isAbstract [ 
	^ self = CBAbstractButtonActionTest 
]

{ #category : #setUp }
CBAbstractButtonActionTest >> rulesToTest [
	^ (ReRuleManager uniqueInstance allRules groupedBy: #group) at: #Style
]
