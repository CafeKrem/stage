Class {
	#name : #CBCriticBrowserTest,
	#superclass : #CBAbstractTest,
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-CriticBrowser'
}

{ #category : #setup }
CBCriticBrowserTest >> environement [
	^ RBPackageEnvironment
		packageName: 'Migrate-Tool-CriticBrowser-environementTest'
]

{ #category : #setup }
CBCriticBrowserTest >> instanceOfCriticBrowser [
	^ FusionSingleCodeCriticResultList2AndCriticBrowser2
]

{ #category : #setup }
CBCriticBrowserTest >> rulesToTest [
	^ (ReRuleManager uniqueInstance allRules groupedBy: #group) at: #Style
]

{ #category : #running }
CBCriticBrowserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp
]

{ #category : #UIModification }
CBCriticBrowserTest >> setupCriticBrowser: aCriticBrowser [
	self setupSelectionRulesPresenter: aCriticBrowser.
	self setupSelectionCriticPresenter: aCriticBrowser
]

{ #category : #UIModification }
CBCriticBrowserTest >> setupSelectionCriticPresenter: aCriticBrowser [
	aCriticBrowser criticsPresenter selectIndex: 1
]

{ #category : #UIModification }
CBCriticBrowserTest >> setupSelectionRulesPresenter: aCriticBrowser [
	| indexRule rulePresenterTmp |
	indexRule := (rulePresenterTmp := (aCriticBrowser rulesPresenter
		roots at: 1) rules)
		indexOf:
			(rulePresenterTmp
				detect: [ :e | e isKindOf: GRInstanceVariableCapitalizationRule ]).
	aCriticBrowser rulesPresenter selectPath: #(1) , indexRule asArray
]

{ #category : #'action-CriticsPresenter' }
CBCriticBrowserTest >> testCriticsPresenterClickACriticsShouldTransmitLocationCriticsToSourceCodePresenter [
	"this test check if he transmit the location of the critics and the range "

	self setupCriticBrowser: criticBrowser.
	self
		assert: criticBrowser sourceCodePresenter text
		equals:
			'UseForTestCriticBrowser removeInstVarName: #A!
UseForTestCriticBrowser addInstVarName: #a!
'
]

{ #category : #initialize }
CBCriticBrowserTest >> testCriticsPresenterEmpty [
	
	self assert: criticBrowser criticsPresenter items isEmpty 
]

{ #category : #initialize }
CBCriticBrowserTest >> testRulePresenterNoSelectedItem [
	self flag: #errorTextReturnSomeTimeNil.
	self assert: criticBrowser sourceCodePresenter text equals: ''.
]

{ #category : #initialize }
CBCriticBrowserTest >> testRulesPresenterAnySelectedItem [
	self assert: criticBrowser rulesPresenter  selectedItem equals: nil.
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaCompositeNodeShouldTransmitNothingToCriticsPresenter [
	criticBrowser rulesPresenter selectPath: #(1).
	self assert: criticBrowser rule isComposite.
	self assert: criticBrowser criticsPresenter items isEmpty
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaCompositeNodeShouldTransmitNothingToSourceCodePresenter [
	self flag: #error.
	criticBrowser rulesPresenter selectPath: #(1).
	self assert: criticBrowser rule isComposite.
	self assert: criticBrowser sourceCodePresenter text equals: ''
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitCriticsToCriticsPresenter [
	"1second wait."

	"hasSameElements: (criticBrowserPresenter criticsOf: criticBrowserPresenter rule)"

	self setupSelectionRulesPresenter: criticBrowser.
	self deny: criticBrowser rule isComposite.
	self assert: criticBrowser criticsPresenter items size equals: 3
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitDescriptionToSourceCodePresenter [
	self setupSelectionRulesPresenter: criticBrowserPresenter.
	self deny: criticBrowserPresenter rule isComposite.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals:
			'Instance variable names on the instance- and class-side should start with a lowercase letter.'
]

{ #category : #'action-SourceCodePresenter' }
CBCriticBrowserTest >> testSourceCodePresenterChangeTextAndAcceptShouldSameAsCompiledMethod [
	| beforeModif indexRule rulePresenterTmp |
	indexRule := (rulePresenterTmp := (criticBrowserPresenter
		rulesPresenter roots at: 1) rules)
		indexOf:
			(rulePresenterTmp
				detect: [ :e | e isKindOf: RBUnclassifiedMethodsRule ]).
	criticBrowserPresenter rulesPresenter
		selectPath: #(1) , indexRule asArray.
	criticBrowserPresenter criticsPresenter selectIndex: 1.
	beforeModif := criticBrowserPresenter sourceCodePresenter text.
	self flag: #upgrade.
	criticBrowserPresenter sourceCodePresenter
		text: beforeModif , '"klm"'.
	criticBrowserPresenter sourceCodePresenter accept.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals: criticBrowserPresenter selectedCritic sourceAnchor entity sourceCode.
	criticBrowserPresenter sourceCodePresenter text: beforeModif 
]

{ #category : #initialize }
CBCriticBrowserTest >> testSourceCodePresenterIsEmpty [
	self assert: criticBrowserPresenter sourceCodePresenter text equals: ''.
]
