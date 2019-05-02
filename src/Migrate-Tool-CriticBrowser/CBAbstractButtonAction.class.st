"
this class is an Abstract Class to defined button interact with RulePresenter

	see documentation of my SuperClass 
	
i define :
	- actions : return a Collection of all my subclass sorted by priority
	
"
Class {
	#name : #CBAbstractButtonAction,
	#superclass : #Object,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #actions }
CBAbstractButtonAction class >> actions [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CBAbstractButtonAction class >> isAbstract [ 
	^ self = CBAbstractButtonAction 
]

{ #category : #accessing }
CBAbstractButtonAction class >> priority [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CBAbstractButtonAction class >> runOn: aCriticBrowser [
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractButtonAction class >> title [ 
	^ self subclassResponsibility 
]
