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
	^ aCriticBrowser selectedRule
		ifNotNil: [ :rule | 
			rule isComposite
				ifTrue: [ rule rules
						do: [ :aRule | 
							aCriticBrowser allPackages
								do:
									[ :package | aCriticBrowser addFalsePositiveRule: aRule forPackage: package ] ] ]
				ifFalse: [ aCriticBrowser allPackages
						do:
							[ :package | aCriticBrowser addFalsePositiveRule: rule forPackage: package ] ] ]
]

{ #category : #accessing }
CBBanRuleMenu class >> title [ 
	^ 'Ban from selected packages. it`s like mark as FalsePositive '
]
