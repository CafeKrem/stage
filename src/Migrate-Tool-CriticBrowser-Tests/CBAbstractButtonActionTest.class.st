Class {
	#name : #CBAbstractButtonActionTest,
	#superclass : #CBAbstractTest,
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #running }
CBAbstractButtonActionTest >> assertSelectedItemMustBeNotNil [
	criticBrowserPresenter selectedCritic ifNil: [ self fail ]
]

{ #category : #testing }
CBAbstractButtonActionTest >> isAbstract [ 
	^ self = CBAbstractButtonActionTest 
]

{ #category : #running }
CBAbstractButtonActionTest >> setSelectedIndexCriticsPresenter [
	criticBrowserPresenter criticsPresenter selectIndex: 1
]
