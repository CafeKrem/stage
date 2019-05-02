Class {
	#name : #CBAbstractTest,
	#superclass : #TestCase,
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #testing }
CBAbstractTest >> isAbstract [ 	
	^ self = CBAbstractTest 
]
