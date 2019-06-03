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

{ #category : #'action-CriticsPresenter' }
CBCriticBrowserTest >> testCriticsPresenterClickACriticsShouldTransmitLocationCriticsToSourceCodePresenter [
	"this test check if he transmit the location of the critics and the range "

	self setupCriticBrowser: criticBrowser.
	self
		assert: criticBrowser sourceCodePresenter selectedPageIndex
		equals: 2.
	self
		assert: criticBrowser criticErrorPresenter text
		equals:
			'UseForTestCriticBrowser removeInstVarName: #A!
UseForTestCriticBrowser addInstVarName: #a!
'
]

{ #category : #initialize }
CBCriticBrowserTest >> testCriticsPresenterEmpty [
	
	self assert: criticBrowser criticsPresenter items isEmpty 
]

{ #category : #'as yet unclassified' }
CBCriticBrowserTest >> testDoubleOnCriticShouldSendSourceCodeToSourceCodePresenter [
	| textBefore |
	self setupSelectRBUnclassifiedMethodRule.
	criticBrowser criticsPresenter selectIndex: 1.
	textBefore := criticBrowser criticErrorPresenter text.
	self setupSelectionRulesPresenter: criticBrowser.
	criticBrowser criticsPresenter selectIndex: 2.
	self setupSelectRBUnclassifiedMethodRule.
	"simulate double click"
	criticBrowser criticsPresenter selectIndex: 1.
	criticBrowser criticsPresenter selectIndex: 1.
	self
		assert: criticBrowser criticErrorPresenter text
		equals: textBefore
]

{ #category : #initialize }
CBCriticBrowserTest >> testInitCriticErrorPresenterIsEmpty [
	self assert: criticBrowser criticErrorPresenter text equals: ''
]

{ #category : #initialize }
CBCriticBrowserTest >> testInitRuleCommentPresenterIsEmpty [
	self assert: criticBrowser ruleCommentPresenter text equals: ''
]

{ #category : #initialize }
CBCriticBrowserTest >> testRulesPresenterAnySelectedItem [
	self assert: criticBrowser rulesPresenter  selectedItem equals: nil.
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaCompositeNodeShouldRuleCommentPresenterShouldEmpty [
	criticBrowser rulesPresenter selectPath: #(1).
	self assert: criticBrowser rule isComposite.
	self assert: criticBrowser ruleCommentPresenter text equals: ''
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaCompositeNodeShouldTransmitNothingToCriticsPresenter [
	criticBrowser rulesPresenter selectPath: #(1).
	self assert: criticBrowser rule isComposite.
	self assert: criticBrowser criticsPresenter items isEmpty
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitCriticsToCriticsPresenter [
	"hasSameElements: (criticBrowserPresenter criticsOf: criticBrowserPresenter rule)"

	self setupSelectionRulesPresenter: criticBrowser.
	self deny: criticBrowser rule isComposite.
	self assert: criticBrowser criticsPresenter items size equals: 3
]

{ #category : #'action-RulesPresenter' }
CBCriticBrowserTest >> testRulesPresenterClickaNotCompositeShouldTransmitDescriptionToSourceCodePresenter [
	self setupSelectionRulesPresenter: criticBrowser.
	self deny: criticBrowser rule isComposite.
	self
		assert: criticBrowser ruleCommentPresenter text
		equals:
			'Instance variable names on the instance- and class-side should start with a lowercase letter.'
]

{ #category : #initialize }
CBCriticBrowserTest >> testSelectedRuleIsNilShouldRuleCommentPresenterIsEmpty [
	self assert: criticBrowser ruleCommentPresenter text equals: ''.
]

{ #category : #'action-SourceCodePresenter' }
CBCriticBrowserTest >> testSourceCodePresenterChangeTextAndAcceptShouldSameAsCompiledMethod [
	| beforeModif |
	"n'enregistre pas les modification"
	self setupSelectRBUnclassifiedMethodRule.
	beforeModif := criticBrowser criticErrorPresenter text.
	criticBrowser criticErrorPresenter text: beforeModif , '"klm"'.
	criticBrowser criticErrorPresenter accept.
	criticBrowser criticsPresenter clickOnSelectedItem.
	criticBrowser criticsPresenter clickOnSelectedItem.
	self
		assert: criticBrowser criticErrorPresenter text
		equals: beforeModif , '"klm"'.
	criticBrowser criticErrorPresenter text: beforeModif.
	criticBrowser criticErrorPresenter accept
]

{ #category : #tests }
CBCriticBrowserTest >> testWhenAddInstanceVariableCapitalisedShouldAddItToTheToSortColumn [
	self timeLimit: 1 minute.
	[ | nbOfToSort rule |
	self setupSelectionRulesPresenter: criticBrowser.
	rule := ((criticBrowser rulesPresenter roots at: 1) rules
		select: [ :aRule | aRule isKindOf: GRInstanceVariableCapitalizationRule ])
		at: 1.	"ugly sorry"
	nbOfToSort := criticBrowser computeToSort: rule.
	UseForTestCriticBrowser addInstVarNamed: 'O'.
	self
		assert: (criticBrowser computeToSort: rule)
		equals: nbOfToSort + 1 ]
		ensure: [ UseForTestCriticBrowser removeInstVarNamed: 'O' ]
]
