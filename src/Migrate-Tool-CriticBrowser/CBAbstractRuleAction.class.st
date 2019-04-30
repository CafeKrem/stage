Class {
	#name : #CBAbstractRuleAction,
	#superclass : #Object,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #actions }
CBAbstractRuleAction class >> actions [
	^ self allSubclasses sorted: #priority ascending 
]

{ #category : #testing }
CBAbstractRuleAction class >> isAbstract [
	^ self = CBAbstractRuleAction
]

{ #category : #accessing }
CBAbstractRuleAction class >> priority [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CBAbstractRuleAction class >> runOn: aCriticBrowser [
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractRuleAction class >> title [ 
	^ self subclassResponsibility 
]
