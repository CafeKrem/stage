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
	selectedCheckBoxs:		<Dictionary>
	table:		<TablePresenter>
	textArea:		<SourceCodePresenter>
	

    Implementation Points
"
Class {
	#name : #SycRefactoringPreview2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'textArea',
		'changes',
		'scopeDropList',
		'table',
		'command',
		'selectedRefactorings'
	],
	#category : #'Stage-things'
}

{ #category : #specs }
SycRefactoringPreview2 class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add: #table;
		add: #scopeDropList withConstraints: [ :constraints | constraints height: 30 ];
		add: #textArea;
		yourself
]

{ #category : #'instance creation' }
SycRefactoringPreview2 class >> for: aCommand scopes: scopes [
	^ self new
		command: aCommand;
		scopes: scopes
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
	^ self activeScope asRBEnvironment
]

{ #category : #accessing }
SycRefactoringPreview2 >> activeScope [
	^ scopeDropList selectedItem
]

{ #category : #'epicea support' }
SycRefactoringPreview2 >> asEpiceaEvent [
	"thanks to this method epicia know that is a refactoring"
	
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

{ #category : #update }
SycRefactoringPreview2 >> generateChanges [

	| rbEnvironment |
	changes := command asRefactorings.
	rbEnvironment := self activeRBEnvironment.
	changes do: [ :each | 
		each model environment: rbEnvironment.
		each primitiveExecute ]
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializeDialogWindow: aDialogWindowPresenter [
	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter title: self title
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializePresenter [
	super initializePresenter.
	table
		transmitTo: textArea
		transform: [ :selectedItem | self buildDiffFor: selectedItem ].
		
	table
		whenActivatedDo: [ :selectedElement | 
			self toggleSelectionOf: selectedElement widget selection selectedItem.
			self rebuild ].
		
	scopeDropList
		whenSelectedItemChangedDo: [ :scope | self updateChanges ]
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializeTable [
	table
		addColumn:
			((CheckBoxTableColumn evaluated: [ :x | selectedRefactorings at: x ])
				onActivation: [ :class | self toggleSelectionOf: class ];
				onDesactivation: [ :class | self toggleSelectionOf: class ];
				width: 20);
		addColumn: (StringTableColumn evaluated: [ :x | x name ]);
		hideColumnHeaders
]

{ #category : #initialization }
SycRefactoringPreview2 >> initializeWidgets [
	table := self newTable.
	textArea := self newCode.
	scopeDropList := self newDropList.
	
	self initializeTable.
	textArea enabled: false.
	scopeDropList displayBlock: [ :scope | scope description capitalized ].
	
	self
		selectectAllCheckBox;
		setShortcuts;
		setFocus
]

{ #category : #'epicea support' }
SycRefactoringPreview2 >> isEpiceaInterestingJobOwner [

	^ true
]

{ #category : #accessing }
SycRefactoringPreview2 >> pickedChanges [
	^ table items
		select: [ :item | selectedRefactorings at: item ]
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
SycRefactoringPreview2 >> scopes: aCollectionOfScopes [
	scopeDropList items: aCollectionOfScopes "It also sets up first item as selection"
]

{ #category : #update }
SycRefactoringPreview2 >> selectectAllCheckBox [
	selectedRefactorings := Dictionary new.
	table items
		do: [ :refactoring | selectedRefactorings at: refactoring put: true ]
]

{ #category : #initialization }
SycRefactoringPreview2 >> setFocus [
	self focusOrder
		add: table;
		add: scopeDropList;
		add: textArea
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
SycRefactoringPreview2 >> title [
	^ self class title
]

{ #category : #private }
SycRefactoringPreview2 >> toggleSelectionOf: aRefactoring [
	"it's normal it's impossible that anItem dosn't store in dictionary because at initialize i fill the dictionary and at each scope change"

	selectedRefactorings at: aRefactoring put: (selectedRefactorings at: aRefactoring) not
]

{ #category : #update }
SycRefactoringPreview2 >> updateChanges [
	self generateChanges.
	self updateTablePresenter.
	self selectectAllCheckBox
]

{ #category : #update }
SycRefactoringPreview2 >> updateTablePresenter [
	| aCompositeChange |
	aCompositeChange := RBCompositeRefactoryChange new.
	changes do: [ :each | aCompositeChange addChange: each ].
	table items: (aCompositeChange whatToDisplayIn: self)
]
