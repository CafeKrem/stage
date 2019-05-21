"
i'm an abstract class 
my subclass define:
	* environement : return an environement <RBBrowserEnvironment> 
	* instanceOfCriticBrowser : return a class <CriticBrowser> 
		if you want to use MockClas
	* rulesToTest : return an Array of <ReAbstractRule>
	
i define a template method:
	criticBrowserConstructor : return an instance of <CriticBrowser>
"
Class {
	#name : #CBAbstractTest,
	#superclass : #TestCase,
	#instVars : [
		'criticBrowser'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-Button'
}

{ #category : #testing }
CBAbstractTest class >> isAbstract [ 
	^ self = CBAbstractTest 
]

{ #category : #setUp }
CBAbstractTest >> criticBrowserConstructor [
	^ self instanceOfCriticBrowser
		openOnRule: self rulesToTest
		onEnvironment: self environement
]

{ #category : #setUp }
CBAbstractTest >> environement [
	^ self subclassResponsibility 
]

{ #category : #setUp }
CBAbstractTest >> instanceOfCriticBrowser [
	self subclassResponsibility 
]

{ #category : #setUp }
CBAbstractTest >> rulesToTest [
	^ self subclassResponsibility 
]

{ #category : #running }
CBAbstractTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	criticBrowser := self criticBrowserConstructor.
	
]

{ #category : #running }
CBAbstractTest >> tearDown [
	criticBrowser delete.
	super tearDown
]
