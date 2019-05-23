Class {
	#name : #CBRuleCommentBookPage,
	#superclass : #CBAbstractNoteBookPage,
	#category : #'Migrate-Tool-CriticBrowser-data-noteBookPage'
}

{ #category : #accessing }
CBRuleCommentBookPage class >> layoutSpec [
	^ #ruleCommentBookPage
]

{ #category : #accessing }
CBRuleCommentBookPage class >> provider: aCriticBrowser [
	aCriticBrowser ruleCommentBookPage: (aCriticBrowser instantiate: TextPresenter new)
]

{ #category : #accessing }
CBRuleCommentBookPage class >> title [
	^ 'comment Rule'
]
