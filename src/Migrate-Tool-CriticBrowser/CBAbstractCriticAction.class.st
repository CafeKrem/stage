Class {
	#name : #CBAbstractCriticAction,
	#superclass : #Object,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #actions }
CBAbstractCriticAction class >> actions [
	^ self allSubclasses sorted: #priority ascending 
]

{ #category : #testing }
CBAbstractCriticAction class >> isAbstract [
	^ self = CBAbstractCriticAction
]

{ #category : #accessing }
CBAbstractCriticAction class >> priority [
	^ self subclassResponsibility
]

{ #category : #accessing }
CBAbstractCriticAction class >> runOn: aCriticBrowser [
	^ self subclassResponsibility
]

{ #category : #accessing }
CBAbstractCriticAction class >> title [
	^ self subclassResponsibility
]
