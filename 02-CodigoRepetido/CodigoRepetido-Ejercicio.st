!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:24:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self theTimeToRun: [ customerBook addCustomerNamed: johnLennon] shouldNotPass: (50*millisecond).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:27:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney|
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	self theTimeToRun: [customerBook addCustomerNamed: paulMcCartney] shouldNotPass: (100*millisecond).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:19:31'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:19:16'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self failMessage: 
	[customerBook removeCustomerNamed: 'Paul McCartney'.] 
		assert1: [customerBook numberOfCustomers = 1]
			 assert2: [customerBook includesCustomerNamed: johnLennon] errorType: NotFound.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:16:38'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self assertTheNumberOfCustomersIsCorrectActive: 0 suspended: 1 total: 1 withCustomerBookObject: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:19:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self assertTheNumberOfCustomersIsCorrectActive: 0 suspended: 0 total: 0 withCustomerBookObject: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:18:44'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self failMessage: 
		[customerBook suspendCustomerNamed: 'RingoStar'.] 
			assert1: [customerBook numberOfCustomers = 1]
				assert2: [customerBook includesCustomerNamed: johnLennon] errorType: CantSuspend.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'rd 9/26/2022 18:19:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self failMessage: 
	[customerBook suspendCustomerNamed: johnLennon.] 
		assert1: [customerBook numberOfCustomers = 1]
			 assert2: [customerBook includesCustomerNamed: johnLennon] errorType: CantSuspend.! !


!CustomerBookTest methodsFor: 'abstractions' stamp: 'rd 9/26/2022 18:13:26'!
assertTheNumberOfCustomersIsCorrectActive: NumberOfActiveCustomers suspended: NumberOfSuspendedCustomers total: NumberOfTotalCustomers withCustomerBookObject: customerBook	 
	self assert: NumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: NumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers. 
	self assert: NumberOfTotalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'rd 9/26/2022 15:56:48'!
failMessage: failClosure assert1: closureAssert1 assert2: closureAssert2 errorType: error
[ failClosure value.
	self fail]
		on: error
		do: [ :anError | 
			self assert: closureAssert1 value.
			self assert: closureAssert2 value]. ! !

!CustomerBookTest methodsFor: 'abstractions' stamp: 'rd 9/26/2022 18:25:29'!
theTimeToRun: aMessageClosure shouldNotPass: aLimitTime
	| timeToRun |
	timeToRun := Time millisecondsToRun: aMessageClosure.
	self assert: (timeToRun) < (aLimitTime).
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'rd 9/26/2022 15:33:49'!
aulMcCartney] timeLimit: 100.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
