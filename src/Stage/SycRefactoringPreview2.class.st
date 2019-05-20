"
HOW TO RUN 
	scopePackage := ClyPackageScope of: 'Stage' asPackage in: ClyNavigationEnvironment currentImage.
	scopeClass := ClyClassScope of: 'SycRefactoringPreview' in: ClyNavigationEnvironment currentImage.
	
	SycRefactoringPreview2 for:  scope: { scopePackage . scopeClass } 
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

I a UI use to select modification that you want to sdo 
(add Method remove method) when you want to rename a Method

    Instance Variables
	changes:		<Array<RBRefactroring>>
	scopeDropList:		<DropListPresenter>
	scopes:		<ClyScope>
	selectedCheckBoxs:		<OrderedCollection>
	table:		<TablePresenter>
	textArea:		<SourceCodePresenter>


    Implementation Points
"
Class {
	#name : #SycRefactoringPreview2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'scopes',
		'textArea',
		'changes',
		'scopeDropList',
		'table',
		'selectedCheckBoxs',
		'command'
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
	super initialize
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializePresenter [
	super initializePresenter.
	table
		transmitTo: textArea
		transform: [ :selectedItem | self buildDiffFor: selectedItem ].
	table
		whenActivatedDo: [ :selectedElement | 
			self
				modifCheckBoxSelection: selectedElement widget selection selectedItem.
			self rebuild ].
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
				evaluated: [ :x | selectedCheckBoxs at: x ])
				onActivation: [ :class | self modifCheckBoxSelection: class ];
				onDesactivation: [ :class | self modifCheckBoxSelection: class ];
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
	self selectectAllCheckBox.
	self setShortcuts.
]

{ #category : #'epicea support' }
SycRefactoringPreview2 >> isEpiceaInterestingJobOwner [

	^ true
]

{ #category : #private }
SycRefactoringPreview2 >> modifCheckBoxSelection: anItem [
	"it's normal it's impossible that anItem dosn't store in dictionary because at initialize i fill the dictionary and at each scope change"

	selectedCheckBoxs at: anItem put: (selectedCheckBoxs at: anItem) not
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
	^ table items select: [:item |selectedCheckBoxs includesKey: item  ] 
]

{ #category : #update }
SycRefactoringPreview2 >> rebuild [
	self needRebuild: false.
	self buildWithSpec
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

{ #category : #accessing }
SycRefactoringPreview2 >> selectectAllCheckBox [
	selectedCheckBoxs := Dictionary new.
	table items
		do: [ :tableItem | selectedCheckBoxs at: tableItem put: true ]
]

{ #category : #initialization }
SycRefactoringPreview2 >> setShortcuts [
	self
		bindKeyCombination: PharoShortcuts current acceptShortcut toAction: [ self accept ];
		bindKeyCombination: Character escape toAction: [ self cancel ]
]

{ #category : #accessing }
SycRefactoringPreview2 >> table [
	^ table
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
	changes do: [ :each | aCompositeChange addChange: each ].
	table items: (aCompositeChange whatToDisplayIn: self).
	self selectectAllCheckBox
]
