Class {
	#name : #CriticsBrowserTest,
	#superclass : #TestCase,
	#instVars : [
		'criticBrowserPresenter',
		'criticsBrowserWindow'
	],
	#category : #'Migrate-Tool-CriticBrowser-test'
}

{ #category : #running }
CriticsBrowserTest >> setUp [
	criticBrowserPresenter := FusionSingleCodeCriticResultList2AndCriticBrowser2 new rules: ReRuleManager uniqueInstance allRules ;environment: (RBPackageEnvironment packages: 'replacebythepackage').
]

{ #category : #initialize }
CriticsBrowserTest >> testCriticsPresenterEmpty [
	self assert: criticBrowserPresenter criticsPresenter items isEmpty 
]
