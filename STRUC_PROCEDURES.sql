/* #######################################################*/
/* Procedure spNewSecurity Insert value into tbsecurities */
/* #######################################################*/
USE master
GO

IF(OBJECT_ID(N'dbo.spNewSecurity',				'P') is not null) DROP PROCEDURE spNewSecurity
IF(OBJECT_ID(N'dbo.spNewPortfolio',				'P') is not null) DROP PROCEDURE spNewPortfolio
IF(OBJECT_ID(N'dbo.spInsertEarnings',			'P') is not null) DROP PROCEDURE spInsertEarnings
IF(OBJECT_ID(N'dbo.spInsertEvent',				'P') is not null) DROP PROCEDURE spInsertEvent
GO

/* Procedure spNewSecurity Insert value into tbsecurities */
CREATE PROCEDURE spNewSecurity
            @securityDesc varchar(255)
           ,@ticker varchar(50)
AS

Declare @vNewSecurityID int = next value for seqSecurityID;

INSERT INTO dbo.tbsecurities
           (securityID
           ,securityDesc
           ,ticker
           ,dateCreated
           ,dateModified
           ,dateDeleted
           ,deletedFlag
           ,hiddenFlag)
     VALUES
           (@vNewSecurityID
           ,@securityDesc
           ,@ticker
           ,CURRENT_TIMESTAMP
           ,NULL
           ,NULL
           ,0
           ,0);
GO

/* Procedure spNewPortfolio Insert value into tbportfolios */
CREATE PROCEDURE spNewPortfolio
			@portfolioDesc varchar (255)
			,@portsector varchar (50)
AS

DECLARE @vnewPortfolioID int = next value for seqPortfolioID;
DECLARE @maxPortSortVal int = (SELECT ISNULL(max(sortorder), 0) + 10 from tbportfolios); -- get max sort value + 10

INSERT INTO dbo.tbportfolios
           (portfolioid
           ,portname
           ,portsector
           ,sortorder
           ,dateCreated
           ,dateModified
           ,dateDeleted
           ,deletedFlag
           ,hiddenFlag)
     VALUES
           (@vnewPortfolioID
           ,@portfolioDesc
           ,@portsector
           ,@maxPortSortVal
           ,CURRENT_TIMESTAMP
           ,NULL
           ,NULL
           ,0
           ,0)
GO


/* Procedure spInsertEarnings Insert value into tbearnings */
CREATE PROCEDURE spInsertEarnings
			@earnquarter int
			,@earndate date
			,@earntime time
			,@outstandingcommonshares bigint
			,@expectedeps money
			,@actualeps money
			,@expectedrevmill money
			,@actualrevmill money
			,@expectednetincomemill money
			,@actualnetincomemill money
AS

DECLARE @vnewEarnID int = next value for seqEarningID;

-- Calculate Beat Loss Ratios
DECLARE @vepsbeatloss money =  isnull((@actualeps - @expectedeps)/@actualeps,0);
DECLARE @vrevbeatloss money = isnull((@actualrevmill-@expectedrevmill)/@actualrevmill,0);
DECLARE @vnetincomebeatloss money = isnull((@actualnetincomemill-@expectednetincomemill)/@actualnetincomemill,0);

INSERT INTO dbo.tbearnings
           (earningsid
           ,earnquarter
           ,earndate
           ,earntime
		   ,outstandingcommonshares
           ,expectedeps
           ,actualeps
           ,epsbeatloss
           ,expectedrevmill
           ,actualrevmill
		   ,revbeatloss
		   ,expectednetincomemill
		   ,actualnetincomemill
		   ,netincomebeatloss
           ,dateCreated
           ,dateModified
           ,dateDeleted
           ,deletedFlag
           ,hiddenFlag)
     VALUES
           (@vnewEarnID
           ,@earnquarter
           ,@earndate
           ,@earntime
		   ,@outstandingcommonshares
           ,@expectedeps
           ,@actualeps
		   ,@vepsbeatloss --declare and calc
           ,@expectedrevmill
           ,@actualrevmill
		   ,@vrevbeatloss --declare and calc
		   ,@expectednetincomemill
		   ,@actualnetincomemill
		   ,@vnetincomebeatloss --declare and calc
           ,CURRENT_TIMESTAMP
           ,NULL
           ,NULL
           ,0
           ,0)
GO

/* Procedure spInsertEvent Insert value into tbevents */
CREATE PROCEDURE spInsertEvent
			@releasedate datetime
           ,@eventtitle varchar(150)
           ,@eventdesc varchar(5000)
           ,@followup_date datetime
           ,@newssource varchar(500)
           ,@newssourceauthor varchar(500)
           ,@newssourcelink varchar(4000)
AS

DECLARE @vnewEventID int = next value for seqEventID;

INSERT INTO dbo.tbevents
           (eventid
           ,releasedate
           ,eventtitle
           ,eventdesc
           ,followup_date
           ,newssource
           ,newssourceauthor
           ,newssourcelink
           ,dateCreated
           ,dateModified
           ,dateDeleted
           ,deletedFlag
           ,hiddenFlag)
     VALUES
           (@vnewEventID
           ,@releasedate 
           ,@eventtitle
           ,@eventdesc
		   ,@followup_date
           ,@newssource
           ,@newssourceauthor
           ,@newssourcelink
		   ,CURRENT_TIMESTAMP
           ,NULL
           ,NULL
           ,0
           ,0)
GO


