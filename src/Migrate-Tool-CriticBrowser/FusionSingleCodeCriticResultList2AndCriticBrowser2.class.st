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
		'cache',
		'criticsPresenter',
		'sourceCodePresenter',
		'rulesPresenter',
		'rbEnvironment',
		'removeTestCase',
		'criticsActionsPresenter',
		'rulesActionsPresenter'
	],
	#category : #'Migrate-Tool-CriticBrowser-main'
}

{ #category : #specs }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> defaultSpec [
	^ SpecPanedLayout newVertical
		add:
			(SpecPanedLayout newHorizontal
				add:
					(SpecBoxLayout newVertical
						add: #rulesPresenter;
						add: #rulesActionsPresenter
							withConstraints: [ :element | element height: self buttonHeight ];
						yourself);
				add:
					(SpecBoxLayout newVertical
						add: #criticsPresenter;
						add: #criticsActionsPresenter
							withConstraints: [ :element | element height: self buttonHeight ];
						yourself);
				yourself)
			withConstraints: [ :elt | 
				elt
					beNotResizable;
					beShrinkable ];
		add: #sourceCodePresenter;
		yourself
]

{ #category : #'instance creation' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> open [
	<example>
	| env rules |
	rules := RBCompositeLintRule allGoodRules rules.
	env := RBBrowserEnvironment default.
	self openOnRule: rules onEnvironment: env
]

{ #category : #'instance creation' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> openOnRule: aRule onEnvironment: aEnv [
	| cbr |
	cbr := self new
		rules: aRule;
		environment: aEnv;
		removeTestCase: false;
		yourself.
	cbr applyRules.
	cbr openWithSpec
]

{ #category : #specs }
FusionSingleCodeCriticResultList2AndCriticBrowser2 class >> title [

	^ 'Critic Browser'
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addCriticToToDo [
	criticsPresenter selectedItems
		ifNotNil:
			[ :items | items do: [ :item | cache addToDo: item forRule: self rule ] ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addFalsePositive: aCritic forRule: aRule [
	cache addFalsePositive: aCritic forRule: aRule
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addFalsePositiveRule: aRule forPackage: aPackage [
	cache addFalsePositiveRule: aRule forPackage: aPackage
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addMarkingMenuItemsTo: aMenu [
	(criticsPresenter selectedItems anySatisfy: [ :critic | cache isFalsePositive: critic forRule: self rule ]) 
		ifTrue: [ aMenu add: 'Unmark as wrong' target: self selector: #removeCriticToFalsePositive ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | (cache isFalsePositive: critic forRule: self rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as wrong' target: self selector: #addCriticToFalsePositive ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | cache isToDo: critic forRule: self rule ]) 
		ifTrue: [ aMenu add: 'Unmark as TODO' target: self selector: #removeCriticToToDo ].
	(criticsPresenter selectedItems anySatisfy: [ :critic | (cache isToDo: critic forRule: self rule) not ]) 
		ifTrue: [ aMenu add: 'Mark as TODO' target: self selector: #addCriticToToDo ].
	
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addNavigationMenuItemsTo: aMenu [

	criticsPresenter selectedItem ifNotNil: [ :critique |
		critique sourceAnchor entity populateCBMenu: aMenu ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> addToDo: aCritic forRule: aRule [
	cache addToDo: aCritic forRule: aRule
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> allPackages [ 
	^ rbEnvironment packages
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> allRules [
	^ rulesPresenter roots flatCollect: #rules
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> applyRules [
	| rules checker |
	rules := self allRules.
	checker := cache checker.
	rbEnvironment packages
		do: [ :package | 
			checker
				runRules: rules
				onPackage: package
				withoutTestCase: removeTestCase.
			checker rule: rules.
			cache packages: rbEnvironment.
			cache initCache.
			self registerToAnnouncements ]
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> cache:  acache [ 
	cache := acache
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticMenuGenerator [
	| aMenu |
	"this is your generat Menu from Architecture CBAbstractCriticMenu"
	aMenu := self menuGenerator: CBAbstractCriticMenu.
	"and now i add all action from Critic it's ugly but i depend on ReProperty in package: renraku" 
	criticsPresenter selection selectedItem actions
		do: [ :aCritic | 
			aMenu
				addItem: [ :newItem | 
					newItem
						name: aCritic description;
						icon: nil;
						action: aCritic action ] ].

	^ aMenu
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsOf: aRule [
	^ cache criticsOf: aRule
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsPresenter [
	^ criticsPresenter
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> criticsPresenterAction [
	criticsPresenter
		transmitTo: sourceCodePresenter
		transform: [ :selection | 
			selection
				ifNotNil: [ selection providesChange
						ifTrue: [ self diffTextForChange: selection change ]
						ifFalse: [ | entity |
							entity := selection sourceAnchor entity.
							(entity respondsTo: #definition)
								ifTrue: [ entity definition ]
								ifFalse: [ entity asString ] ] ] ]
		postTransmission: [ :dest :origin :location | 
			origin selection selectedItem
				ifNotNil: [ :critic | 
					critic providesChange
						ifTrue: [ dest behavior: nil ]
						ifFalse: [ | entity |
							entity := critic sourceAnchor entity.
							self
								flag:
									'Another hack. We need a better way to display entities (because now we may get not only classes and methods. Maybe something like GTInspector presentations could work)'.
							dest
								behavior:
									(entity isCompiledMethod
										ifTrue: [ entity methodClass ]
										ifFalse: [ nil ]).
							critic sourceAnchor providesInterval
								ifTrue: [ dest setSelection: critic sourceAnchor interval ] ] ] ]
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
	self flag: #pharoTodo. "It is weird than in a branch of the condition there is no icon returned"
	^ (cache isFalsePositive: anItem forRule: self rule)
		ifFalse: [ self
				iconNamed:
					((cache isToDo: anItem forRule: self rule)
						ifTrue: [ #repair ]
						ifFalse: [ #error ]) ]
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initialize [
	super initialize.
	self initializeShortcuts.
	cache := ReCriticsCache new.
	cache checker: ReSmalllintChecker new.
	cache browser: self
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeCriticsPresenter [
	criticsPresenter
		displayBlock: [ :selec |  selec sourceAnchor entity  ];
		itemFilterBlock: [ :item :string |  '*' , string , '*' match: item contents ];
		contextMenu: [ self criticMenuGenerator ];
		icons: [ :item | self iconFor: item ]
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializePresenter [
	self criticsPresenterAction.
	self rulesPresenterActions.
	self sourceCodePresenterAction
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeRulesPresenter [
	rulesPresenter
		addColumn:
			(StringTableColumn new
				title: 'rules';
				evaluated: #name;
				yourself);
		addColumn:
			(StringTableColumn new
				width: 40;
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
				ifFalse: [ #() ] ];
		contextMenu: (self menuGenerator: CBAbstractRuleMenu)
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeShortcuts [
	self flag: 'last element to migrate'.
	criticsPresenter bindKeyCombination: PharoShortcuts current browseShortcut toAction: [ self browseCritic ]
]

{ #category : #initialize }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> initializeWidgets [
	criticsPresenter := self newList.
	sourceCodePresenter := self newCode.
	criticsActionsPresenter := self newActionBar.
	rulesActionsPresenter := self newActionBar.
	rulesPresenter := self newTreeTable.
	CBAbstractRuleAction actions
		do: [ :class | rulesActionsPresenter add: (self newButtonFor: class) ].
	CBAbstractCriticAction actions
		do: [ :class | criticsActionsPresenter add: (self newButtonFor: class) ].
	self initializeRulesPresenter.
	self initializeCriticsPresenter
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> isFalsePositive: aCritic forRule: aRule [
	
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> isSelectedCriticIsToDo [
	^ cache isToDo: self selectedCritic forRule: self selectedRule
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> isSelectedRuleIsFalsePositive [
	^ cache
		isFalsePositive: self selectedCritic
		forRule: self selectedRule
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> logInManifest [
	cache logInManifest 
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> markAsFalsePositiveForCurrentRule: aCritic [
	1halt.
	cache addFalsePositive: aCritic forRule: self rule
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> menuGenerator: aClassName [
	| newMenu |
	newMenu := MenuPresenter new.
	(aClassName actionsMenu)
		do:
			[ :aCBGroupMenu | newMenu addGroup: (self menuGroupGenerator: aCBGroupMenu) ].
	^ newMenu
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> menuGroupGenerator: aGroupClass [
	^ [ :newGroup | 
	aGroupClass actionsGroup
		do: [ :item | newGroup addItem: (self menuItemGenerator: item) ] ]
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> menuItemGenerator: anItem [
	^ [ :newItem | 
	newItem
		name: anItem title;
		action: [ anItem runOn: self ];
		icon: anItem icon;
		yourself ]
]

{ #category : #'initialize-widgets' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> newButtonFor: aClass [ 
	^ self newButton 
		label: aClass title;
		action: [ aClass runOn: self ];
		yourself
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> reapplyAllRules [
	cache initialize.
	self applyRules
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> reapplyRule: aRule [
	cache removeRule: aRule.
	cache checker resetResult.
	rbEnvironment packages
		do: [ :package | 
			cache checker
				runRules: {aRule}
				onPackage: package
				withoutTestCase: removeTestCase ].
	(cache checker criticsOf: aRule)
		do: [ :crit | cache addCritic: crit forRule: aRule ].
	(cache checker falsePositiveOf: aRule)
		do: [ :crit | cache addFalsePositive: crit forRule: aRule ].
	(cache checker toDoOf: aRule)
		do: [ :crit | cache addToDo: crit forRule: aRule ].
	cache updateBrowser
]

{ #category : #'system annoucements' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> registerToAnnouncements [
	 
	self unregisterFromAnnouncements.
	self flag:'to do when finish'.
	"SystemAnnouncer uniqueInstance weak
		when: ClassAdded send: #handleClassAdded: to: self;
		when: ClassModifiedClassDefinition send: #handleClassModified: to: self;
		when: ClassRemoved send: #handleClassRemoved: to: self;
		when: MethodAdded send: #handleMethodAdded: to: self;
		when: MethodModified send: #handleMethodModified: to: self;
		when: MethodRemoved send: #handleMethodRemoved: to: self.
	self window window announcer when: WindowClosed send: #onWindowClosed to: self"
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeFalsePositive: aCritic forRule: aRule [
	cache removeFalsePositive: self selectedCritic forRule: self selectedRule. 
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeFalsePositiveRule: aRule forPackage: aPackage [
	cache removeFalsePositiveRule: aRule forPackage: aPackage
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeTestCase: aBoolean [
	removeTestCase := aBoolean 
]

{ #category : #menu }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> removeToDo: aCritic forRule: aRule [
	cache removeToDo: aCritic forRule: aRule
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> rule [
	^ self rulesPresenter selection selectedItem
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
				ifFalse: [ (cache criticsOf: aRule) sorted: #printString ascending ] ]
		postTransmission: [ :destination | destination selectIndex: 0 ].
	rulesPresenter
		transmitTo: sourceCodePresenter
		transform: [ :aRule | 
			(aRule isNil or: [ aRule isComposite ])
				ifTrue: [ '' ]
				ifFalse: [ aRule rationale ] ].
	rulesPresenter selectPath: #(1)
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> selectedCritic [
	^ criticsPresenter selection selectedItem
]

{ #category : #TOCATEGORISE }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> selectedRule [
	^ rulesPresenter selectedItem
]

{ #category : #private }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> selectionIntervalFor: aString [
	^ self rule result selectionIntervalFor: aString
]

{ #category : #accessing }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sourceCodePresenter [
	^ sourceCodePresenter
]

{ #category : #'initialize-actions' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> sourceCodePresenterAction [
	| selectedItem |
	self flag: #incomplete.
	sourceCodePresenter
		acceptBlock: [ :text | 
			selectedItem := criticsPresenter selection selectedItem sourceAnchor
				entity.
			selectedItem isCompiledMethod "and: [  self rule isTransformationRule not ]"	
				ifTrue: [ selectedItem methodClass compile: text ]
				ifFalse: [ Smalltalk compiler evaluate: text ]
			"i don't manage all case but isTransformationRule is'nt defined in Rule" ]
]

{ #category : #'system annoucements' }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> unregisterFromAnnouncements [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #api }
FusionSingleCodeCriticResultList2AndCriticBrowser2 >> updateTree [
	rulesPresenter needRebuild: true
]
