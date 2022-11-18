!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:12:35'!
test01AnAccountSummaryOfAZeroBalanceAccountIsTheExpected
	| accountSummary account chunkOfTextExpected|
	chunkOfTextExpected := 'Balance = 0 pesos'.
	account := ReceptiveAccount new.
	accountSummary := AccountSummary of: account.
	self assert: (chunkOfTextExpected) equals: accountSummary text.
	
	! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:12:51'!
test02AnAccountSummaryOfAReceptiveAccountWithDepositIsTheExpected
	| accountSummary account chunkOfTextExpected reportText |
	chunkOfTextExpected := 
	'Depósito por 100 pesos
	Balance = 100 pesos'.
	account := ReceptiveAccount new.
	Deposit register: 100*peso on: account.
	accountSummary := AccountSummary of: account.
	reportText :=  accountSummary text.
	self assert: (chunkOfTextExpected) equals: reportText.
	! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:13:00'!
test03AnAccountSummaryOfAReceptiveAccountWithWithdrawIsTheExpected
	| accountSummary account chunkOfTextExpected reportText |
	chunkOfTextExpected := 
	'Extracción por 100 pesos
	Balance = -100 pesos'.
	account := ReceptiveAccount new.
	Withdraw register: 100*peso on: account.
	accountSummary := AccountSummary of: account.
	reportText :=  accountSummary text.
	self assert: (chunkOfTextExpected) equals: reportText.! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:13:09'!
test04AnAccountSummaryOfAReceptiveAccountDetectsItsTransferCountpartWhichISWithdrawLeg
	| accountSummary destinationAccount originAccount chunkOfTextExpected reportText |
	chunkOfTextExpected := 
	'Depósito por 100 pesos
	Salida por transferencia de 17 pesos
	Balance = 83 pesos'.
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: originAccount.
	Transfer amount: 17*peso from: originAccount to: destinationAccount. 
	
	accountSummary := AccountSummary of: originAccount.
	reportText :=  accountSummary text.
	self assert: (chunkOfTextExpected) equals: reportText.

! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:13:18'!
test05AnAccountSummaryOfAReceptiveAccountDetectsItsTransferCountpartWhichIsDepositLeg
	| accountSummary destinationAccount originAccount chunkOfTextExpected reportText |
	chunkOfTextExpected := 
	'Entrada por transferencia de 100 pesos
	Balance = 100 pesos'.
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 100*peso on: originAccount.
	Transfer amount: 100*peso from: originAccount to: destinationAccount. 
	
	accountSummary := AccountSummary of: destinationAccount.
	reportText :=  accountSummary text.
	self assert: (chunkOfTextExpected) equals: reportText.! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/16/2022 17:13:37'!
test06ATransferNetOfAnReceptiveAccountWithNoTransactionsIsZero
	|transferNet  reportText chunkOfTextExpected account|
	account := ReceptiveAccount new.

	transferNet := TransferNet of: account.
	
	chunkOfTextExpected := 'Neto de transferencias = 0 pesos'.
	reportText := transferNet text.
	self assert: chunkOfTextExpected equals: reportText.! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/17/2022 09:00:27'!
test07APortfolioTreePrinterReturnsASingleLineWithAPortfolioWithDefaultName
	| portfolio portfolioTreePrinter textExpected textReceived|
	portfolio := Portfolio new.
	portfolioTreePrinter := PortfolioTreePrinter of: portfolio.
	textExpected := 'myPortfolio'.
	textReceived := portfolioTreePrinter text.
	self assert: textExpected equals: textReceived.
	! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/17/2022 09:27:10'!
test08APortfolioTreePrinterReturnsTwoLinesWithASimplePortfolioWithOneAccount
	| simplePortfolio simplePortfolioAccount textExpected textReceived treePrinter|
	simplePortfolioAccount := ReceptiveAccount named: 'mySimpleAccount'.
	simplePortfolio := Portfolio named: 'mySimplePortfolio' with: simplePortfolioAccount.
	treePrinter := PortfolioTreePrinter of: simplePortfolio.
	textExpected := 'mySimplePortfolio' ,  String newLineString , String tab ,'mySimpleAccount'.
	textReceived := treePrinter text.
	self assert: textExpected equals: textReceived.
	
	
! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/17/2022 13:27:44'!
test09APortfolioTreePrinterReturnsTheExpectedTextForAComposedPortfolio
	| simplePortfolio simplePortfolioAccount textExpected textReceived treePrinter composedPortfolio composedPortfolioAccount |
	
	simplePortfolioAccount := ReceptiveAccount named: 'mySimpleAccount'.
	simplePortfolio := Portfolio named: 'mySimplePortfolio' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'composedPortfolioAccount'.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: composedPortfolioAccount with: simplePortfolio.
	
	treePrinter := PortfolioTreePrinter of: composedPortfolio.
	
	textExpected := 
'composedPortfolio
	composedPortfolioAccount
	mySimplePortfolio
		mySimpleAccount'.
	textReceived := treePrinter text.
	self assert: textExpected equals: textReceived.
	! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/18/2022 08:05:46'!
test10APortfolioDetailedTreePrinterReturnJustTheNameAndBalanceOfAEmptyPortfolio
	|portfolio detailedTreePrinter expectedText textOfReport|
	portfolio := Portfolio new.
	detailedTreePrinter := PortfolioDetailedTreePrinter of: portfolio.
	expectedText := 
	'myPortfolio' , String newLineString,String tab ,'Balance = 0 pesos'.
	textOfReport := detailedTreePrinter text.
	self assert: expectedText equals: textOfReport.
	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/18/2022 08:20:44'!
test11APortfolioDetailedTreePrinterOfAPortfolioWithoutTransactionsReturnsNamesAndZeroBalance
	|detailedTreePrinter expectedText textOfReport simplePortfolio simplePortfolioAccount |
	simplePortfolioAccount := ReceptiveAccount named: 'mySimpleAccount'.
	simplePortfolio := Portfolio named: 'mySimplePortfolio' with: simplePortfolioAccount.

	
	detailedTreePrinter := PortfolioDetailedTreePrinter of: simplePortfolio.
	expectedText := 
'mySimplePortfolio
	mySimpleAccount
		Balance = 0 pesos
	Balance = 0 pesos'.

	
	
	textOfReport := detailedTreePrinter text.
	self assert: expectedText equals: textOfReport.
	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/18/2022 15:47:51'!
test12APortfolioDetailedTreePrinterOfAPortfolioWithAnAccountWithADepositReturnsTheExpectedText
	|detailedTreePrinter expectedText textOfReport simplePortfolio simplePortfolioAccount |
	simplePortfolioAccount := ReceptiveAccount named: 'mySimpleAccount'.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio named: 'mySimplePortfolio' with: simplePortfolioAccount.

	
	detailedTreePrinter := PortfolioDetailedTreePrinter of: simplePortfolio.
	expectedText := 
'mySimplePortfolio
	mySimpleAccount
		Depósito por 100 pesos
		Balance = 100 pesos
	Balance = 100 pesos'.

	textOfReport := detailedTreePrinter text.
	self assert: expectedText equals: textOfReport.
	
	 ! !

!ReportTest methodsFor: 'tests' stamp: 'rd 11/18/2022 15:49:28'!
test13APortfolioDetailedTreePrinterOfAComposedPortfolioReturnsTheExpectedText
	| simplePortfolio simplePortfolioAccount textExpected textReceived treePrinter composedPortfolio composedPortfolioAccount |
	
	simplePortfolioAccount := ReceptiveAccount named: 'mySimpleAccount'.
	simplePortfolio := Portfolio named: 'mySimplePortfolio' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount named: 'composedPortfolioAccount'.
	composedPortfolio := Portfolio named: 'composedPortfolio' with: composedPortfolioAccount with: simplePortfolio.
	
	treePrinter := PortfolioDetailedTreePrinter of: composedPortfolio.
	
	textExpected := 
'composedPortfolio
	composedPortfolioAccount
		Balance = 0 pesos
	mySimplePortfolio
		mySimpleAccount
			Balance = 0 pesos
		Balance = 0 pesos
	Balance = 0 pesos'.
		
	textReceived := treePrinter text.
	self assert: textExpected equals: textReceived.
	! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'rd 11/17/2022 07:32:51'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	
	name = nil ifTrue: [name := 'myPortfolio'].! !

!Portfolio methodsFor: 'initialization' stamp: 'rd 11/17/2022 07:32:02'!
initializeWithName: aName
	name := aName.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'rd 11/17/2022 08:24:10'!
name
	^name! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'rompiendo encapsulamiento' stamp: 'rd 11/17/2022 08:52:53'!
accounts
	^accounts copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rd 11/17/2022 08:14:34'!
named: aName with: anAccount
	^(self new initializeWithName: aName) add: anAccount; yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rd 11/16/2022 21:39:36'!
named: aName with: anAccount with: anotherAccount
	^(self new initializeWithName: aName ) add: anAccount; add: anotherAccount; yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rd 11/16/2022 21:38:29'!
with: anAccount

	^self new add: anAccount; yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'rd 11/16/2022 21:37:55'!
with: anAccount with: anotherAccount

	^self new add: anAccount; add: anotherAccount; yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'rd 11/17/2022 07:33:05'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name = nil ifTrue: [name := 'myPortfolio'].! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'rd 11/17/2022 07:12:11'!
initializeWithName: aName
	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'rd 11/17/2022 08:24:31'!
name
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'rd 11/17/2022 07:09:28'!
named: aName
	^self new initializeWithName: aName.
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'text description' stamp: 'rd 11/16/2022 08:10:06'!
textDescription
	! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'text description' stamp: 'rd 11/16/2022 16:30:48'!
textOfReport: aReport
	^aReport descriptionTextForDepositWithValue: self value.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'text description' stamp: 'rd 11/16/2022 16:33:25'!
textOfReport: aReport
	self subclassResponsibility.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'text description' stamp: 'rd 11/16/2022 16:34:22'!
textOfReport: aReport
	^aReport descriptionTextForTransferDepositLegWithValue: self value.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'text description' stamp: 'rd 11/16/2022 16:35:04'!
textOfReport: aReport
	^aReport descriptionTextForTransferWithdrawLegWithValue: self value.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'text description' stamp: 'rd 11/16/2022 16:35:50'!
textOfReport: aReport
	^aReport descriptionTextForWithdrawWithValue: self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'private' stamp: 'rd 11/17/2022 14:43:15'!
convertToString: aMeasure
	(aMeasure isKindOf: SimpleMeasure) ifTrue: [ ^aMeasure amount asString].
	(aMeasure isKindOf: CompoundMeasure) ifTrue: [^(aMeasure atBaseUnit: peso ifNone: [^'error']) amount asString ].
	(aMeasure isKindOf: SmallInteger ) ifTrue: [^aMeasure asString].
! !


!Report methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/16/2022 16:32:05'!
descriptionTextForDepositWithValue: anAmountOfMoney
	self subclassResponsibility.! !

!Report methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:28:38'!
descriptionTextForTransferDepositLegWithValue: anAmountOfMoney
	self subclassResponsibility.! !

!Report methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:29:19'!
descriptionTextForTransferWithdrawLegWithValue: anAmountOfMoney
	self subclassResponsibility.
! !

!Report methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:30:24'!
descriptionTextForWithdrawWithValue: anAmountOfMoney
	self subclassResponsibility.
! !


!Report methodsFor: 'text report' stamp: 'rd 11/16/2022 16:55:33'!
text
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'rd 11/14/2022 09:33:10'!
of: anAccount
	self subclassResponsibility.
! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'rd 11/14/2022 09:29:56'!
initializeAccountSummaryWith: anAccount 
	account := anAccount.! !


!AccountSummary methodsFor: 'accessing' stamp: 'rd 11/16/2022 16:55:33'!
text
	| transacitonsOfAccount textOfReport accountBalance balance|
	textOfReport := Text new.
	transacitonsOfAccount := account transactions.
	transacitonsOfAccount do: [:ATransaction | textOfReport append: (ATransaction textOfReport: self) string].
	account balance = (0*peso) ifTrue: [accountBalance := '0'] ifFalse: [balance := account balance .accountBalance :=  self convertToString: balance].
	textOfReport append: ('Balance = ' , accountBalance , ' pesos').
	^textOfReport string.

	! !


!AccountSummary methodsFor: 'texts descriptions for kinds of transactions' stamp: 'rd 11/16/2022 16:42:53'!
descriptionTextForDepositWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Depósito por ', (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!AccountSummary methodsFor: 'texts descriptions for kinds of transactions' stamp: 'rd 11/16/2022 16:42:46'!
descriptionTextForTransferDepositLegWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Entrada por transferencia de ' , (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!AccountSummary methodsFor: 'texts descriptions for kinds of transactions' stamp: 'rd 11/16/2022 16:42:40'!
descriptionTextForTransferWithdrawLegWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Salida por transferencia de ' , (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!AccountSummary methodsFor: 'texts descriptions for kinds of transactions' stamp: 'rd 11/16/2022 16:42:33'!
descriptionTextForWithdrawWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Extracción por ', (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'rd 11/14/2022 09:28:14'!
of: anAccount
	^self new initializeAccountSummaryWith: anAccount.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'accountPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'initialize' stamp: 'rd 11/17/2022 13:49:28'!
initializeWith: aPortfolio
	
	accountPortfolio := aPortfolio.! !


!PortfolioDetailedTreePrinter methodsFor: 'text report' stamp: 'rd 11/18/2022 15:50:32'!
text
	| reportText |
	reportText := ''.
	reportText := reportText , (self proccessPortfolioDetailedTreePrinterTextWithPortfolio: accountPortfolio andText: '' acordingToNivelOfPortfolioTree: 0).
	^reportText
! !


!PortfolioDetailedTreePrinter methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:26:29'!
descriptionTextForDepositWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Depósito por ', (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!PortfolioDetailedTreePrinter methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:26:58'!
descriptionTextForTransferDepositLegWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Entrada por transferencia de ' , (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!PortfolioDetailedTreePrinter methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:27:16'!
descriptionTextForTransferWithdrawLegWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Salida por transferencia de ' , (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !

!PortfolioDetailedTreePrinter methodsFor: 'text description for kinds of transactions' stamp: 'rd 11/18/2022 16:27:29'!
descriptionTextForWithdrawWithValue: anAmountOfMoney
	|text|
	text := Text new.
	text append: 'Extracción por ', (self convertToString: anAmountOfMoney) , ' pesos
	'.
	^text.
! !


!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'rd 11/18/2022 16:19:59'!
accountSummaryForPortfolioDetailedTreePrinterOf: aReceptiveAccount 
	| accountBalance balance textOfReport transacitonsOfAccount |
	textOfReport := Text new.
	transacitonsOfAccount := aReceptiveAccount transactions.
	transacitonsOfAccount do: [:ATransaction | textOfReport append: (ATransaction textOfReport: self) string].
	aReceptiveAccount balance = (0*peso) ifTrue: [accountBalance := '0'] ifFalse: [balance := aReceptiveAccount balance .accountBalance :=  self convertToString: balance].
	textOfReport append: ('Balance = ' , accountBalance , ' pesos').
	^textOfReport string.
! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'rd 11/18/2022 13:18:39'!
proccessAccountSummaryText: anAccountSummaryText  accordingToLevelOfTree: aLevelOfTree
	^anAccountSummaryText withLineEndings: (String newLineString, (self tabsAccordingToNivelOfTree: aLevelOfTree)).! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'rd 11/18/2022 16:21:19'!
proccessPortfolioDetailedTreePrinterTextWithPortfolio: aPortfolio andText: aTextReport acordingToNivelOfPortfolioTree: aNivelOfPortfolioTree

	|balanceOfPortfolio reportText accountSummary accountSummaryText stringTabs actualnivelOfTree|
	balanceOfPortfolio := self convertToString: (aPortfolio balance).
	actualnivelOfTree := aNivelOfPortfolioTree +1.
	stringTabs := self tabsAccordingToNivelOfTree: actualnivelOfTree .


	reportText := aTextReport , aPortfolio name.
	
	aPortfolio accounts do: [:anAccount|  accountSummary := self accountSummaryForPortfolioDetailedTreePrinterOf: anAccount.
		accountSummaryText := self proccessAccountSummaryText: (accountSummary) accordingToLevelOfTree: actualnivelOfTree.
		
		(anAccount isKindOf: ReceptiveAccount) ifTrue: 
		[reportText := reportText , String newLineString , stringTabs, anAccount name , String newLineString, stringTabs, String tab, accountSummaryText].
		
		
		
		(anAccount isKindOf: Portfolio) ifTrue: 
		[reportText := reportText , String newLineString ,
			 stringTabs, (self proccessPortfolioDetailedTreePrinterTextWithPortfolio: anAccount andText: '' acordingToNivelOfPortfolioTree: actualnivelOfTree)] ].
	
	
	
	reportText:=  reportText , String newLineString, stringTabs, 'Balance = ', balanceOfPortfolio, ' pesos'.
	^reportText! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'rd 11/17/2022 14:35:09'!
tabsAccordingToNivelOfTree: aNivel
	| string |
	string := ''.
	1 to: aNivel do: [:index | string := string , String tab].
	^string.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'rd 11/17/2022 13:47:08'!
of: aPortfolio
	^self new initializeWith: aPortfolio.
	! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolioAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'private' stamp: 'rd 11/18/2022 16:08:29'!
processPortfolioTreePrinterTextWithPortfolio: aPortfolio andText: textOfReport accordingToLevelOfTree: nivelOfTree
	| text |
	text := textOfReport , (aPortfolio name).
	
	aPortfolio accounts do: 
	
		[:anAccount |  (anAccount isKindOf: ReceptiveAccount) ifTrue:
			 [ text := text , String newLineString , (self tabsAccordingToNivelOfTree: nivelOfTree) , anAccount name].
			
				(anAccount isKindOf: Portfolio) ifTrue: 
			[text := text , String newLineString, String tab , (self processPortfolioTreePrinterTextWithPortfolio: anAccount andText: '' accordingToLevelOfTree: nivelOfTree +1) ]].
	^text
! !

!PortfolioTreePrinter methodsFor: 'private' stamp: 'rd 11/17/2022 11:10:19'!
tabsAccordingToNivelOfTree: aNivel
	| string |
	string := ''.
	1 to: aNivel do: [:index | string := string , String tab].
	^string.
	! !


!PortfolioTreePrinter methodsFor: 'text report' stamp: 'rd 11/18/2022 16:00:49'!
text
	"rompiendo encapsulamiento"
	|textOfReport  |
	textOfReport := ''.
	textOfReport := textOfReport , (self processPortfolioTreePrinterTextWithPortfolio: portfolioAccount andText: textOfReport accordingToLevelOfTree: 1).
	^textOfReport.

! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'rd 11/18/2022 15:51:43'!
initializeWithAccount: aPortfolio
	portfolioAccount := aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'rd 11/17/2022 08:19:12'!
of: aPortfolio
	^self new initializeWithAccount: aPortfolio.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'rd 11/16/2022 09:52:28'!
initializeTransferNetWith: anAccount
	account := anAccount.! !


!TransferNet methodsFor: 'accessing' stamp: 'rd 11/16/2022 17:11:42'!
text
	|transferNet transferLegs |
	transferNet := 0 *peso.
	transferLegs := account transactions select: [:aTransaction | aTransaction isKindOf: TransferLeg].
	transferLegs do: [:aTransferLeg | transferNet := aTransferLeg affectBalance: transferNet ].
	^'Neto de transferencias = ' , (self convertToString: transferNet) , ' pesos'.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'rd 11/16/2022 09:51:45'!
of: anAccount
	^self new initializeTransferNetWith: anAccount.
	! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'rd 11/15/2022 09:25:03'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
