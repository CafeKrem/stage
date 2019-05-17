Class {
	#name : #SycRefactoringPreview2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'command',
		'scopes',
		'textArea',
		'changes',
		'scopeDropList',
		'table',
		'selectedCheckBoxs'
	],
	#category : #'Stage-things'
}

{ #category : #shortcuts }
SycRefactoringPreview2 class >> buildShortcutsOn: aBuilder [
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

{ #category : #specs }
SycRefactoringPreview2 class >> defaultSpec [
	<spec>
	^ SpecBoxLayout newVertical
		add: #table;
		add: #scopeDropList withConstraints: [ :x | x height: 30 ];
		add: #textArea
]

{ #category : #'instance creation' }
SycRefactoringPreview2 class >> for: aCommand scopes: scopes [
	^ self new
		command: aCommand;
		scopes: scopes
]

{ #category : #accessing }
SycRefactoringPreview2 class >> main [ 
	<script>
		self new openDialogWithSpec 
]

{ #category : #specs }
SycRefactoringPreview2 class >> title [

	^ 'Refactoring changes'
]

{ #category : #controlling }
SycRefactoringPreview2 >> accept [
	self okToChange
		ifFalse: [ ^ self ].
	[ self pickedChanges 
		do: [ :change | RBRefactoryChangeManager instance performChange: change ] ]
		asJob
		title: 'Refactoring';
		run.
	self window delete
]

{ #category : #accessing }
SycRefactoringPreview2 >> activeRBEnvironment [
	
	^self activeScope asRBEnvironment
]

{ #category : #accessing }
SycRefactoringPreview2 >> activeScope [
	^scopeDropList selectedItem
]

{ #category : #'epicea support' }
SycRefactoringPreview2 >> asEpiceaEvent [

	self flag: #todo. "This is a workaround for a problem found by RewriteTool"
	(changes allSatisfy: [ :each | each respondsTo: #asEpiceaEvent ])
		ifFalse: [ ^ EpCompositeRefactoring withAll: #() ].

	^ changes size > 1
		ifTrue: [ EpCompositeRefactoring withAll: changes ]
		ifFalse: [ changes anyOne asEpiceaEvent ].
]

{ #category : #private }
SycRefactoringPreview2 >> buildDiffFor: aChange [

	^ aChange
		ifNil: [ '' ]
		ifNotNil: [
			TextDiffBuilder 
				buildDisplayPatchFrom: aChange oldVersionTextToDisplay 
				to: aChange textToDisplay ].
]

{ #category : #controlling }
SycRefactoringPreview2 >> cancel [
	self window delete
]

{ #category : #accessing }
SycRefactoringPreview2 >> changes [
	^ changes
]

{ #category : #accessing }
SycRefactoringPreview2 >> changes: aCollection [
	changes := aCollection
]

{ #category : #accessing }
SycRefactoringPreview2 >> changesTree [
	^ table
]

{ #category : #accessing }
SycRefactoringPreview2 >> command [
	^ command
]

{ #category : #accessing }
SycRefactoringPreview2 >> command: aCommand [
	command := aCommand
]

{ #category : #accessing }
SycRefactoringPreview2 >> generateChanges [

	| rbEnvironment |
	changes := command asRefactorings.
	rbEnvironment := self activeRBEnvironment.
	changes do: [ :each | 
		each model environment: rbEnvironment.
		each primitiveExecute ]
]

{ #category : #initialization }
SycRefactoringPreview2 >> initialize [
	selectedCheckBoxs := OrderedCollection new.
	super initialize
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializePresenter [
	table
		transmitTo: textArea
		transform: [ :selectedItem | self buildDiffFor: selectedItem ].
	scopeDropList
		whenSelectedItemChangedDo: [ :scope | scope ifNotNil: [ self updateChanges ] ]
]

{ #category : #'initialize-widgets' }
SycRefactoringPreview2 >> initializeScopeDropList [
	scopeDropList
		displayBlock: [ :scope | scope description capitalized ]
		
]

{ #category : #'initialize-widgets' }
SycRefactoringPreview2 >> initializeTable [
	table
		addColumn:
			((CheckBoxTableColumn
				title: ' '
				evaluated: [ :x | selectedCheckBoxs includes: x ])
				onActivation: [ :class | selectedCheckBoxs add: class ];
				onDesactivation: [ :class | selectedCheckBoxs remove: class ];
				width: 20);
		addColumn: (StringTableColumn title: 'methods' evaluated: [ :x | x name ])
]

{ #category : #'initialize-widgets' }
SycRefactoringPreview2 >> initializeTextArea [
	textArea 
		enabled: false;
		"make sure we can cycle over the text field"
		bindKeyCombination: Character tab toAction: [ self giveFocusToNextFrom: textArea ];
		bindKeyCombination: Character tab shift toAction: [ self giveFocusToPreviousFrom: textArea ].
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializeWidgets [

	table := self newTable.
	textArea := self newCode.
	scopeDropList := self newDropList.
	
	self initializeTable.
	self initializeTextArea.
	self initializeScopeDropList.
	self setShortcuts.
]

{ #category : #'epicea support' }
SycRefactoringPreview2 >> isEpiceaInterestingJobOwner [

	^ true
]

{ #category : #controlling }
SycRefactoringPreview2 >> open [
	^ self openDialogWithSpec
		okAction: [ self accept ];
		cancelAction: [ self cancel ];
		yourself
]

{ #category : #private }
SycRefactoringPreview2 >> pickedChanges [
	| selectedItems |
	selectedItems := table items.
	^ selectedItems select: [ :item |selectedCheckBoxs  includes: item ]
]

{ #category : #accessing }
SycRefactoringPreview2 >> scopeDropList [
	^ scopeDropList
]

{ #category : #accessing }
SycRefactoringPreview2 >> scopes [
	^ scopes
]

{ #category : #accessing }
SycRefactoringPreview2 >> scopes: anObject [
	scopes := anObject.
	scopeDropList items: scopes "It also sets up first item as selection"
]

{ #category : #initialization }
SycRefactoringPreview2 >> setShortcuts [
	self changesTree attachKeymapCategory: #ChangesBrowserGlobalShortcuts targetting: self.
	self
		bindKeyCombination: PharoShortcuts current acceptShortcut toAction: [ self accept ];
		bindKeyCombination: Character escape toAction: [ self cancel ]
]

{ #category : #accessing }
SycRefactoringPreview2 >> textArea [
	^ textArea
]

{ #category : #accessing }
SycRefactoringPreview2 >> updateChanges [
	| aCompositeChange |
	self generateChanges.
	aCompositeChange := RBCompositeRefactoryChange new.
	changes do: [:each | aCompositeChange addChange: each ].
	
	table items: (aCompositeChange whatToDisplayIn: self).
	table selectAll
]
