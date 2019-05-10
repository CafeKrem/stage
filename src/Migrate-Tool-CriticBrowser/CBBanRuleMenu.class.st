Class {
	#name : #CBBanRuleMenu,
	#superclass : #CBGroupBRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBBanRuleMenu class >> icon [ 
	^ nil 
]

{ #category : #accessing }
CBBanRuleMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBBanRuleMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedCritic
		ifNotNil: [ :criticsCollection | 
			criticsCollection
				do: [ :critic | 
					aCriticBrowser
						addFalsePositiveRule: aCriticBrowser rule
						forPackage: critic mcWorkingCopy ] ]
]

{ #category : #accessing }
CBBanRuleMenu class >> title [ 
	^ 'Ban from selected packages'
]
