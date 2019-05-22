Class {
	#name : #CBCriticLocationBookPage,
	#superclass : #CBAbstractNoteBookPage,
	#category : #'Migrate-Tool-CriticBrowser-data-noteBookPage'
}

{ #category : #accessing }
CBCriticLocationBookPage class >> provider [
	^ CodePresenter new acceptBlock: [ self acceptBlock]
]

{ #category : #accessing }
CBCriticLocationBookPage class >> title [
	^ 'Critic location'
]
