"
this class is an window for Method name edition 



Class part 
	this class represent a window for Method Name edition  
	
Responsibility part: 

my jobs :
	- display a preview of your future method name or '(invalid)' when the name is incorrect  (with a LabelPresenter previewResult an instance variable)
	- display the arguments list of your method and let you modified the order 
	
For the Collaborators Part: 



Public API and Key Messages

HOW TO RUN 
		MethodNameEditor2 openOn: (Object >> #assert:).
		or see class side 'example' script
  
 One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	selectorInput: <TextInputFieldPresenter>
	argumentsList: <ListPresenter>
	previewResult: <LabelPresenter>
	upButton: <ButtonPresenter>
	downButton: <ButtonPresenter>  
	compiledMethod: <CompiledCode>

    Implementation Points
"
Class {
	#name : #MethodNameEditor2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'selectorInput',
		'argumentsList',
		'previewResult',
		'upButton',
		'downButton',
		'acceptButton',
		'cancelButton',
		'compiledMethod'
	],
	#category : #'Stage-things'
}

{ #category : #specs }
MethodNameEditor2 class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: 'Selector'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #selectorInput;
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Arguments'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #argumentsList;
				add:
					(SpecBoxLayout newVertical
						add: #upButton;
						add: #downButton;
						yourself)
					withConstraints: [ :aConstraints | aConstraints width: 30 ];
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Preview'
					withConstraints: [ :aConstraints | aConstraints width: 80 ];
				add: #previewResult
					withConstraints: [ :aConstraints | aConstraints width: 100 ];
				yourself);
		yourself
]

{ #category : #examples }
MethodNameEditor2 class >> example [ 
	<script>
	MethodNameEditor2 openOn: (UseOnlyForTest >> #bug:)
]

{ #category : #specs }
MethodNameEditor2 class >> openOn: aMethod [
	"
	argument:
		aMethod : it is the method that who want to rename
	return:
		return an instance of MethodNameEditor with selectorInput fill with the argument aString 
		and PreviewLabelFinal
		example:
			MethodNameEditor2 openOn: (Object >> #assert:)
			
		"
	^ (self on: aMethod) openModalWithSpec 
]

{ #category : #accessing }
MethodNameEditor2 >> argumentsList [
	^ argumentsList
]

{ #category : #action }
MethodNameEditor2 >> argumentsListAction [
	^ [ | argumentsListSize |
	argumentsListSize := argumentsList items size.
	(argumentsListSize = 1)
		ifTrue: [ upButton disable.
				downButton disable ];
		ifFalse: [ (argumentsList selectionMode selectedIndex = 1)
					ifTrue: [ upButton disable.
							downButton enable ];
					ifFalse: [ (argumentsList selectionMode selectedIndex = argumentsListSize)
								ifTrue: [ upButton enable.
										downButton disable ];
								ifFalse: [ upButton enable.
										downButton enable ] ] ] ]
]

{ #category : #accessing }
MethodNameEditor2 >> cancelButton [
	^ cancelButton
]

{ #category : #action }
MethodNameEditor2 >> cancelButtonAction [
	self application close
]

{ #category : #accessing }
MethodNameEditor2 >> compiledMethod: aMethod [
	"
	this method is call by openOn  class side method.
	argument:
		* aMethod it's an CompiledMethod like (AClass>>#aMethod)
	return:
		an instance of MethodeNameEditor with widget 
		"
	compiledMethod := aMethod.
]

{ #category : #accessing }
MethodNameEditor2 >> downButton [
	^ downButton
]

{ #category : #action }
MethodNameEditor2 >> downButtonAction [
	self flag: #RefactoringUpDownButton.
	^ [ | selectedIndex selectedElement elementBefore |
	selectedIndex := argumentsList selectionMode selectedIndex.
	selectedElement := argumentsList items at: selectedIndex.
	elementBefore := argumentsList items at: selectedIndex + 1.
	argumentsList items at: selectedIndex put: elementBefore.
	argumentsList items at: selectedIndex + 1 put: selectedElement.
	argumentsList selectionMode selectIndex: selectedIndex + 1.
	previewResult
		label:
			(self
				upDateSelector: self selectorInput text
				arguments: argumentsList items) ]
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> init [
	| argumentsCollection selectorCollection |
	self title: 'method name editor'.
	selectorCollection := compiledMethod selector.
	argumentsCollection := compiledMethod ast arguments
		sorted: #start ascending.
	selectorInput text: selectorCollection.
	argumentsList items: argumentsCollection.	"collect: [ :eachArgument | eachArgument name]"
	previewResult
		label:
			(self
				upDateSelector: selectorCollection
				arguments: argumentsCollection)
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> initializeDialogWindow: aModalPresenter [
	aModalPresenter
		closeOnBackdropClick: true;
		addButton: 'Ok'
			do: [ :presenter | 
			self previewResult label = '(invalid)'
				ifTrue: [ self inform: 'Invalid method name' ]
				ifFalse: [ self inform: 'Ok action'.
					presenter close ] ];
		addButton: 'Cancel'
			do: [ :presenter | 
			self cancelButtonAction.
			presenter close ]
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> initializePresenter [
	self init.
	selectorInput whenTextChangedDo: self selectorInputAction.
	argumentsList whenSelectionChangedDo: self argumentsListAction.
	upButton action: self upButtonAction.
	downButton action: self downButtonAction
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> initializeWidgets [
	selectorInput := (self instantiate: TextInputFieldPresenter)
		autoAccept: true;
		yourself.
	argumentsList := self newList
		items: OrderedCollection new;
		yourself.
	previewResult := self newLabel.
	upButton := self newButton
		label: 'Up';
		disable;
		yourself.
	downButton := self newButton
		label: 'Dn';
		disable;
		yourself
]

{ #category : #accessing }
MethodNameEditor2 >> previewResult [
	^ previewResult
]

{ #category : #accessing }
MethodNameEditor2 >> selectorInput [
	^ selectorInput
]

{ #category : #action }
MethodNameEditor2 >> selectorInputAction [
	^ [ :text | 
	self previewResult
		label: (self upDateSelector: text arguments: self argumentsList items) ]
]

{ #category : #'accessing model' }
MethodNameEditor2 >> setModelBeforeInitialization: aCompiledMethod [
	"this metod just call a setter"
	self compiledMethod: aCompiledMethod
]

{ #category : #accessing }
MethodNameEditor2 >> upButton [
	^ upButton
]

{ #category : #action }
MethodNameEditor2 >> upButtonAction [
	self flag: #RefactoringUpDownButton.
	^ [ | selectedIndex selectedElement elementBefore |
	selectedIndex := argumentsList selectionMode selectedIndex.
	selectedElement := argumentsList items at: selectedIndex.
	elementBefore := argumentsList items at: selectedIndex - 1.
	argumentsList items at: selectedIndex put: elementBefore.
	argumentsList items at: selectedIndex - 1 put: selectedElement.
	argumentsList selectionMode selectIndex: selectedIndex - 1.
	previewResult
		label:
			(self
				upDateSelector: self selectorInput text
				arguments: argumentsList items) ]
]

{ #category : #update }
MethodNameEditor2 >> upDateSelector: selectorCollection arguments: argumentsCollection [
	"this method is used to rebuild the preview when text in the selectorInput change and when the argumentsList change 
	example: 
		if we want to rename ARandomClass >> #open:with:
		upDateSelector: #open:with: arguments: #( #something #otherthing  ) 
			return: 'open: something with: otherthing'  
		upDateSelector: #open: arguments: #( #something #otherthing  ) 
			return: '(invalid)' 
		and the same thing with not acceptable method name "
	^ (RBMethodName
		selector: selectorCollection 
		arguments: (argumentsCollection  collect: #name)) methodName
]
