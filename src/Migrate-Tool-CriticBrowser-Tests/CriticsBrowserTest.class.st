Class {
	#name : #CriticsBrowserTest,
	#superclass : #CBAbstractCriticBrowserTest,
	#instVars : [
		'criticBrowserWindow',
		'criticBrowserPresenter'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-CriticBrowser'
}

{ #category : #running }
CriticsBrowserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	super setUp.
	criticBrowserPresenter := FusionSingleCodeCriticResultList2AndCriticBrowser2
		new.
	self initializeCriticBrowser: criticBrowserPresenter.
	criticBrowserWindow := criticBrowserPresenter openWithSpec
]

{ #category : #running }
CriticsBrowserTest >> tearDown [
	criticBrowserPresenter delete.
	criticBrowserWindow close.
	super tearDown
]

{ #category : #'action-CriticsPresenter' }
CriticsBrowserTest >> testCriticsPresenterClickACriticsShouldTransmitLocationCriticsToSourceCodePresenter [
	"this test check if he transmit the location of the critics and the range "

	criticBrowserPresenter criticsPresenter selectIndex: 1.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals:
			'UseForTestCriticBrowser removeInstVarName: #A!
UseForTestCriticBrowser addInstVarName: #a!
'
]

{ #category : #initialize }
CriticsBrowserTest >> testCriticsPresenterEmpty [
	
	self assert: criticBrowserPresenter criticsPresenter items isEmpty 
]

{ #category : #initialize }
CriticsBrowserTest >> testRulePresenterAnySelectedItem [
	self assert: criticBrowserPresenter sourceCodePresenter text equals: ''.
]

{ #category : #initialize }
CriticsBrowserTest >> testRulesPresenterAnySelectedItem [
	self assert: criticBrowserPresenter rulesPresenter  selectedItem equals: nil.
]

{ #category : #'action-RulesPresenter' }
CriticsBrowserTest >> testRulesPresenterClickaCompositeNodeShouldTransmitNothingToCriticsPresenter [
	criticBrowserPresenter rulesPresenter selectPath: #(1).
	self assert: criticBrowserPresenter rule isComposite.
	self assert: criticBrowserPresenter criticsPresenter items isEmpty 
]

{ #category : #'action-RulesPresenter' }
CriticsBrowserTest >> testRulesPresenterClickaCompositeNodeShouldTransmitNothingToSourceCodePresenter [
	criticBrowserPresenter rulesPresenter selectPath: #(1).
	self assert: criticBrowserPresenter rule isComposite.
	self assert: criticBrowserPresenter sourceCodePresenter text equals: ''.
]

{ #category : #'action-RulesPresenter' }
CriticsBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitCriticsToCriticsPresenter [
	"1second wait."

	"hasSameElements: (criticBrowserPresenter criticsOf: criticBrowserPresenter rule)"

	self setupSelectionRulesPresenter: criticBrowserPresenter.
	self deny: criticBrowserPresenter rule isComposite.
	self
		assert: criticBrowserPresenter criticsPresenter items size
		equals: 3.
]

{ #category : #'action-RulesPresenter' }
CriticsBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitDescriptionToSourceCodePresenter [
	self setupSelectionRulesPresenter: criticBrowserPresenter.
	self deny: criticBrowserPresenter rule isComposite.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals:
			'Instance variable names on the instance- and class-side should start with a lowercase letter.'
]

{ #category : #'action-SourceCodePresenter' }
CriticsBrowserTest >> testSourceCodePresenterChangeTextAndAcceptShouldSameAsCompiledMethod [
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
		equals: criticBrowserPresenter selectedCritic sourceAnchor entity sourceCode
]

{ #category : #initialize }
CriticsBrowserTest >> testSourceCodePresenterIsEmpty [
	self assert: criticBrowserPresenter sourceCodePresenter text equals: ''.
]
