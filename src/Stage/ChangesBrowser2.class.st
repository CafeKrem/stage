Class {
	#name : #ChangesBrowser2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'diff',
		'scopeChooser',
		'changes',
		'table',
		'selectedChanges'
	],
	#category : #'Stage-things'
}

{ #category : #shortcuts }
ChangesBrowser2 class >> buildShortcutsOn: aBuilder [
	<keymap>

	(aBuilder shortcut: #close)
		category: #ChangesBrowserGlobalShortcuts
		default: PharoShortcuts current cancelShortcut
		do: [ :target | target cancel ]
		description: 'Close this dialog'.
		
	(aBuilder shortcut: #accept)
		category: #ChangesBrowserGlobalShortcuts
		default: PharoShortcuts current acceptShortcut
		do: [ :target | target accept ]
		description: 'Accept the proposed changes'.
]

{ #category : #'instance creation' }
ChangesBrowser2 class >> changes: aCollection [

	^ self new
		changes: aCollection;
		yourself
]

{ #category : #specs }
ChangesBrowser2 class >> defaultSpec [
	<spec>
	^ SpecBoxLayout newVertical
		add: #table;
		"addSplitter;"
			add: #diff
]

{ #category : #accessing }
ChangesBrowser2 class >> main [
	<script>
		self new openDialogWithSpec.
]

{ #category : #specs }
ChangesBrowser2 class >> title [

	^ 'Changes Browser'
]

{ #category : #visiting }
ChangesBrowser2 >> accept [
	self okToChange
		ifFalse: [ ^ self ].
	[ self pickedChanges do: [ :change | RBRefactoryChangeManager instance performChange: change ] ] asJob
		title: 'Refactoring';
		run.
	self window delete
]

{ #category : #private }
ChangesBrowser2 >> buildDiffFor: aChange [
	diff 
		leftText: aChange oldVersionTextToDisplay;
		rightText: aChange textToDisplay
]

{ #category : #api }
ChangesBrowser2 >> cancel [
	
	self window  delete
]

{ #category : #accessing }
ChangesBrowser2 >> changes [
	^ changes
]

{ #category : #accessing }
ChangesBrowser2 >> changes: aCollection [
	changes := aCollection.
	self updateChanges
]

{ #category : #accessing }
ChangesBrowser2 >> diff [
	^ diff
]

{ #category : #initialization }
ChangesBrowser2 >> initializePresenter [
	table
		whenSelectionChangedDo:
			[ :item | item ifNotNil: [ self buildDiffFor: 
				(item widget items at: (item selectedIndex))] ]
]

{ #category : #initialization }
ChangesBrowser2 >> initializeTable [
	"self flag: #NeedCheckBoxColumn.
	table addColumn: (StringTableColumn title: 'method?/ something ' evaluated: #name )
	""add: (CheckBoxColumn)"
	table addColumn:
		((CheckBoxTableColumn title: ' ' evaluated: [ :class | selectedChanges includes: class ])
				onActivation: [ :class | selectedChanges add: class.
					self buildDiffFor: class ];
				onDesactivation: [ :class | selectedChanges remove: class ];
				width: 20;
				yourself);
			addColumn:  (StringTableColumn title: 'Name' evaluated: #name);
			beResizable.
	self whenBuiltDo: [ selectedChanges := table items ]
]

{ #category : #initialization }
ChangesBrowser2 >> initializeWidgets [

	selectedChanges := OrderedCollection new.
	table := self newTable.
	diff := self newDiff.
	
	self initializeTable.
	self setFocus.
	self
		bindKeyCombination: PharoShortcuts current acceptShortcut toAction: [ self accept ];
		bindKeyCombination: Character escape toAction: [ self cancel ]
	
]

{ #category : #opening }
ChangesBrowser2 >> open [
	^ self openDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ];
		yourself
]

{ #category : #accessing }
ChangesBrowser2 >> pickedChanges [
	
	^ table items select: [ :i | selectedChanges includes: i ]
]

{ #category : #accessing }
ChangesBrowser2 >> scopeChooser [
	self flag:#NobodyUse.
	^ scopeChooser
		ifNil: [ 
			scopeChooser := self instantiate: EnvironmentChooser.
			scopeChooser
				whenEnvironmentChanged: [ self updateChanges ];
				label: 'Scope:'.
			scopeChooser ]
]

{ #category : #initialization }
ChangesBrowser2 >> setFocus [
	self focusOrder
		add: table;
		add: diff;
		yourself
]

{ #category : #initialization }
ChangesBrowser2 >> setShortcuts [
	self flag:#NobodyUse.
	"self changesTree(replace by table) attachKeymapCategory: #ChangesBrowserGlobalShortcuts targetting: self"
	
]

{ #category : #accessing }
ChangesBrowser2 >> table [
	^ table
]

{ #category : #private }
ChangesBrowser2 >> updateChanges [
	| aCompositeChange |
	self flag:#NeedCheckBoxColumn.
	aCompositeChange := RBRefactoryChangeManager changeFactory
		compositeRefactoryChange.
	changes do: [ :each | aCompositeChange addChange: each ].

	"Filter the shown changes depending on the selected scope"
	table items: (aCompositeChange whatToDisplayIn: self)
]
