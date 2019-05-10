"
see superClass 's documentation
my action is :
	to reload the rules
"
Class {
	#name : #CBUpdateRuleAction,
	#superclass : #CBAbstractRuleAction,
	#category : #'Migrate-Tool-CriticBrowser-data-buttons'
}

{ #category : #accessing }
CBUpdateRuleAction class >> groupPriority [ 
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
