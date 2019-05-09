Class {
	#name : #CBGroupACriticMenu,
	#superclass : #CBAbstractRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #accessing }
CBGroupACriticMenu class >> groupPriority [
	^ 1
]

{ #category : #accessing }
CBGroupACriticMenu class >> isAbstract [
	^ self = CBGroupACriticMenu 
]
