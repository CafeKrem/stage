"
this class is a merge of CriticBrowser and SpecSingleCodeCriticResult (used by old CriticBrowser )
so 
			new Layout 
        ---------------------------------------------
        | RulesPresenter  ||                        |
        |                 ||                        |
        |                 || CriticsPresenter       |
        |-----------------||------------------------|
        |reset |update|log||browse|Tranform|marknoPB|                       |              |
        |===========================================|
        |SourceCodePresenter                        |
        ---------------------------------------------
	      now i use the filter feature of a ListPresenter (CriticsPresenter) instead of TextInputFieldPresenter
			

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cache:		<Object>
	checker:		<Object>
	criticsPresenter:		<Object>
	logButton:		<Object>
	rbEnvironment:		<Object>
	removeTestCase:		<Object>
	resetButton:		<Object>
	rule:		<Object>
	rulesPresenter:		<Object>
	sourceCodePresenter:		<Object>
	thread:		<Object>
	toolbarPresenter:		<Object>
	updateButton:		<Object>


    Implementation Points
"
Class {
	#name : #FusionSingleCodeCriticResultList2AndCriticBrowser2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'rule',
		'cache',
		'thread',
		'criticsPresenter',
		'sourceCodePresenter',
		'toolbarPresenter',
		'rulesPresenter',
		'resetButton',
		'logButton',
		'updateButton',
		'rbEnvironment',
		'checker',
		'removeTestCase'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #specs }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> SpecSingleCodeCriticResult [

	^ SpecPanedLayout newVertical
		add: #criticsPresenter;
		add:
			(SpecBoxLayout newVertical
				add: #toolbarPresenter
					withConstraints: [ :contraint | contraint height: 25 ];
				add: #sourceCodePresenter;
				yourself);
		yourself
]

{ #category : #specs }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> defaultSpec [
	<spec>
	^ SpecPanedLayout newVertical
		add:
			(SpecBoxLayout newVertical
				add:
					(SpecPanedLayout newHorizontal
						add:
							(SpecBoxLayout newVertical
								add: #rulesPresenter;
								add:
									(SpecBoxLayout newHorizontal
										add: #resetButton;
										add: #updateButton;
										add: #logButton;
										yourself)
									withConstraints: [ :element | element height: 20 ;padding: 7];
								yourself);
						add:
							(SpecBoxLayout newVertical
								add: #criticsPresenter;
								add: #toolbarPresenter
									withConstraints: [ :element | element height: 20 ;padding: 7];
								yourself);
						yourself);
				yourself)
			withConstraints: [ :elt | 
				elt
					beNotResizable;
					beShrinkable ];
		add: #sourceCodePresenter;
		yourself
]

{ #category : #icons }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> exclamationIcon [ 

	^  icons
			at: #'exclamationIcon'
			ifAbsentPut:[ Form fromBinaryStream: self exclamationIconContents base64Decoded readStream ].

]

{ #category : #icons }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> exclamationIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJPSURBVDjLpZPLS5RhFMYfv9QJ
lelTQZwRb2OKlKuINuHGLlBEBEOLxAu46oL0F0QQFdWizUCrWnjBaDHgThCMoiKkhUONTqmj
mDp2GZ0UnWbmfc/ztrC+GbM2dXbv4ZzfeQ7vefKMMfifyP89IbevNNCYdkN2kawkCZKfSPZT
OGTf6Y/m1uflKlC3LvsNTWArr9BT2LAf+W73dn5jHclIBFZyfYWU3or7T4K7AJmbl/yG7EtX
1BQXNTVCYgtgbAEAYHlqYHlrsTEVQWr63RZFuqsfDAcdQPrGRR/JF5nKGm9xUxMyr0YBAEXX
HgIANq/3ADQobD2J9fAkNiMTMSFb9z8ambMAQER3JC1XttkYGGZXoyZEGyTHRuBuPgBTUu7V
SnUAgAUAWutOV2MjZGkehgYUA6O5A0AlkAyRnotiX3MLlFKduYCqAtuGXpyH0XQmOj+TIURt
51OzURTYZdBKV2UBSsOIcRp/TVTT4ewK6idECAihtUKOArWcjq/B8tQ6UkUR31+OYXP4sTOd
isivrkMyHodWejlXwcC38Fvs8dY5xaIId89VlJy7ACpCNCFCuOp8+BJ6A631gANQSg1mVmOx
xGQYRW2nHMha4B5WA3chsv22T5/B13AIicWZmNZ6cMchTXUe81Okzz54pLi0uQWp+TmkZqMw
xsBV74Or3od4OISPr0e3SHa3PX0f3HXKofNH/UIG9pZ5PeUth+CyS2EMkEqs4fPEOBJLsysk
e48/+xD8oxcAYPzs4QaS7RR2kbLTTOTQieczfzfTv8QPldGvTGoF6/8AAAAASUVORK5CYII='
]

{ #category : #'class initialization' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> initialize [
	
	icons := IdentityDictionary new
]

{ #category : #examples }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> main [
	<example>
	^ self open
]

{ #category : #'instance creation' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> open [
	| env rules |
	rules := RBCompositeLintRule allGoodRules rules.
	env := RBBrowserEnvironment default.
	self openOnRule: rules onEnvironment: env
]

{ #category : #'instance creation' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> openOnRule: aRule onEnvironment: aEnv [
	| cbr |
	1halt.
	cbr := self new
		rules: aRule;
		environment: aEnv;
		"removeTestCase: false;"
		yourself.
	cbr openWithSpec.
	"cbr applyRules."
	"cbr rulesPresenter changed: #listElementAt:"
]

{ #category : #specs }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> title [

	^ 'Critic Browser'
]

{ #category : #icons }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> wrenchOrangeIcon [

	^  icons
			at: #'wrenchOrangeIcon'
			ifAbsentPut:[ Form fromBinaryStream: self wrenchOrangeIconContents base64Decoded readStream ].

]

{ #category : #icons }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> wrenchOrangeIconContents [
	"Private - Method generated"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0
RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHaSURBVDjLlZO7a1NRHMfzfzhI
KQ5OHR1ddRRBLA6lg4iTd5PSas37YR56Y2JiHgg21uoFxSatCVFjbl5iNBBiMmUJgWwZhCB4
pR9/V4QKfSQdDufF5/v7nu85xwJYprV0Oq0kk8luIpEw4vG48f/eVDiVSikCTobDIePxmGg0
yokEBO4OBgNGoxH5fJ5wOHwygVgsZpjVW60WqqqWzbVgMIjf78fn8xlTBcTy736/T7VaJRQK
fQoEArqmafR6Pdxu9/ECkUjkglje63Q6NBoNisUihUKBcrlMpVLB6XR2D4df3VQnmRstsWzU
63WazSZmX6vV0HWdUqmEw+GY2Gw25SC8dV1l1wrZNX5s3qLdbpPL5fB6vXumZalq2O32rtVq
VQ6GuGnCd+HbFnx9AZrC+MkSHo/np8vlmj/M7f4ks6yysyawgB8fwPv70HgKG8v8cp/7fFRO
/+AllewqNJ/DhyBsi9A7J1QTkF4E69mXRws8u6ayvSJwRqoG4K2Md+ygxyF5FdbPaMfdlIXU
ZfiyAUWx/OY25O4JHBP4CtyZ16a9EwuRi1CXs+5K1ew6lB9DXERX517P8tEsPDzfNIP6C5Ye
QewSrJyeCd4P0bnwXYISy3MCn5oZNtsf3pH46e7XBJcAAAAASUVORK5CYII='
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addCriticToFalsePositive [
	
	
	
	
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addCriticToToDo [

	criticsPresenter selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addToDo: item
				forRule: rule ]].
		

]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addMarkingMenuItemsTo: aMenu [
	(criticsPresenter selectedItems anySatisfy: [ :critic | cache isFalsePositive: critic forRule: rule ]) 
		ifTrue: [ aMenu add: 'Unmark as wrong' target: self selector: #removeCriticToFalsePositive ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | (cache isFalsePositive: critic forRule: rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as wrong' target: self selector: #addCriticToFalsePositive ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | cache isToDo: critic forRule: rule ]) 
		ifTrue: [ aMenu add: 'Unmark as TODO' target: self selector: #removeCriticToToDo ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | (cache isToDo: critic forRule: rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as TODO' target: self selector: #addCriticToToDo ].
	
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addNavigationMenuItemsTo: aMenu [

	criticsPresenter selectedItem ifNotNil: [ :critique |
		critique sourceAnchor entity populateCBMenu: aMenu ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addRuleToFalsePositive [

	criticsPresenter selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache addFalsePositiveRule: rule forPackage: critic mcWorkingCopy]].
]

{ #category : #'instance creation' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> allRules [
	^ rulesPresenter roots flatCollect: #rules
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> applyRules [
	| packageCount nbPackage process rules |
	rules := self allRules.
	nbPackage := rbEnvironment packages size.
	packageCount := 0.
	self updateTree.
	process := [ rbEnvironment packages
		do: [ :package | 
			| windowTitle |
			packageCount := packageCount + 1.
			windowTitle := String
				streamContents: [ :s | 
					s << 'run rules on ' << package packageName << ' ('
						<< packageCount asString << '/' << nbPackage asString << ')' ].
			"self setTitle: windowTitle."
			checker
				runRules: rules
				onPackage: package
				withoutTestCase: removeTestCase ].
	checker rule: rules.
	"self setTitle: self defaultTitle."
	cache packages: rbEnvironment.
	cache initCache.
	self updateTree.
	self registerToAnnouncements ] newProcess.
	process name: 'SmallLint'.
	process resume
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> browseCritic [
	criticsPresenter selectedItem
		ifNotNil: [ :element |
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior 
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ] 
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> browseDependencies [
	criticsPresenter selectedItems ifNotNil: [ :packages |
		(DAPackageAnalyzerPackageDependenciesWindow onPackagesNamed: (packages collect: #packageName)) open ]
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> cache:  acache [ 
	cache := acache
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsModelContains: aCritic [

	^ criticsPresenter listItems anySatisfy: [ :each |
			 each sourceAnchor entity name = aCritic name]
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsOf: aRule [
	cache ifNil: [^ {}].
	criticsPresenter items: ((cache criticsOf: aRule)
				sorted: [ :a :b | 
					a printString < b printString ]).
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsPresenter [
	^ criticsPresenter
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsPresenterAction [
	criticsPresenter
		whenSelectionChangedDo: [ :selection | 
			self criticsPresenterSelectionChangeAction
				cull: selection selectedItem ]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsPresenterSelectionChangeAction [
	self flag:#migrate.
	^ [ :critique | 
	criticsPresenter setSelection: (0 to: 0)."setSelection IconListPresenter's method"
	rule
		ifNotNil: [ critique
				ifNil: [ self setTextModelForNil ]
				ifNotNil: [ toolbarPresenter critic: critique.
					critique providesChange
						ifTrue: [ self setTextModelForTransformationRule: critique ]
						ifFalse: [ self setTextModelForClassOrMethod: critique ] ] ] ]
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> defaultColor [
	^ Color red
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> diffSeparator [

	^ '——————————————————
	
'
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> diffTextForChange: aRefactoryChange [
	| text builder |

	text := Text new.
	builder := PrettyTextDiffBuilder new.
	aRefactoryChange changes
		do: [ :chng |
			builder
				from: chng oldVersionTextToDisplay
				to: chng textToDisplay.
			text append: builder buildDisplayPatch ]
		separatedBy: [ text append: self diffSeparator ].
	
	^ text
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> environment: aEnv [
	rbEnvironment := aEnv
 
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> falsePositiveColor [
	^ Color darkGray
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> formatCritic: aCritic [
	
	^  String streamContents: [:s | aCritic sourceAnchor entity criticNameOn: s ]

]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> iconFor: anItem [
	
	^  (cache isFalsePositive: anItem forRule: rule) 
			ifFalse: [(cache isToDo: anItem forRule: rule)
				ifTrue: [ self class wrenchOrangeIcon ]
				ifFalse: [ self class exclamationIcon ] ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> implementorsOfCritic [
	criticsPresenter selectedItem ifNotNil: [ :item | item browse] 

]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initialize [

	super initialize.
	self initializeShortcuts.
	cache := ReCriticsCache new.
	checker := ReSmalllintChecker new.
	cache checker: checker.
	cache browser: self.
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeCriticsPresenter [
	criticsPresenter
		beMultipleSelection;
		displayBlock: [ :selec | self initializeDisplayCritic: selec forRule: rule ];
		itemFilterBlock: [ :item :string | '*' , string , '*' match: item contents ];
		contextMenu: [ :a :b | self menu: a shifted: b ];
		icons: [ :item | self iconFor: item ]
]

{ #category : #migrate }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeDisplayCritic: aCritic forRule: aRule [
	
	| criticRepresentation | 
	self flag: #migrate.
	criticRepresentation := (self formatCritic: aCritic) asMorph.
	^ (cache isFalsePositive: aCritic forRule: aRule) 
			ifTrue: [ criticRepresentation color: self falsePositiveColor ]
			ifFalse: [ (cache isToDo: aCritic forRule: aRule)
						ifTrue: [ criticRepresentation color: self toDoColor ]
						ifFalse: [ criticRepresentation color: self defaultColor ]]
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeLogButton [
	logButton
		state: false;
		label: 'Save Critics'
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializePresenter [
	self criticsPresenterAction.
	self toolbarPresenter.
	self rulesPresenterActions.
	logButton action: self setActionLogButton.
	resetButton action: self setActionResetButton.
	updateButton action: self setActionUpdateButton
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeResetButton [
	resetButton
		state: false;
		label: 'Run new configuration'
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeRulesPresenter [
	rulesPresenter
		addColumn:
			(StringTableColumn new
				title: 'rules';
				"width: 200;"
				evaluated: #name;
				yourself);
		addColumn:
			(StringTableColumn new
				width:40;
				title: 'toSort';
				evaluated: [ :aRules | 
					| falsePositives toDos total |
					falsePositives := (cache falsePositiveOf: aRules) size.
					toDos := (cache toDosOf: aRules) size.
					total := (cache criticsOf: aRules) size.
					total - falsePositives - toDos ];
				yourself);
		addColumn:
			(StringTableColumn new
				width: 40;
				title: 'toDo';
				evaluated: [ :aRules | (cache toDosOf: aRules) size ];
				yourself);
		addColumn:
			(StringTableColumn new
				width: 40;
				title: 'Wrong';
				evaluated: [ :aRules | (cache falsePositiveOf: aRules) size ];
				yourself);
		yourself.
	rulesPresenter
		children: [ :aRule | 
			aRule isComposite
				ifTrue: [ aRule rules ]
				ifFalse: [ #() ] ]
]

{ #category : #'initialize-shortcuts' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeShortcuts [
	criticsPresenter bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeUpdateButton [
	updateButton
		state: false;
		label: 'Update'
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeWidgets [
	criticsPresenter := self newList.
	sourceCodePresenter := self newCode.
	toolbarPresenter := self instantiate: CriticToolbar2.
	rulesPresenter := self newTreeTable.
	resetButton := self newButton.
	updateButton := self newButton.
	logButton := self newButton.
	self initializeRulesPresenter.
	self initializeLogButton.
	self initializeResetButton.
	self initializeUpdateButton.
	self initializeCriticsPresenter
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> menu: aMenu shifted: aBoolean [
	(rule notNil and: [ criticsPresenter selectedItems notEmpty ])
		ifFalse: [ ^ aMenu ]. 
		
	self addNavigationMenuItemsTo: aMenu.
	aMenu addLine.
	self addMarkingMenuItemsTo: aMenu.
			
	criticsPresenter selectedItem
		ifNotNil: [ :critique |
		critique actions ifNotEmpty: [ :actions |
			aMenu addLine.
			actions do: [ :action |
				aMenu
					add: action description
					target: action
					selector: #actOnCritic:ofEntity:
					argumentList: {
						critique .
						critique sourceAnchor entity } ] ] ].
			
	^ aMenu
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> reapplyAllRules [
	

]

{ #category : #'system annoucements' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> registerToAnnouncements [
	
	self unregisterFromAnnouncements.
	
	SystemAnnouncer uniqueInstance weak
		when: ClassAdded send: #handleClassAdded: to: self;
		when: ClassModifiedClassDefinition send: #handleClassModified: to: self;
		when: ClassRemoved send: #handleClassRemoved: to: self;
		when: MethodAdded send: #handleMethodAdded: to: self;
		when: MethodModified send: #handleMethodModified: to: self;
		when: MethodRemoved send: #handleMethodRemoved: to: self.
	self window window announcer when: WindowClosed send: #onWindowClosed to: self
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeCriticToFalsePositive [
	
	criticsPresenter selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache removeFalsePositive: item forRule: rule ]].
	
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeCriticToToDo [

	criticsPresenter selectedItems
		ifNotNil: [:items | items do: [ :item |
			cache removeToDo: item forRule: rule ]].
	
	
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeRuleToFalsePositive [

	criticsPresenter selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache removeFalsePositiveRule: rule forPackage: critic sourceAnchor entity mcWorkingCopy]].
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> resetSelection [
	self criticsPresenter resetSelection
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rule [
	^ rule
]

{ #category : #'initialize-other' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rule: aRule [

	rule := aRule.
	(rule isNil or: [ rule isComposite ]) 
		ifTrue: [ ^ self ].	
	self criticsOf:  aRule.
	toolbarPresenter rule: rule.
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rules: rulesCollection [
	self rulesPresenter roots: ((
		(rulesCollection groupedBy: #group) associations collect: [ :as |
			CriticBrowserRulesGroup
				named: as key
				rules: as value ])
					sorted: [ :a :b | a name < b name ])
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rulesPresenter [
	^ rulesPresenter 
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rulesPresenterActions [
	rulesPresenter
		transmitTo: criticsPresenter
		transform: [ :aRule | 
			(aRule isNil or: [ aRule isComposite ])
				ifTrue: [ '' ]
				ifFalse: [ cache criticsOf: aRule ] ].
	rulesPresenter
		transmitTo: sourceCodePresenter
		transform: [ :aRule | 
			(aRule isNil or: [ aRule isComposite ])
				ifTrue: [ '' ]
				ifFalse: [ aRule name ] ]
]

{ #category : #'smartSuggestions - support' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> selectedMessage [
	^ nil
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> selectionIntervalFor: aString [
	^ rule result selectionIntervalFor: aString
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sendersOfCritic [
	criticsPresenter selectedItem
		ifNotNil: [ :elem | 
			elem isBehavior
				ifTrue: [ self systemNavigation browseAllCallsOnClass: elem ]
				ifFalse: [ self systemNavigation browseAllSendersOf: elem selector ] ]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setActionLogButton [
	^ [ (UIManager default
		confirm:
			'Do you want to save all false positive and toDo in the Manifests ?
(this action may generate new manifest classes and make dirty your package)')
		ifTrue: [ cache logInManifest ] ]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setActionResetButton [
	
	^ [(UIManager default confirm: 'Do you want to delete the current configuration
 and create a new configuration ?')
		ifTrue: [ self delete. 
				SelectPackageBrowser open ]]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setActionUpdateButton [
	^ [ cache initialize.
	self applyRules ]
]

{ #category : #migrate }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setTextModelForClassOrMethod: aCritique [

	| entity |
	entity := aCritique sourceAnchor entity.
	self flag: 'Another hack. We need a better way to display entities (because now we may get not only classes and methods. Maybe something like GTInspector presentations could work)'.
	sourceCodePresenter text: (
		(entity respondsTo: #definition)
			ifTrue: [ entity definition ]
			ifFalse: [ entity asString ]).
	sourceCodePresenter aboutToStyle: true.
	sourceCodePresenter behavior: (
		entity isCompiledMethod
			ifTrue: [ entity methodClass ]
			ifFalse: [ nil ]).
	aCritique sourceAnchor providesInterval ifTrue: [ 
		sourceCodePresenter setSelection: aCritique sourceAnchor interval ]
	
	
					
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setTextModelForNil [

	| text |
	self flag:#maybeRefactoring.
	text := rule rationale isEmpty 
		ifTrue: [ rule name ]
		ifFalse: [ rule rationale ]. 
	sourceCodePresenter aboutToStyle: false.
	sourceCodePresenter text: text.
	sourceCodePresenter behavior: nil.
	toolbarPresenter critic: nil 
	
	
					
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> setTextModelForTransformationRule: selection [
	
	sourceCodePresenter behavior: nil.
	sourceCodePresenter text: (
		self diffTextForChange: selection change).
	sourceCodePresenter aboutToStyle: false.

									
					
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sourceCodePresenter [
	^ sourceCodePresenter
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sourceCodePresenterAcceptAction [
	| selectedItem |
	^ [ :text | 
	selectedItem := criticsPresenter selection selectedItem sourceAnchor
		entity.
	(selectedItem isCompiledMethod and: [ rule isTransformationRule not ])
		ifTrue: [ selectedItem methodClass compile: text ]
		ifFalse: [ Smalltalk compiler evaluate: text ] ]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sourceCodePresenterActions [
	sourceCodePresenter
		acceptBlock: [ :text | 
			| selectedItem |
			selectedItem := criticsPresenter selection selectedItem
				sourceAnchor entity.
			(selectedItem isCompiledMethod
				and: [ rule isTransformationRule not ])
				ifTrue: [ selectedItem methodClass compile: text ]
				ifFalse: [ Smalltalk compiler evaluate: text ] ]
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> textInputFieldPresenterAction [
	^ [ :text | 
	| matchText critics |
	critics := cache criticsOf: rule.
	matchText := '*' , text , '*'.
	criticsPresenter
		items:
			(text isEmpty
				ifTrue: [ critics ]
				ifFalse: [ critics
						select: [ :critic | matchText match: (self formatCritic: critic) ] ]).
	criticsPresenter updateList ]
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> toDoColor [
	^ Color orange
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> toolbarPresenter [
	^ toolbarPresenter
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> toolbarPresenterActions [
self flag:'optimise'.
	toolbarPresenter
		whenFalsePositiveClickedDo: [ :selectedItem | 
			selectedItem
				ifNotNil:
					[ :items | items do: [ :item | cache addFalsePositive: item forRule: rule ] ] ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> transformCritic [
	
	criticsPresenter selectedItems ifNotNil: [ :items |
		items do: [:critic | critic change execute ]  displayingProgress: [:critic|]]
]

{ #category : #'system annoucements' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> unregisterFromAnnouncements [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #thread }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> updateList [

	self criticsOf: rule.
	thread ifNotNil: [ thread terminate ].
	thread := [ UIManager default defer:  [ criticsPresenter updateList ]] fork.
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> updateTree [
	self flag: #deprecated. 
	criticsPresenter updateList. 
	rulesPresenter  updateTree
]
