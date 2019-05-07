Class {
	#name : #CriticsBrowserTest,
	#superclass : #CBAbstractTest,
	#instVars : [
		'criticBrowserWindow'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #running }
CriticsBrowserTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	
	criticBrowserWindow := criticBrowserPresenter openWithSpec. 
]

{ #category : #running }
CriticsBrowserTest >> tearDown [ 
	criticBrowserPresenter delete.
	super tearDown
]

{ #category : #'action-CriticsPresenter' }
CriticsBrowserTest >> testCriticsPresenterClickACriticsShouldTransmitLocationCriticsToSourceCodePresenter [
	"this test check if he transmit the location of the critics and the range "

	self setupSelectionRulesPresenter.
	criticBrowserPresenter criticsPresenter selectIndex: 1.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals:
			'UseForTestCriticBrowser removeInstVarName: #A!
UseForTestCriticBrowser addInstVarName: #a!
'
]

{ #category : #'action-CriticsPresenter' }
CriticsBrowserTest >> testCriticsPresenterClickACriticsShouldTransmitRangeOfCriticsToSourceCodePresenter [
	"this test check if he transmit the location of the critics and the range "
	
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
	self setupSelectionRulesPresenter.
	self deny: criticBrowserPresenter rule isComposite.
	self
		assert: criticBrowserPresenter criticsPresenter items size
		equals: 2.
	self flag: 'good test ?'
]

{ #category : #'action-RulesPresenter' }
CriticsBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitDescriptionToSourceCodePresenter [
	| rulePresenterTmp indexRule |
	self setupSelectionRulesPresenter.
	self deny: criticBrowserPresenter rule isComposite.
	self
		assert: criticBrowserPresenter sourceCodePresenter text
		equals:
			'Instance variable names on the instance- and class-side should start with a lowercase letter.'
]

{ #category : #initialize }
CriticsBrowserTest >> testSourceCodePresenterIsEmpty [
	self assert: criticBrowserPresenter sourceCodePresenter text equals: ''.
]
