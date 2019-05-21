"
A SycRefactoringPreview2Test is a test class for testing the behavior of SycRefactoringPreview2
"
Class {
	#name : #SycRefactoringPreview2Test,
	#superclass : #TestCase,
	#instVars : [
		'sycRefactoringPreview'
	],
	#category : #'Stage-Tests-test'
}

{ #category : #tests }
SycRefactoringPreview2Test >> fillTableWith3MockItem [
	| mockTreeTableItem2 mockTreeTableItem3 mockTreeTableItem1 |
	mockTreeTableItem1 := MockTreeTableItem new.
	mockTreeTableItem2 := MockTreeTableItem new.
	mockTreeTableItem3 := MockTreeTableItem new.
	sycRefactoringPreview table
		items:
			{mockTreeTableItem1.
			mockTreeTableItem2.
			mockTreeTableItem3}
]

{ #category : #setup }
SycRefactoringPreview2Test >> initializeForInitializeTest [
	| scopeClass scopePackage |
	scopePackage := ClyPackageScope
		of: 'Stage' asPackage
		in: ClyNavigationEnvironment currentImage.
	scopeClass := ClyClassScope
		of: 'SycRefactoringPreview'
		in: ClyNavigationEnvironment currentImage.
		
	sycRefactoringPreview := MockSycRefactoringPreview
		for: SycRefactoringPreviewMockCommand new
		scopes:
			{scopePackage.
			scopeClass}
]

{ #category : #running }
SycRefactoringPreview2Test >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	sycRefactoringPreview := MockSycRefactoringPreview  new.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testBuilDiffMethod [
	self assert: false.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testDiffBuilderNilSendMustReturnEmptyChar [
	sycRefactoringPreview := SycRefactoringPreview2 new.
	self assert:  (sycRefactoringPreview buildDiffFor: nil) equals: ''.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testDoubleClickAnTableItemShouldChangeTheValueAssociateToKey [
	| mockTreeTableItem1 mockTreeTableItem2 mockTreeTableItem3 |
	mockTreeTableItem1 := MockTreeTableItem new.
	mockTreeTableItem2 := MockTreeTableItem new.
	mockTreeTableItem3 := MockTreeTableItem new.
	sycRefactoringPreview table
		items:
			{mockTreeTableItem1.
			mockTreeTableItem2.
			mockTreeTableItem3}.
	sycRefactoringPreview selectedRefactorings
		at: mockTreeTableItem3
		put: true.
	sycRefactoringPreview table selectIndex: 3.
	sycRefactoringPreview table doActivateAtIndex: 3.
	self
		deny: (sycRefactoringPreview selectedRefactorings at: mockTreeTableItem3)
]

{ #category : #tests }
SycRefactoringPreview2Test >> testDropListChangeShouldChangeTableItems [
	"this method can't be test because i can't isolate the command"
	| tableItemBeforeChangeDropList className |
	self flag: #toTest.
	self assert: false.
	"self initializeForInitializeTest.
	tableItemBeforeChangeDropList := sycRefactoringPreview table items.
	sycRefactoringPreview scopeDropList selectIndex: 2.
	className := sycRefactoringPreview table items at: 1.
	self
		assert:
			(sycRefactoringPreview table items
				allSatisfy: [ :element | element class = className ])"
]

{ #category : #'initialize-test' }
SycRefactoringPreview2Test >> testInitAllCheckBoxDictionarySetTrue [
	"this method can't be test because i can't isolate the command"
	self initializeForInitializeTest.
	self assert: sycRefactoringPreview selectedRefactorings size equals: 3.
	self
		assert:
			(sycRefactoringPreview selectedRefactorings
				allSatisfy: [ :key | key ])
			
]

{ #category : #'initialize-test' }
SycRefactoringPreview2Test >> testInitTextAreaShouldEmpty [
	"this method can't be test because i can't isolate the command"

	self initializeForInitializeTest.
	self assert: sycRefactoringPreview textArea text equals: ''
]

{ #category : #tests }
SycRefactoringPreview2Test >> testPickedChanges [
	self fillTableWith3MockItem.
	sycRefactoringPreview selectectAllCheckBox.
	self flag: #MAUCHEEEEEEEEEEEEEEEEEEEEE.
	sycRefactoringPreview table selectIndex: 2.
	sycRefactoringPreview table doActivateAtIndex: 2.
	self
		deny:
			(sycRefactoringPreview selectedRefactorings
				includesKey: sycRefactoringPreview table selection selectedIndex)
]

{ #category : #tests }
SycRefactoringPreview2Test >> testSelectAnElementTreeTablePresenterShouldSendBuilDiffForToTextArea [
	self fillTableWith3MockItem.
	self assert: sycRefactoringPreview textArea text isEmpty.
	sycRefactoringPreview table selectIndex: 2.
	self assert: sycRefactoringPreview textArea text equals: 'useForTest'
]
