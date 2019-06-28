Class {
	#name : #CBUnBanRuleMenu,
	#superclass : #CmCommand,
	#category : #'Migrate-Tool-CriticBrowser-data-menu-rule'
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
			rule isComposite
				ifTrue: [ rule rules
						do: [ :r | 
							aCriticBrowser allPackages
								do:
									[ :package | aCriticBrowser removeFalsePositiveRule: r forPackage: package ] ] ]
				ifFalse: [ aCriticBrowser allPackages
						do:
							[ :package | aCriticBrowser removeFalsePositiveRule: rule forPackage: package ] ] ]
]

{ #category : #accessing }
CBUnBanRuleMenu class >> title [ 
	^ 'Unban from selected packages it`s like unMark as FalsePositive'
]
