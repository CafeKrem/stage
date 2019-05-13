Class {
	#name : #CBUnBanRuleMenu,
	#superclass : #CBGroupBRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBUnBanRuleMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBUnBanRuleMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBUnBanRuleMenu class >> runOn: aCriticBrowser [
	aCriticBrowser selectedRule
		ifNotNil: [ :rule | 
			rule rules
				do: [ :r | 
					aCriticBrowser allPackages
						do:
							[ :package | aCriticBrowser removeFalsePositiveRule: r forPackage: package ] ] ]
]

{ #category : #accessing }
CBUnBanRuleMenu class >> title [ 
	^ 'Unban from selected packages'
]
