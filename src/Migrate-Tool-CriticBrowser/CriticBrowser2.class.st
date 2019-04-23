Class {
	#name : #CriticBrowser2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'criticModel',
		'rulesModel',
		'checker',
		'title',
		'rbEnvironment',
		'removeTestCase',
		'cache',
		'resetButton',
		'logButton',
		'updateButton'
	],
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #menu }
CriticBrowser2 class >> criticsBrowserMenuOn: aBuilder [ 
	<worldMenu>
	
	(aBuilder item: 'Critic Browser')
		action: [ self openOnCurrentWorkingConfiguration];
		order: 310;
		parent: #Tools;
		help: 'To manage rule checks.';
		icon: self icon
]

{ #category : #specs }
CriticBrowser2 class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed 
		newColumn: [:c |
			c 
				newRow: [:r |
					r 
						newColumn: [:c1 |
							c1 add: #rulesModel.
							c1 newRow: [:c2 |
								c2 add: #resetButton.
								c2 add: #updateButton.
								c2 add: #logButton
							] height: 25
						];
						newColumn: [:c1 |
							c1 
								add: #(criticModel textInputFieldModel) height: 20;
								add: #(criticModel criticsModel);
								add: #(criticModel toolbarModel) height: 25 ]];
				addSplitter;
				add: #(criticModel textModel) ]
]

{ #category : #icons }
CriticBrowser2 class >> icon [
	"Answer an icon for the receiver."

	^ self iconNamed: #smallWarningIcon
]

{ #category : #examples }
CriticBrowser2 class >> main [ 
	<example>
	^ self new openWithSpec
]

{ #category : #'instance creation' }
CriticBrowser2 class >> open [

	| env rules |
	rules :=  RBCompositeLintRule allGoodRules rules.
	env := RBBrowserEnvironment default.
	self openOnRule: rules onEnvironment: env
]

{ #category : #menu }
CriticBrowser2 class >> openOnCurrentWorkingConfiguration [

	CriticWorkingConfiguration exists
		ifTrue: [ ResetWindow new openWithSpec ]
		ifFalse: [ SelectPackageBrowser open]
]

{ #category : #'instance creation' }
CriticBrowser2 class >> openOnRule: aRule onEnvironment: aEnv [

	| cbr |
	cbr :=  self new rules: aRule;
		environment: aEnv;
		removeTestCase: false;
		yourself.

	cbr openWithSpec.
	cbr applyRules. 
	cbr rulesModel changed:  #listElementAt:
]

{ #category : #'instance creation' }
CriticBrowser2 class >> openOnWorkingConfiguration: aWorkingConfiguration [

	| cbr |
	cbr := self new 
		rules: aWorkingConfiguration rule;
		environment: aWorkingConfiguration environment;
		removeTestCase: aWorkingConfiguration removeTestCase;
		yourself.

	cbr openWithSpec.
	cbr applyRules. 
	cbr rulesModel  changed:  #listElementAt:
]

{ #category : #icons }
CriticBrowser2 class >> taskbarIconName [

	^#smallWarningIcon
]

{ #category : #menu }
CriticBrowser2 class >> theme [
	^ Smalltalk ui theme 
]

{ #category : #'user interface' }
CriticBrowser2 >> addModelItemsToWindowMenu: aMenu [
	"Add model-related items to the window menu"

	aMenu
		addLine;
		add: 'Clean all manifest' target: checker selector: #cleanAllManifest;
		add: 'Reapply all  rules' target: self selector: #reapplyAllRules
]

{ #category : #private }
CriticBrowser2 >> addRuleToFalsePositive [
	rulesModel selectedItem ifNotNil: [ :rule |
		rule leaves do: [ :r |
			rbEnvironment packages do: [ :package |
				cache addFalsePositiveRule: r forPackage: package ]]].
	
]

{ #category : #private }
CriticBrowser2 >> allRules [
	^ rulesModel roots flatCollect: #rules
]

{ #category : #private }
CriticBrowser2 >> applyRules [
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
			self setTitle: windowTitle.
			checker
				runRules: rules
				onPackage: package
				withoutTestCase: removeTestCase ].
	checker rule: rules.
	self setTitle: self defaultTitle.
	cache packages: rbEnvironment.
	cache initCache.
	self updateTree.
	self registerToAnnouncements ] newProcess.
	process name: 'SmallLint'.
	process resume
]

{ #category : #private }
CriticBrowser2 >> browseRule [

	rulesModel selectedItem ifNotNil: [ :item | item content browse ]
]

{ #category : #'system annoucements' }
CriticBrowser2 >> classAdded: aClass [

	| rules |

	(rbEnvironment definesClass: aClass) ifFalse: [ ^ self ].

	rules := self allRules.
	checker
		resetResult;
		checkClass: aClass.
		
	rules do: [ :rule |		
		(checker criticsOf: rule) do:	[ :crit |
			cache addCritic: crit forRule: rule ].
		(checker falsePositiveOf: rule) do:	[ :crit |
			cache addFalsePositive: crit forRule: rule ].
		(checker toDoOf: rule) do:	[ :crit |
			cache addToDo: crit forRule: rule ] ].
	
	cache updateBrowser.
]

{ #category : #'system annoucements' }
CriticBrowser2 >> classRemoved: aClass [

	(rbEnvironment definesClass: aClass)
		ifTrue: [ cache itemRemoved: aClass ].
		
	cache updateBrowser
]

{ #category : #private }
CriticBrowser2 >> colorForRule: aRule [
	| total |
	^ (total := cache criticsOf: aRule)
		ifEmpty: [ self class theme textColor ]
		ifNotEmpty: [ (cache falsePositiveOf: aRule) = total
				ifTrue: [ criticModel falsePositiveColor ]
				ifFalse: [ criticModel defaultColor ]]
]

{ #category : #accessing }
CriticBrowser2 >> criticModel [
	^ criticModel
]

{ #category : #api }
CriticBrowser2 >> defaultTitle [

	^ 'Critic Browser'
]

{ #category : #accessing }
CriticBrowser2 >> environment [
	^ rbEnvironment

]

{ #category : #accessing }
CriticBrowser2 >> environment: aEnv [
	rbEnvironment := aEnv

]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleClassAdded: anAnnouncement [

	self classAdded: anAnnouncement classAdded

]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleClassModified: anAnnouncement [

	self
		classRemoved: anAnnouncement oldClassDefinition;
		classAdded: anAnnouncement newClassDefinition
	
]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleClassRemoved: anAnnouncement [

	self classRemoved: anAnnouncement classRemoved

]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleMethodAdded: anAnnouncement [

	self methodAdded: anAnnouncement methodAdded

]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleMethodModified: anAnnouncement [

	self
		methodRemoved: anAnnouncement oldMethod;
		methodAdded: anAnnouncement newMethod
	

]

{ #category : #'system annoucements' }
CriticBrowser2 >> handleMethodRemoved: anAnnouncement [

	self methodRemoved: anAnnouncement methodRemoved

]

{ #category : #api }
CriticBrowser2 >> initialExtent [

	^ 760@370
]

{ #category : #initialization }
CriticBrowser2 >> initialize [
	
	super initialize.
	cache := ReCriticsCache new.
	checker := ReSmalllintChecker new.
	cache checker: checker.
	cache browser: self.
	criticModel cache: cache
]

{ #category : #initialization }
CriticBrowser2 >> initializePresenter [
	rulesModel
		whenSelectedItemChangedDo: [ :rule | 
			(rule isNil or: [ rule isComposite ])
				ifFalse: [ criticModel
						resetSelection;
						rule: rule;
						setTextModelForNil ].
			self
				setTitle: (rule ifNil: [ self defaultTitle ] ifNotNil: [ rule name ]) ]
]

{ #category : #initialization }
CriticBrowser2 >> initializeWidgets [

	title := self defaultTitle.
	rulesModel := self newTree."deprecate"
	resetButton := self newButton.
	updateButton := self newButton.
	logButton := self newButton.
	
	self setLogButton.
	self setResetButton.
	self setUpdateButton.
	 
	criticModel := SingleCodeCriticResultList new.
	rulesModel childrenBlock: [ :rule | 
		rule isComposite 
			ifTrue: [ rule rules ]
			ifFalse: [ #() ]]. 

	rulesModel displayBlock: [ :rule | self stringMorphForRule: rule ].
	
	rulesModel menu: [ :aMenu :shifted | self menu: aMenu shifted: shifted ].	
	
	self focusOrder
		add: rulesModel;
		add: criticModel
]

{ #category : #accessing }
CriticBrowser2 >> logButton [
	^ logButton 
]

{ #category : #private }
CriticBrowser2 >> logInManifest [
	cache logInManifest
]

{ #category : #menu }
CriticBrowser2 >> menu: aMenu shifted: aBoolean [
	aMenu
		addGroup:[ :group | 
			group addItem: [ :item |
				item 
					name: 'Browse rule' translated;
					action: [ self browseRule ]].
			group addItem: [ :item |
				item 
					name: 'Reapply this rule' translated;
					action: [ self reapplyThisRule ] ] ];
		addGroup:[ :group | 
			group addItem: [ :item |
				item 
					name: 'Ban from selected packages' translated;
					action: [ self addRuleToFalsePositive ]].
			group addItem: [ :item |
				item 
					name: 'Unban from selected packages' translated;
					action: [ self removeRuleToFalsePositive ] ] ].
		
	 ^ aMenu
]

{ #category : #'system annoucements' }
CriticBrowser2 >> methodAdded: aMethod [

	| rules |

	(rbEnvironment includesMethod: aMethod) ifFalse: [ ^ self ].

	rules := self allRules.
	checker
		resetResult;
		getCritiquesAbout: aMethod by: (rules select: [ :r | r class checksMethod ]).

	rules do: [ :rule |		
		(checker criticsOf: rule) do:	[ :crit |
			cache addCritic: crit forRule: rule ].
		(checker falsePositiveOf: rule) do:	[ :crit |
			cache addFalsePositive: crit forRule: rule ].
		(checker toDoOf: rule) do:	[ :crit |
			cache addToDo: crit forRule: rule ] ].
	
	cache updateBrowser.
]

{ #category : #'system annoucements' }
CriticBrowser2 >> methodRemoved: aMethod [

	(rbEnvironment includesMethod: aMethod)
		ifTrue: [ cache itemRemoved: aMethod ].
		
	cache updateBrowser
]

{ #category : #api }
CriticBrowser2 >> onWindowClosed [

	self unregisterFromAnnouncements.

	cache cacheChange 
		ifTrue: [	
			(UIManager default confirm: 'Do you want log all wrong violations in the Manifests
before closing the Critics Browser ?')
				ifTrue: [ cache logInManifest ]].
	

]

{ #category : #display }
CriticBrowser2 >> open [

	^ self openWithSpec
]

{ #category : #private }
CriticBrowser2 >> reapplyAllRules [
	
	cache initialize.
	self applyRules 
]

{ #category : #private }
CriticBrowser2 >> reapplyRule: aRule [

	cache removeRule: aRule.
	checker resetResult.
	rbEnvironment packages do: [ :package | 
		checker runRules: { aRule } onPackage: package withoutTestCase: removeTestCase ]. 
	(checker criticsOf: aRule) do:	[ :crit |
		cache addCritic: crit forRule: aRule ].
	(checker falsePositiveOf: aRule) do:	[ :crit |
		cache addFalsePositive: crit forRule: aRule ].
	(checker toDoOf: aRule) do:	[ :crit |
		cache addToDo: crit forRule: aRule ].	
	
	cache updateBrowser
]

{ #category : #private }
CriticBrowser2 >> reapplyThisRule [

	| rule |
	rulesModel selectedItem ifNil: [ ^ self ].
	rule := rulesModel selectedItem content.
	rule isComposite 
		ifTrue: [ rule rules do: [ :each | self reapplyRule: each ] ]
		ifFalse: [ self reapplyRule: rule ]
	

]

{ #category : #'system annoucements' }
CriticBrowser2 >> registerToAnnouncements [
	
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

{ #category : #private }
CriticBrowser2 >> removeRuleToFalsePositive [

	rulesModel selectedItem ifNotNil: [ :rule |
		rule leaves do: [ :r |
			rbEnvironment packages do: [ :package |
				 cache removeFalsePositiveRule: r forPackage: package ]]]

	
	
]

{ #category : #accessing }
CriticBrowser2 >> removeTestCase: aBoolean [
	removeTestCase :=  aBoolean
]

{ #category : #accessing }
CriticBrowser2 >> resetButton [
	^ resetButton 
]

{ #category : #accessing }
CriticBrowser2 >> rules: rulesCollection [

	self rulesModel roots: ((
		(rulesCollection groupedBy: #group) associations collect: [ :as |
			CriticBrowserRulesGroup
				named: as key
				rules: as value ])
					sorted: [ :a :b | a name < b name ])
]

{ #category : #accessing }
CriticBrowser2 >> rulesModel [

	^ rulesModel
]

{ #category : #initialization }
CriticBrowser2 >> setActionLogButton [
	^ [ (UIManager default
		confirm:
			'Do you want to save all false positive and toDo in the Manifests ?
(this action may generate new manifest classes and make dirty your package)')
		ifTrue: [ cache logInManifest ] ]
]

{ #category : #initialization }
CriticBrowser2 >> setActionResetButton [
	
	^ [(UIManager default confirm: 'Do you want to delete the current configuration
 and create a new configuration ?')
		ifTrue: [ self delete. 
				SelectPackageBrowser open ]]
]

{ #category : #initialization }
CriticBrowser2 >> setActionUpdateButton [
	^ [ self reapplyAllRules ]
]

{ #category : #initialization }
CriticBrowser2 >> setLogButton [

	logButton 
		state: false;
		label: 'Save Critics';
		action: self setActionLogButton 
]

{ #category : #initialization }
CriticBrowser2 >> setResetButton [

	resetButton 
		state: false;
		label: 'Run new configuration';
		action: self setActionResetButton
]

{ #category : #api }
CriticBrowser2 >> setTitle: aTitle [

	title := aTitle.
	
	self window updateTitle 
	
]

{ #category : #initialization }
CriticBrowser2 >> setUpdateButton [

	updateButton 
		state: false;
		label: 'Update';
		action: self setActionUpdateButton.
]

{ #category : #private }
CriticBrowser2 >> stringMorphForRule: rule [
	| unclassified falsePositives toDos text total |
	falsePositives := (cache falsePositiveOf: rule) size.
	toDos := (cache toDosOf: rule) size.
	total := (cache criticsOf: rule) size.
	unclassified := total - falsePositives - toDos.
	text := String
		streamContents: [ :s | 
			s
				<< rule name;
				<< ' (To sort: ';
				print: unclassified;
				<< ', ToDo: ';
				print: toDos;
				<< ', Wrong: ';
				print: falsePositives;
				<< ')' ].
	^ text asMorph
		color: (self colorForRule: rule);
		yourself
		
]

{ #category : #api }
CriticBrowser2 >> title [
	^ title
]

{ #category : #'system annoucements' }
CriticBrowser2 >> unregisterFromAnnouncements [

	SystemAnnouncer uniqueInstance unsubscribe: self
]

{ #category : #accessing }
CriticBrowser2 >> updateButton [
	^ updateButton 
]

{ #category : #thread }
CriticBrowser2 >> updateTree [
	criticModel updateList. 
	rulesModel updateTree
]
