Class {
	#name : #CBGroupBRuleMenu,
	#superclass : #CBAbstractRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBGroupBRuleMenu class >> groupPriority [ 
	^ 20
]

{ #category : #accessing }
CBGroupBRuleMenu class >> isAbstract [ 
	^ self = CBGroupBRuleMenu 
]
