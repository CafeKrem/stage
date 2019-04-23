Class {
	#name : #SingleCodeCriticResultList2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'rule',
		'cache',
		'thread',
		'criticsPresenter',
		'sourceCodePresenter',
		'textInputFieldPresenter',
		'toolbarPresenter'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #specs }
SingleCodeCriticResultList2 class >> defaultSpec [
	<spec>
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

{ #category : #icons }
SingleCodeCriticResultList2 class >> exclamationIcon [ 

	^  icons
			at: #'exclamationIcon'
			ifAbsentPut:[ Form fromBinaryStream: self exclamationIconContents base64Decoded readStream ].

]

{ #category : #icons }
SingleCodeCriticResultList2 class >> exclamationIconContents [
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
SingleCodeCriticResultList2 class >> initialize [
	
	icons := IdentityDictionary new
]

{ #category : #examples }
SingleCodeCriticResultList2 class >> main [ 
	<example>
		^ self new openWithSpec
]

{ #category : #specs }
SingleCodeCriticResultList2 class >> title [

	^ 'Critic Browser'
]

{ #category : #icons }
SingleCodeCriticResultList2 class >> wrenchOrangeIcon [

	^  icons
			at: #'wrenchOrangeIcon'
			ifAbsentPut:[ Form fromBinaryStream: self wrenchOrangeIconContents base64Decoded readStream ].

]

{ #category : #icons }
SingleCodeCriticResultList2 class >> wrenchOrangeIconContents [
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
SingleCodeCriticResultList2 >> addCriticToFalsePositive [
	
	criticsPresenter selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addFalsePositive: item
				forRule: rule ]].
	
	
]

{ #category : #menu }
SingleCodeCriticResultList2 >> addCriticToToDo [

	criticsPresenter selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache
				addToDo: item
				forRule: rule ]].
		

]

{ #category : #menu }
SingleCodeCriticResultList2 >> addMarkingMenuItemsTo: aMenu [
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
SingleCodeCriticResultList2 >> addNavigationMenuItemsTo: aMenu [

	criticsPresenter selectedItem ifNotNil: [ :critique |
		critique sourceAnchor entity populateCBMenu: aMenu ]
]

{ #category : #menu }
SingleCodeCriticResultList2 >> addRuleToFalsePositive [

	criticsPresenter selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache addFalsePositiveRule: rule forPackage: critic mcWorkingCopy]].
]

{ #category : #menu }
SingleCodeCriticResultList2 >> browseCritic [
	criticsPresenter selectedItem
		ifNotNil: [ :element |
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior 
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ] 
]

{ #category : #menu }
SingleCodeCriticResultList2 >> browseDependencies [
	criticsPresenter selectedItems ifNotNil: [ :packages |
		(DAPackageAnalyzerPackageDependenciesWindow onPackagesNamed: (packages collect: #packageName)) open ]
]

{ #category : #accessing }
SingleCodeCriticResultList2 >> cache:  acache [ 
	cache := acache
]

{ #category : #accessing }
SingleCodeCriticResultList2 >> criticsModel [
	^ criticsPresenter
]

{ #category : #private }
SingleCodeCriticResultList2 >> criticsModelContains: aCritic [

	^ criticsPresenter listItems anySatisfy: [ :each |
			 each sourceAnchor entity name = aCritic name]
]

{ #category : #private }
SingleCodeCriticResultList2 >> criticsOf: aRule [
	cache ifNil: [^ {}].
	criticsPresenter items: ((cache criticsOf: aRule)
				sorted: [ :a :b | 
					a printString < b printString ]).
]

{ #category : #action }
SingleCodeCriticResultList2 >> criticsPresenterSelectionChangeAction [
	^ [ :critique | 
	criticsPresenter setSelection: (0 to: 0).
	rule
		ifNotNil: [ critique
				ifNil: [ self setTextModelForNil ]
				ifNotNil: [ toolbarPresenter critic: critique.
					critique providesChange
						ifTrue: [ self setTextModelForTransformationRule: critique ]
						ifFalse: [ self setTextModelForClassOrMethod: critique ] ] ] ]
]

{ #category : #private }
SingleCodeCriticResultList2 >> defaultColor [
	^ Color red
]

{ #category : #private }
SingleCodeCriticResultList2 >> diffSeparator [

	^ '——————————————————
	
'
]

{ #category : #private }
SingleCodeCriticResultList2 >> diffTextForChange: aRefactoryChange [
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

{ #category : #private }
SingleCodeCriticResultList2 >> falsePositiveColor [
	^ Color darkGray
]

{ #category : #private }
SingleCodeCriticResultList2 >> formatCritic: aCritic [
	
	^  String streamContents: [:s | aCritic sourceAnchor entity criticNameOn: s ]

]

{ #category : #private }
SingleCodeCriticResultList2 >> iconFor: anItem [
	
	^  (cache isFalsePositive: anItem forRule: rule) 
			ifFalse: [(cache isToDo: anItem forRule: rule)
				ifTrue: [ self class wrenchOrangeIcon ]
				ifFalse: [ self class exclamationIcon ] ]
]

{ #category : #menu }
SingleCodeCriticResultList2 >> implementorsOfCritic [
	criticsPresenter selectedItem ifNotNil: [ :item | item browse] 

]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initialize [

	super initialize.
	self initializeShortcuts
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initializeDisplayCritic: aCritic forRule: aRule [
	
	| criticRepresentation | 
	self flag: #migrate.
	criticRepresentation := (self formatCritic: aCritic) asMorph.
	^ (cache isFalsePositive: aCritic forRule: aRule) 
			ifTrue: [ criticRepresentation color: self falsePositiveColor ]
			ifFalse: [ (cache isToDo: aCritic forRule: aRule)
						ifTrue: [ criticRepresentation color: self toDoColor ]
						ifFalse: [ criticRepresentation color: self defaultColor ]]
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initializePresenter [
	sourceCodePresenter acceptBlock: self sourceCodePresenterAcceptAction.
	criticsPresenter
		whenSelectedItemChanged: self criticsPresenterSelectionChangeAction.
	textInputFieldPresenter
		acceptBlock: self textInputFieldPresenterAction.
	toolbarPresenter
		whenFalsePositiveClickedDo: [ self addCriticToFalsePositive ]
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initializeShortcuts [
	criticsPresenter bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initializeTextInputFieldPresenter [
	textInputFieldPresenter
		autoAccept: true;
		placeholder: 'Search field';
		text: ' ';
		removeEntryCompletion.
	
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> initializeWidgets [
	criticsPresenter := self newList.
	sourceCodePresenter := self newCode.
	toolbarPresenter := self instantiate: CriticToolbar2.
	textInputFieldPresenter := self newTextInput.	"usefull useless ?"
	criticsPresenter beMultipleSelection.
	self initializeTextInputFieldPresenter.
	criticsPresenter
		displayBlock: [ :selec | self initializeDisplayCritic: selec forRule: rule ].
	criticsPresenter contextMenu: [ :a :b | self menu: a shifted: b ].
	criticsPresenter icons: [ :item | self iconFor: item ].
	self focusOrder
		add: criticsPresenter;
		add: toolbarPresenter;
		add: sourceCodePresenter
]

{ #category : #menu }
SingleCodeCriticResultList2 >> menu: aMenu shifted: aBoolean [
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

{ #category : #menu }
SingleCodeCriticResultList2 >> removeCriticToFalsePositive [
	
	criticsPresenter selectedItems
		ifNotNil: [ :items | items do: [ :item |
			cache removeFalsePositive: item forRule: rule ]].
	
]

{ #category : #menu }
SingleCodeCriticResultList2 >> removeCriticToToDo [

	criticsPresenter selectedItems
		ifNotNil: [:items | items do: [ :item |
			cache removeToDo: item forRule: rule ]].
	
	
]

{ #category : #menu }
SingleCodeCriticResultList2 >> removeRuleToFalsePositive [

	criticsPresenter selectedItems ifNotNil: [ :criticss |
		criticss do: [ :critic |
			cache removeFalsePositiveRule: rule forPackage: critic sourceAnchor entity mcWorkingCopy]].
]

{ #category : #api }
SingleCodeCriticResultList2 >> resetSelection [
	self criticsModel resetSelection
]

{ #category : #accessing }
SingleCodeCriticResultList2 >> rule [
	^ rule
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> rule: aRule [

	rule := aRule.
	(rule isNil or: [ rule isComposite ]) 
		ifTrue: [ ^ self ].	
	self criticsOf:  aRule.
	toolbarPresenter rule: rule.
]

{ #category : #'smartSuggestions - support' }
SingleCodeCriticResultList2 >> selectedMessage [
	^ nil
]

{ #category : #private }
SingleCodeCriticResultList2 >> selectionIntervalFor: aString [
	^ rule result selectionIntervalFor: aString
]

{ #category : #menu }
SingleCodeCriticResultList2 >> sendersOfCritic [
	criticsPresenter selectedItem
		ifNotNil: [ :elem | 
			elem isBehavior
				ifTrue: [ self systemNavigation browseAllCallsOnClass: elem ]
				ifFalse: [ self systemNavigation browseAllSendersOf: elem selector ] ]
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> setTextModelForClassOrMethod: aCritique [

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

{ #category : #initialization }
SingleCodeCriticResultList2 >> setTextModelForNil [

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

{ #category : #initialization }
SingleCodeCriticResultList2 >> setTextModelForTransformationRule: selection [
	
	sourceCodePresenter behavior: nil.
	sourceCodePresenter text: (
		self diffTextForChange: selection change).
	sourceCodePresenter aboutToStyle: false.

									
					
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> sourceCodePresenterAcceptAction [
	| selectedItem |
	^ [ :text | 
	selectedItem := criticsPresenter selection selectedItem sourceAnchor
		entity.
	(selectedItem isCompiledMethod and: [ rule isTransformationRule not ])
		ifTrue: [ selectedItem methodClass compile: text ]
		ifFalse: [ Smalltalk compiler evaluate: text ] ]
]

{ #category : #accessing }
SingleCodeCriticResultList2 >> textInputFieldModel [
	^ textInputFieldPresenter
]

{ #category : #initialization }
SingleCodeCriticResultList2 >> textInputFieldPresenterAction [
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

{ #category : #accessing }
SingleCodeCriticResultList2 >> textModel [
	^ sourceCodePresenter
]

{ #category : #private }
SingleCodeCriticResultList2 >> toDoColor [
	^ Color orange
]

{ #category : #accessing }
SingleCodeCriticResultList2 >> toolbarPresenter [
	^ toolbarPresenter
]

{ #category : #menu }
SingleCodeCriticResultList2 >> transformCritic [
	
	criticsPresenter selectedItems ifNotNil: [ :items |
		items do: [:critic | critic change execute ]  displayingProgress: [:critic|]]
]

{ #category : #thread }
SingleCodeCriticResultList2 >> updateList [

	self criticsOf: rule.
	thread ifNotNil: [ thread terminate ].
	thread := [ UIManager default defer:  [ criticsPresenter updateList ]] fork.
]
