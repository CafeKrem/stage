Class {
	#name : #CBAbstractCriticBrowserTest,
	#superclass : #TestCase,
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #'as yet unclassified' }
CBAbstractCriticBrowserTest >> initializeCriticBrowser: aCriticBrowser [
	aCriticBrowser
		rules: ((ReRuleManager uniqueInstance allRules groupedBy: #group) at: #Style);
		environment:
			(RBPackageEnvironment
				packageName: 'Migrate-Tool-CriticBrowser-environementTest');
		removeTestCase: false;
		yourself.
	aCriticBrowser applyRules
]

{ #category : #testing }
CBAbstractCriticBrowserTest >> isAbstract [
	^ self = CBAbstractCriticBrowserTest 
]

{ #category : #'as yet unclassified' }
CBAbstractCriticBrowserTest >> setupCriticBrowser: aCriticBrowser [
	self initializeCriticBrowser: aCriticBrowser.
	self setupSelectionRulesPresenter: aCriticBrowser.
	self setupSelectionCriticPresenter: aCriticBrowser
]

{ #category : #'as yet unclassified' }
CBAbstractCriticBrowserTest >> setupSelectionCriticPresenter: aCriticBrowser [
	aCriticBrowser criticsPresenter selectIndex: 1
]

{ #category : #'as yet unclassified' }
CBAbstractCriticBrowserTest >> setupSelectionRulesPresenter: aCriticBrowser [
	| indexRule rulePresenterTmp |
	indexRule := (rulePresenterTmp := (aCriticBrowser rulesPresenter
		roots at: 1) rules)
		indexOf:
			(rulePresenterTmp
				detect: [ :e | e isKindOf: GRInstanceVariableCapitalizationRule ]).
	aCriticBrowser rulesPresenter selectPath: #(1) , indexRule asArray
]
