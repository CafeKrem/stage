Class {
	#name : #CBAbstractTextPresenterNoteBookPage,
	#superclass : #CBAbstractNoteBookPage,
	#category : #'Migrate-Tool-CriticBrowser-data-noteBookPage'
}

{ #category : #testing }
CBAbstractTextPresenterNoteBookPage class >> isAbstract [ 
	self = CBAbstractTextPresenterNoteBookPage
]

{ #category : #accessing }
CBAbstractTextPresenterNoteBookPage class >> provider [
	^ TextPresenter new
]
