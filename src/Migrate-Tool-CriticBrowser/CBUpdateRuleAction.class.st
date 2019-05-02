"
my action is :
	to reload the rules
"
Class {
	#name : #CBUpdateRuleAction,
	#superclass : #CBAbstractRuleAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #accessing }
CBUpdateRuleAction class >> priority [ 
	^ 10
]

{ #category : #testing }
CBUpdateRuleAction class >> runOn: aCriticBrowser [
	aCriticBrowser reapplyAllRules
]

{ #category : #accessing }
CBUpdateRuleAction class >> title [ 
	^ 'Update'
]
