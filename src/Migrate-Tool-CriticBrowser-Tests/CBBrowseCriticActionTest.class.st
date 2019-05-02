"
A CBBrowseCriticActionTest is a test class for testing the behavior of CBBrowseCriticAction
"
Class {
	#name : #CBBrowseCriticActionTest,
	#superclass : #CBAbstractButtonActionTest,
	#category : #'Migrate-Tool-CriticBrowser-Tests'
}

{ #category : #running }
CBBrowseCriticActionTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	self flag: #toRefactor.
	super setUp.
	criticBrowserPresenter := FusionSingleCodeCriticResultList2AndCriticBrowser2
		new
		rules: ((ReRuleManager uniqueInstance allRules groupedBy: #group) at: #Style);
		environment:
			(RBPackageEnvironment
				packageName: 'Migrate-Tool-CriticBrowser-environementTest');
		removeTestCase: false;
		yourself.
	criticBrowserPresenter applyRules
]
