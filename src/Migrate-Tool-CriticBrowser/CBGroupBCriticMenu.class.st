Class {
	#name : #CBGroupBCriticMenu,
	#superclass : #CBAbstractRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #accessing }
CBGroupBCriticMenu class >> groupPriority [ 
	^ 20
]

{ #category : #accessing }
CBGroupBCriticMenu class >> isAbstract [ 
	^ self = CBGroupBCriticMenu 
]
