Class {
	#name : #ChangesBrowser2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'textArea',
		'scopeChooser',
		'changes',
		'table'
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
			add: #textArea
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

	^ aChange
		ifNil: [ '' ]
		ifNotNil: [
			TextDiffBuilder 
				buildDisplayPatchFrom: aChange oldVersionTextToDisplay 
				to: aChange textToDisplay ].
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

{ #category : #initialization }
ChangesBrowser2 >> initializePresenter [
	textArea 
		bindKeyCombination: Character tab toAction: [ self giveFocusToNextFrom: textArea ];
		bindKeyCombination: Character tab shift toAction: [ self giveFocusToPreviousFrom: textArea ].
	self
		bindKeyCombination: PharoShortcuts current acceptShortcut toAction: [ self accept ];
		bindKeyCombination: Character escape toAction: [ self cancel ]
	
]

{ #category : #initialization }
ChangesBrowser2 >> initializeTable [
	self flag: #NeedCheckBoxColumn.
	table addColumn: (StringTableColumn title: 'method?/ something ' evaluated: #name )
	"add: (CheckBoxColumn)"
]

{ #category : #initialization }
ChangesBrowser2 >> initializeTextArea [
	textArea 
		enabled: false.
]

{ #category : #initialization }
ChangesBrowser2 >> initializeWidgets [

	table := self newTable.
	textArea := self newCode.
	
	self initializeTable.
	self initializeTextArea.
	self setFocus.
	
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
	| selectedItems |
	self flag:#NeedCheckBoxColumn.
	selectedItems := table selectedItems collect: #content.
	^ table items select: [ :i | selectedItems includes: i ]
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
		add: textArea;
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

{ #category : #accessing }
ChangesBrowser2 >> textArea [
	^ textArea
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
