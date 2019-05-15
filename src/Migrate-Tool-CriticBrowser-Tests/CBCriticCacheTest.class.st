Class {
	#name : #CBCriticCacheTest,
	#superclass : #TestCase,
	#instVars : [
		'criticCache'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-cache'
}

{ #category : #running }
CBCriticCacheTest >> setUp [
	criticCache := MockCriticsCache new.
]

{ #category : #adding }
CBCriticCacheTest >> testAddCritcForNewRuleShouldCreatAnIDentitySetAndAddCriticToIDSet [
	| mockRule mockCritic |
	mockRule := MockRuleUseForAddNumber1 new.
	mockCritic := MockCriticUseForAddNumber1 new.
	self deny: (criticCache critics includesKey: mockRule).
	criticCache addCritic: mockCritic forRule: mockRule.
	self assert: (criticCache critics at: mockRule) size equals: 1
]

{ #category : #adding }
CBCriticCacheTest >> testAddCritcForOldRuleShouldAddCriticToIDSet [
	| mockRule mockCritic mockCritic2 |
	mockRule := MockRuleUseForAddNumber1 new.
	mockCritic := MockCriticUseForAddNumber1 new.
	mockCritic2 := MockCriticUseForAddNumber2 new.
	criticCache addCritic: mockCritic forRule: mockRule.
	self assert: (criticCache critics at: mockRule) size equals: 1.
	criticCache addCritic: mockCritic2 forRule: mockRule.
	self assert: (criticCache critics at: mockRule) size equals: 2
]

{ #category : #adding }
CBCriticCacheTest >> testAddFalsePositiveForNewRuleShouldCreatAnIDentitySetAndAddCriticToIDSet [
	| mockRule mockCritic |
	mockRule := MockRuleUseForAddNumber1 new.
	mockCritic := MockCriticUseForAddNumber1 new.
	self deny: (criticCache falsePositives includesKey: mockRule).
	criticCache addFalsePositive: mockCritic forRule: mockRule.
	self assert: (criticCache falsePositives at: mockRule) size equals: 1
]

{ #category : #adding }
CBCriticCacheTest >> testAddFalsePositiveForOldRuleShouldAddCriticToIDSet [
	" oldRule mean that there is a key for this rulee yet"
	| mockRule mockCritic mockCritic2 |
	mockRule := MockRuleUseForAddNumber1 new.
	mockCritic := MockCriticUseForAddNumber1 new.
	mockCritic2 := MockCriticUseForAddNumber2 new.
	criticCache addFalsePositive: mockCritic forRule: mockRule.
	self assert: (criticCache falsePositives at: mockRule) size equals: 1.
	criticCache addFalsePositive: mockCritic2 forRule: mockRule.
	self assert: (criticCache falsePositives at: mockRule) size equals: 2
]

{ #category : #adding }
CBCriticCacheTest >> testAddFalsePositiveRuleForPackageShouldAdd3CriticToFalsePositives [
	| rule package|
	rule := GRInstanceVariableCapitalizationRule new.
	package := UseForTestCriticBrowser package.
	criticCache checker: ReSmalllintChecker new.
	criticCache checker
		runRules: rule asOrderedCollection
		onPackage: UseForTestCriticBrowser package
		withoutTestCase: false.
	criticCache critics
		at: rule
		put: (IdentitySet newFrom: (criticCache checker criticsOf: rule)).
	criticCache
		addFalsePositiveRule: rule
		forPackage: UseForTestCriticBrowser package.
	self assert: (criticCache falsePositives at: rule) size equals: 3.
	self assert: (criticCache falsePositiveRules includesKey: package).
]

{ #category : #tests }
CBCriticCacheTest >> testRemovedAClass [
	| rule package|
	rule := GRInstanceVariableCapitalizationRule new.
	package := UseForTestCriticBrowser package.
	criticCache checker: ReSmalllintChecker new.
	criticCache checker
		runRules: rule asOrderedCollection
		onPackage: UseForTestCriticBrowser package
		withoutTestCase: false.
	criticCache critics
		at: rule
		put: (IdentitySet newFrom: (criticCache checker criticsOf: rule)).
	criticCache itemRemoved: UseForTestCriticBrowser.
	self assert:  (criticCache critics at: rule) size equals: 1. 
]

{ #category : #tests }
CBCriticCacheTest >> testToDoForRule [
	| mockCritic mockRule |
	mockCritic := MockCriticUseForAddNumber1 new.
	mockRule := MockRuleUseForAddNumber1 new.
	self deny: (criticCache toDos includesKey: mockRule) .
	criticCache addToDo: mockCritic forRule: mockRule.
	self assert: (criticCache toDos at: mockRule) size equals: 1
]
