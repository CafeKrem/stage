Class {
	#name : #CBAbstractTest,
	#superclass : #TestCase,
	#instVars : [
		'criticBrowserPresenter'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #testing }
CBAbstractTest >> isAbstract [ 	
	^ self = CBAbstractTest 
]

{ #category : #running }
CBAbstractTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	self flag: #toRefactor.
	super setUp.
	criticBrowserPresenter := FusionSingleCodeCriticResultList2AndCriticBrowser2
		new
		rules: ((ReRuleManager uniqueInstance allRules groupedBy: #group) at: #Style);
		environment:
			(RBPackageEnvironment
				packageName: 'Migrate-Tool-CriticBrowser-environementTest');
		removeTestCase: false;
		yourself.
	criticBrowserPresenter applyRules
]

{ #category : #setup }
CBAbstractTest >> setupSelectionRulesPresenter [
	| indexRule rulePresenterTmp |
	indexRule := (rulePresenterTmp := (criticBrowserPresenter
		rulesPresenter roots at: 1) rules)
		indexOf:
			(rulePresenterTmp
				detect: [ :e | e isKindOf: GRInstanceVariableCapitalizationRule ]).
	criticBrowserPresenter rulesPresenter
		selectPath: #(1) , indexRule asArray
]
