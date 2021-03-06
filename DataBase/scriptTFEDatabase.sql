USE [master]
GO
/****** Object:  Database [kkmic-acc]    Script Date: 31-05-21 15:25:17 ******/
CREATE DATABASE [kkmic-acc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'kkmic-acc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kkmic-acc.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'kkmic-acc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\kkmic-acc_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [kkmic-acc] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [kkmic-acc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [kkmic-acc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kkmic-acc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kkmic-acc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kkmic-acc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kkmic-acc] SET ARITHABORT OFF 
GO
ALTER DATABASE [kkmic-acc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [kkmic-acc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kkmic-acc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kkmic-acc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kkmic-acc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [kkmic-acc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kkmic-acc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kkmic-acc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kkmic-acc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kkmic-acc] SET  DISABLE_BROKER 
GO
ALTER DATABASE [kkmic-acc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kkmic-acc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [kkmic-acc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [kkmic-acc] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [kkmic-acc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kkmic-acc] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [kkmic-acc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [kkmic-acc] SET RECOVERY FULL 
GO
ALTER DATABASE [kkmic-acc] SET  MULTI_USER 
GO
ALTER DATABASE [kkmic-acc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [kkmic-acc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [kkmic-acc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [kkmic-acc] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [kkmic-acc] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'kkmic-acc', N'ON'
GO
ALTER DATABASE [kkmic-acc] SET QUERY_STORE = ON
GO
ALTER DATABASE [kkmic-acc] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [kkmic-acc]
GO
/****** Object:  Schema [cc]    Script Date: 31-05-21 15:25:17 ******/
CREATE SCHEMA [cc]
GO
/****** Object:  Schema [cms]    Script Date: 31-05-21 15:25:17 ******/
CREATE SCHEMA [cms]
GO
/****** Object:  Schema [eit]    Script Date: 31-05-21 15:25:17 ******/
CREATE SCHEMA [eit]
GO
/****** Object:  FullTextCatalog [SimpleSearchCatalog]    Script Date: 31-05-21 15:25:17 ******/
CREATE FULLTEXT CATALOG [SimpleSearchCatalog] 
GO
/****** Object:  UserDefinedTableType [cc].[idonly]    Script Date: 31-05-21 15:25:17 ******/
CREATE TYPE [cc].[idonly] AS TABLE(
	[id] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedTableType [cc].[idvalueint]    Script Date: 31-05-21 15:25:17 ******/
CREATE TYPE [cc].[idvalueint] AS TABLE(
	[id] [int] NOT NULL,
	[val] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[val] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  UserDefinedFunction [dbo].[GetCreditsForSubscription]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetCreditsForSubscription]
(
	@subscriptionId INT,
	@qty INT
)
RETURNS INT
AS
BEGIN
	DECLARE @retval INT;

	SELECT @retval = Subscription.CreditPerPeriod * @qty
	FROM CustomerSubscription
	JOIN Subscription ON Subscription.Id = CustomerSubscription.SubscriptionId
	WHERE Subscription.Id = @subscriptionId;

	RETURN @retval;

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetCreditsLeft]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetCreditsLeft]
(
	@customerId INT
)
RETURNS INT
AS
BEGIN
	DECLARE @creditsLeft INT;

	SELECT @creditsLeft = CustomerSubscription.Credits + Packs.Total - Functionalities.Total
	FROM Customer
	JOIN CustomerSubscription ON CustomerSubscription.Id = Customer.CustomerSubscriptionId
	CROSS APPLY (
		SELECT Total = SUM(CreditPack.Credits)
		FROM CustomerCreditPack
		JOIN CreditPack ON CreditPack.Id = CustomerCreditPack.CreditPackId
		WHERE CustomerCreditPack.CustomerSubscriptionId = CustomerSubscription.Id
	) AS Packs
	CROSS APPLY (
		SELECT Total = SUM(Functionality.CreditsCost)
		FROM CustomerFunctionality
		JOIN Functionality ON Functionality.Id = CustomerFunctionality.FunctionalityId
		WHERE CustomerFunctionality.CustomerSubscriptionId = CustomerSubscription.Id
	) AS Functionalities
	WHERE Customer.Id = @customerId;

	RETURN @creditsLeft;

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetEmail]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetEmail]
(
	@userId nvarchar(128)
)
RETURNS nvarchar(256)
AS
BEGIN
	DECLARE @email nvarchar(256)

	SELECT @email = (select Email from AspNetUsers
	where AspNetUsers.Id = @userId
	) 
	RETURN @email;

END
GO
/****** Object:  UserDefinedFunction [dbo].[SplitList]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SplitList] (@list VARCHAR(MAX), @separator VARCHAR(MAX) = ';')
 RETURNS @table TABLE (Value VARCHAR(MAX))
 AS BEGIN
    DECLARE @position INT, @previous INT
    SET @list = @list + @separator
    SET @previous = 1
    SET @position = CHARINDEX(@separator, @list)
    WHILE @position > 0 BEGIN
       IF @position - @previous > 0
          INSERT INTO @table VALUES (SUBSTRING(@list, @previous, @position - @previous))
       IF @position >= LEN(@list) BREAK
       SET @previous = @position + 1
       SET @position = CHARINDEX(@separator, @list, @previous)
    END
    RETURN
END
GO
/****** Object:  Table [cc].[CastingCafeOrganization]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeOrganization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Number] [varchar](50) NULL,
	[ContactFirstname] [varchar](30) NOT NULL,
	[ContactLastname] [varchar](50) NOT NULL,
	[Website] [nvarchar](255) NULL,
	[LegalStatuId] [int] NULL,
	[DomainId] [int] NULL,
	[Publications] [nvarchar](max) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[ContactGender] [int] NULL,
	[ContactBirthDate] [datetime] NULL,
	[ContactPhoneNumber] [varchar](30) NULL,
 CONSTRAINT [PK_91f7aaa473690147701a2499ba0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITFriendlyURL]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITFriendlyURL](
	[Action] [nvarchar](255) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsFavorite] [bit] NOT NULL,
	[Link] [nvarchar](255) NOT NULL,
	[Module] [nvarchar](255) NOT NULL,
	[ObjectId] [int] NOT NULL,
	[Type] [varchar](50) NULL,
 CONSTRAINT [PK_caf268144d98f5827e674edf885] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafePerson]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafePerson](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Gender] [int] NOT NULL,
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Birthdate] [datetime] NULL,
	[NationalRegistrationNumber] [nvarchar](50) NULL,
	[Phone] [nvarchar](30) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[IsChild] [bit] NOT NULL,
	[ParentFirstName] [varchar](50) NULL,
	[ParentLastName] [varchar](50) NULL,
 CONSTRAINT [PK_e0111714925919a7eb25eff2f1f] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafeCustomer]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeCustomer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfessionalName] [varchar](50) NULL,
	[Avatar] [varchar](100) NULL,
	[EITCountryId] [int] NOT NULL,
	[IsBillingAddressSameAsAddress] [bit] NOT NULL,
	[BillingEITCountryId] [int] NULL,
	[VAT] [nvarchar](50) NULL,
	[IBAN] [nvarchar](20) NULL,
	[BIC] [nvarchar](8) NULL,
	[CastingCafePersonId] [int] NULL,
	[CastingCafeRoleId] [int] NOT NULL,
	[EITUserId] [nvarchar](128) NOT NULL,
	[CustomerStatus] [int] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[LevelOfProfessionalization] [int] NULL,
	[Rating] [int] NOT NULL,
	[EITCityId] [int] NULL,
	[BillingEITCityId] [int] NULL,
	[CastingCafeOrganizationId] [int] NULL,
	[ProfileComment] [nvarchar](max) NULL,
	[ValidUntil] [datetime] NULL,
	[LastProfileModification] [datetime] NULL,
	[ProfileViews] [int] NOT NULL,
	[CoverFile] [nvarchar](255) NULL,
	[AddressStreet] [nvarchar](500) NULL,
	[BillingAddressStreet] [nvarchar](500) NULL,
	[AdressNumber] [nvarchar](10) NULL,
	[AddressBox] [nvarchar](10) NULL,
	[BillingAddressBox] [nvarchar](10) NULL,
	[BillingAddressNumber] [nvarchar](10) NULL,
	[CastingSetupId] [int] NULL,
 CONSTRAINT [PK_79a1e394d22aca97ca77ed5a54e] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [cc].[CustomerDisplayView]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [cc].[CustomerDisplayView]
AS 
SELECT 
	cust.Id,
	cust.Avatar,
	cust.ProfessionalName,
	cust.CastingCafePersonId as PersonId,
	person.Gender as PersonGender,
	person.Firstname as PersonFirstName,
	person.Lastname as PersonLastName,
	person.Birthdate as PersonBirthDate,
	cust.CastingCafeOrganizationId as OrgId,
	org.[Name] as OrgName,
	org.ContactFirstname as OrgContactFirstName,
	org.ContactLastname as OrgContactLastName,
	furl.Link as [Url],
	furl.EITCultureId as UrlCultureId
FROM cc.CastingCafeCustomer cust
JOIN eit.EITFriendlyURL furl on furl.ObjectId = cust.Id
LEFT JOIN cc.CastingCafePerson person ON person.Id = cust.CastingCafePersonId
LEFT JOIN cc.CastingCafeOrganization org ON org.Id = cust.CastingCafeOrganizationId
WHERE furl.[Type] = 'CastingCafeCustomersDetail'
AND furl.IsFavorite = 1

GO
/****** Object:  Table [cc].[ProfileItemValueString]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItemValueString](
	[CastingCafeCustomerId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_0bb3fbc472ebfc3f1d79e5df978] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[ProfileItemValueDate]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItemValueDate](
	[CastingCafeCustomerId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [datetime] NOT NULL,
 CONSTRAINT [PK_84663c247e283283f6a9f3963a5] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[ProfileItemValueInt]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItemValueInt](
	[CastingCafeCustomerId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_e5dd5094980b6d996401bf7e5e8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[ProfileItem]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentProfileItemId] [int] NULL,
	[ProfileItemType] [int] NOT NULL,
	[Label] [varchar](40) NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsMandatory] [bit] NOT NULL,
	[NeedCheckBeforeValue] [bit] NOT NULL,
	[IsMultiple] [bit] NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[SearchInputType] [int] NULL,
	[SearchPosition] [int] NULL,
	[SearchIsMultiple] [bit] NULL,
	[SearchIsApproximative] [bit] NULL,
	[SearchApproximativeUpperRange] [int] NULL,
	[SearchApproximaviveLowerRange] [int] NULL,
	[IsMainInfo] [bit] NOT NULL,
	[SearchLabel] [nvarchar](max) NULL,
	[UnitMeasures] [nvarchar](5) NULL,
	[IsDisplayedInSignup] [bit] NOT NULL,
	[IsRestrictedToContacts] [bit] NOT NULL,
 CONSTRAINT [PK_1b86f964ab1a0b501c0e9d5edde] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelProfileItemProfile]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelProfileItemProfile](
	[ProfileId] [int] NOT NULL,
	[ProfileItemId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProfileId] ASC,
	[ProfileItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafeRole]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[RoleType] [int] NOT NULL,
	[EntityStatus] [int] NOT NULL,
	[ProfileId] [int] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[IsIncludedInSearch] [bit] NOT NULL,
	[SkipBookStep] [bit] NOT NULL,
 CONSTRAINT [PK_e3bb28840e791716d8c84dc282a] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[ProfileItemValueBoolean]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItemValueBoolean](
	[CastingCafeCustomerId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [bit] NOT NULL,
 CONSTRAINT [PK_43d5f4446f9a71a7d4863d38b39] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [cc].[ProfileCompletion]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[ProfileCompletion] AS 
	WITH CustomerItem AS (
			SELECT ProfileItemId, CastingCafeCustomerId
			FROM cc.ProfileItemValueInt
			UNION
			SELECT ProfileItemId, CastingCafeCustomerId
			FROM cc.ProfileItemValueBoolean
			UNION
			SELECT ProfileItemId, CastingCafeCustomerId
			FROM cc.ProfileItemValueDate
			UNION
			SELECT ProfileItemId, CastingCafeCustomerId
			FROM cc.ProfileItemValueString
	)
	, Node AS (		
		SELECT parent.Id
		FROM cc.ProfileItem parent
		WHERE parent.ParentProfileItemId IS NULL
	)
	SELECT CastingCafeCustomer.Id AS CustomerId 
		  ,MainProfileItem.Id AS ProfileItemId
		  ,Completed =
			CASE
				WHEN CustomerItem.ParentProfileItemId IS NULL THEN 0
				ELSE 1
			END
	  FROM cc.RelProfileItemProfile rel
	  JOIN cc.ProfileItem MainProfileItem ON rel.ProfileItemId = MainProfileItem.Id
	  JOIN cc.CastingCafeRole ON rel.ProfileId = CastingCafeRole.ProfileId
	  JOIN cc.CastingCafeCustomer ON CastingCafeCustomer.CastingCafeRoleId = CastingCafeRole.Id
	  OUTER APPLY (
		SELECT ProfileItem.ParentProfileItemId
		FROM CustomerItem
		JOIN cc.ProfileItem ON CustomerItem.ProfileItemId = ProfileItem.Id
		WHERE CustomerItem.CastingCafeCustomerId = CastingCafeCustomer.Id
		AND MainProfileItem.Id = ProfileItem.ParentProfileItemId
	  ) AS CustomerItem
	  WHERE MainProfileItem.Id IN (
		SELECT Id FROM Node
	  )
	GROUP BY CastingCafeCustomer.Id, MainProfileItem.Id, CustomerItem.ParentProfileItemId;


GO
/****** Object:  Table [cc].[OrderLine]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[OrderLine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[OrderLineStatus] [int] NOT NULL,
	[PaymentType] [int] NOT NULL,
	[ProductType] [int] NOT NULL,
	[ReccurencyType] [int] NOT NULL,
	[CurrencyId] [int] NULL,
	[PriceUnit] [decimal](8, 2) NOT NULL,
	[SetupFee] [decimal](8, 2) NOT NULL,
	[NumberOfCredit] [int] NULL,
	[NumberOfImage] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[NumberOfBookAllowed] [int] NULL,
	[NumberOfImagePerBook] [int] NULL,
	[ProductFunctionality] [int] NULL,
	[ActiveOn] [datetime] NULL,
	[ValidUntil] [datetime] NULL,
	[UpdateFee] [decimal](8, 2) NULL,
	[UpdateQuantity] [int] NULL,
	[PromocodeId] [int] NULL,
 CONSTRAINT [PK_e44923647b48a74bc88feb895c2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Product]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsFavorite] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ProductType] [int] NOT NULL,
	[PaymentType] [int] NOT NULL,
	[ReccurenceType] [int] NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[Discount] [decimal](8, 2) NULL,
	[NumberOfCredits] [int] NULL,
	[SetupFee] [decimal](8, 2) NULL,
	[EntityStatus] [int] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[NumberOfPictureAllowed] [int] NULL,
	[ProductFunctionality] [int] NULL,
	[NumberOfBookAllowed] [int] NULL,
	[NumberOfImagePerBook] [int] NULL,
	[MinQuantity] [int] NOT NULL,
	[MaxQuantity] [int] NULL,
	[CopiedFrom] [int] NULL,
 CONSTRAINT [PK_de326264541b46c2459df316f1b] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Order]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[OrderStatus] [int] NOT NULL,
	[VATRate] [decimal](4, 2) NOT NULL,
	[IsReverseCharge] [bit] NOT NULL,
	[Discount] [decimal](8, 2) NOT NULL,
	[TotalToPay] [decimal](8, 2) NOT NULL,
	[DueDate] [date] NULL,
	[PaidOn] [datetime] NULL,
	[OrderPaymentMode] [int] NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[BillNumber] [int] NULL,
	[OrderReferenceRF] [nvarchar](max) NULL,
	[BillingEITCountryId] [int] NULL,
	[BillingEITCityId] [int] NULL,
	[VAT] [nvarchar](50) NULL,
	[IBAN] [nvarchar](max) NULL,
	[BIC] [nvarchar](8) NULL,
	[BillingAddressStreet] [nvarchar](500) NULL,
	[BillingAddressNumber] [nvarchar](10) NULL,
	[BillingAddressBox] [nvarchar](10) NULL,
 CONSTRAINT [PK_30af047427daf4c390f5d61c876] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [cc].[CreditsStatus]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [cc].[CreditsStatus] AS 
SELECT
	CustomerId = cust.Id,
	CreditsBought,
	CreditsUsed 
FROM
	cc.CastingCafeCustomer cust
	CROSS APPLY (
		SELECT CreditsBought = ISNULL(SUM(
		CASE 
			WHEN Product.ProductType = 0 THEN lbought.NumberOfCredit * lbought.Quantity
			WHEN Product.ProductType = 1 THEN
				CASE
					WHEN Product.ReccurenceType = 0 THEN CONVERT(INT, ROUND(lbought.NumberOfCredit / 7.0, 0)) * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil)
					WHEN Product.ReccurenceType = 1 THEN CONVERT(INT, ROUND(lbought.NumberOfCredit / 30.4, 0)) * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil)
					WHEN Product.ReccurenceType = 2 THEN CONVERT(INT, ROUND(lbought.NumberOfCredit / 365.0, 0)) * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil)
					WHEN Product.ReccurenceType = 3 THEN lbought.NumberOfCredit
					ELSE lbought.NumberOfCredit * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil)
				END
		END), 0)
		FROM cc.[Order] obought
		LEFT JOIN cc.OrderLine lbought ON obought.Id = lbought.OrderId
									   AND lbought.ProductType IN (0, 1)
									   AND lbought.OrderLineStatus = 2
									   AND lbought.NumberOfCredit IS NOT NULL
									   --AND (lbought.ValidUntil iS NULL OR lbought.ValidUntil >= SYSDATETIME())
		LEFT JOIN cc.Product ON lbought.ProductId = Product.Id
		WHERE
			obought.CastingCafeCustomerId = cust.Id
			AND obought.OrderStatus = 2
	) AS CreditsBought
	CROSS APPLY (
		SELECT CreditsUsed = ISNULL(SUM(CONVERT(INT, lused.PriceUnit * lused.Quantity)), 0)
		FROM cc.[Order] oused
		LEFT JOIN cc.OrderLine lused ON oused.Id = lused.OrderId
									 AND lused.ProductType = 2
									 AND lused.OrderLineStatus = 2
		WHERE
			oused.CastingCafeCustomerId = cust.Id
			AND oused.OrderStatus = 2
	) AS CreditsUsed
GO
/****** Object:  Table [cc].[CastingCalled]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCalled](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[CastingId] [int] NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[ManageComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_816151a49f39fef00fd345e60ca] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Casting]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Casting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[CastingTypeId] [int] NOT NULL,
	[Title] [varchar](150) NULL,
	[Description] [varchar](max) NULL,
	[EITCityId] [int] NOT NULL,
	[EITCountryId] [int] NOT NULL,
	[MediaType] [int] NULL,
	[MediaValue] [varchar](100) NULL,
	[Status] [int] NOT NULL,
	[OrderLineId] [int] NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[ManageComment] [nvarchar](max) NULL,
	[PublicationMode] [int] NOT NULL,
	[CastingCafeRoleId] [int] NOT NULL,
	[CroppedDescription]  AS (left([Description],(200))) PERSISTED,
	[CastingSetupId] [int] NULL,
 CONSTRAINT [PK_e7c03e642d8b1e9516da355fd79] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [cc].[CastingCallCounter]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [cc].[CastingCallCounter] AS 
SELECT 
	Casting.Id AS CastingId,
	(SELECT COUNT(1) FROM cc.CastingCalled WHERE CastingId = Casting.Id AND [Status] IN (2, 3)) AS InvitationsCount,
    (SELECT COUNT(1) FROM cc.CastingCalled WHERE CastingId = Casting.Id AND [Status] = 6) AS CandidaciesCount,
    (SELECT COUNT(1) FROM cc.CastingCalled WHERE CastingId = Casting.Id AND [Status] IN (4, 7, 9, 11)) AS ConfirmedCount
FROM cc.Casting


GO
/****** Object:  View [cc].[SimpleSearchTalent]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[SimpleSearchTalent] WITH SCHEMABINDING AS 

SELECT 
	CastingCafeCustomer.Id AS CustomerId,
	CONCAT_WS(' ', CastingCafeCustomer.ProfessionalName, CastingCafePerson.Firstname, CastingCafePerson.Lastname) AS CustomerName
FROM cc.CastingCafeCustomer
JOIN cc.CastingCafePerson ON CastingCafeCustomer.CastingCafePersonId = CastingCafePerson.Id

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [ClusteredIndex-SimpleSearchTalent]    Script Date: 31-05-21 15:25:17 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-SimpleSearchTalent] ON [cc].[SimpleSearchTalent]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCountry]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCountry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[Latitude] [nvarchar](max) NOT NULL,
	[Longitude] [nvarchar](max) NOT NULL,
	[EITCurrencyId] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_fbb264f48918780c0a1e7a83569] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](256) NULL,
	[EITCultureId] [int] NULL,
	[Token] [uniqueidentifier] NULL,
 CONSTRAINT [PK__AspNetUs__3214EC07301623C4] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [cc].[OrderSearchView]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[OrderSearchView] AS 
SELECT 
	ord.Id,
	cust.Id as CustomerId,
	ISNULL(orga.ContactFirstname +  ' ', '') + 
	ISNULL(orga.ContactLastname +  ' ', '') +
	ISNULL(person.Firstname +  ' ', '') +
	ISNULL(person.Lastname +  ' ', '') +
	ISNULL(cust.ProfessionalName +  ' ', '') +
	ISNULL(orga.Name, '')
	as CustomerIdentity,
	country.Id as CountryId,
	cust.CastingCafeRoleId,
	us.Email as EmailAddress,
	cust.CustomerStatus,
	ord.EITSvcStampCreatedAt as CreatedAt,
	ord.OrderStatus,
	ord.PaidOn,
	ord.OrderPaymentMode,
	ord.BillNumber,
	-- ol.ProductId,
	-- ol.ProductType,
	-- ol.OrderLineStatus,
	cust.IBAN,
	cust.LastProfileModification,
	cust.LevelOfProfessionalization,
	cust.Rating
FROM cc.CastingCafeCustomer cust
INNER JOIN cc.[Order] ord ON ord.CastingCafeCustomerId = cust.Id
INNER JOIN cc.OrderLine ol ON ol.OrderId = ord.Id
INNER JOIN eit.EITCountry country ON country.Id = cust.EITCountryId
INNER JOIN dbo.AspNetUsers us ON us.Id = cust.EITUserId
LEFT JOIN cc.CastingCafePerson person ON person.Id = cust.CastingCafePersonId
LEFT JOIN cc.CastingCafeOrganization orga ON orga.Id = cust.CastingCafeOrganizationId
WHERE ol.ProductType != 2
GROUP BY 
	ord.Id,
	cust.Id,
	ISNULL(orga.ContactFirstname +  ' ', '') + 
	ISNULL(orga.ContactLastname +  ' ', '') +
	ISNULL(person.Firstname +  ' ', '') +
	ISNULL(person.Lastname +  ' ', '') +
	ISNULL(cust.ProfessionalName +  ' ', '') +
	ISNULL(orga.Name, ''),
	country.Id,
	cust.CastingCafeRoleId,
	us.Email,
	cust.CustomerStatus,
	ord.OrderPaymentMode,
	ord.EITSvcStampCreatedAt,
	ord.OrderStatus,
	ord.PaidOn,
ord.BillNumber,
	-- ol.ProductId,
	-- ol.ProductType,
	-- ol.OrderLineStatus,
	cust.IBAN,
	cust.LastProfileModification,
	cust.LevelOfProfessionalization,
	cust.Rating
GO
/****** Object:  View [cc].[SimpleSearchPro]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[SimpleSearchPro] 
WITH SCHEMABINDING AS 

SELECT 
	CastingCafeCustomer.Id AS CustomerId,
	CONCAT_WS(' ', CastingCafeCustomer.ProfessionalName, CastingCafeOrganization.[Name], CastingCafeOrganization.ContactFirstname, CastingCafeOrganization.ContactLastname) AS CustomerName
FROM cc.CastingCafeCustomer
JOIN cc.CastingCafeOrganization ON CastingCafeCustomer.CastingCafeOrganizationId = CastingCafeOrganization.Id
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [ClusteredIndex-SimpleSearchPro]    Script Date: 31-05-21 15:25:17 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-SimpleSearchPro] ON [cc].[SimpleSearchPro]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [cc].[CustomerFrontSearch]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [cc].[CustomerFrontSearch] AS 
SELECT 
	cust.Id,
	cust.Id AS CustomerId, 
	cust.EITCityId, 
	cust.EITCountryId, 
	cust.ValidUntil,
	cust.CustomerStatus,
	role.Id AS RoleId, 
	role.RoleType, 
	-- service.ServiceTypeId, 
	person.Birthdate, 
	person.Gender, 
	(cust.Rating * 20 * 1.0) + ((100 - DATEDIFF(DAY, cust.LastProfileModification, GETDATE())) * 1) AS DisplayOrder
FROM            
	cc.CastingCafeCustomer AS cust 
	INNER JOIN cc.CastingCafeRole AS role ON role.Id = cust.CastingCafeRoleId 
	LEFT JOIN cc.CastingCafePerson AS person ON person.Id = cust.CastingCafePersonId 
-- LEFT JOIN cc.CustomerService AS service ON service.CastingCafeCustomerId = cust.Id
WHERE 
	(cust.CustomerStatus = 4) AND 
	(cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())
GO
/****** Object:  Table [cc].[NewsletterSubscription]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[NewsletterSubscription](
	[Date] [datetime] NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reccurence] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[CastingCafeCustomerId] [int] NULL,
	[Token] [uniqueidentifier] NULL,
 CONSTRAINT [PK_d43f5244dc3bab631cc5734913d] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [cc].[CustomerSearchView]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [cc].[CustomerSearchView] AS
SELECT 
	cust.Id,
		ISNULL(orga.ContactFirstname +  ' ', '') + 
		ISNULL(orga.ContactLastname +  ' ', '') +
		ISNULL(person.Firstname +  ' ', '') +
		ISNULL(person.Lastname +  ' ', '') +
		ISNULL(cust.ProfessionalName +  ' ', '') +
		ISNULL(orga.Name, '')
	as CustomerIdentity,
	country.Id as CountryId,
	cust.CastingCafeRoleId,
	us.Email as EmailAddress,
	cust.CustomerStatus,
	cust.IBAN,
	cust.LastProfileModification,
	cust.LevelOfProfessionalization,
	cust.Rating,
	HasNewsletter = subsc.Active,
	CurrentSubscriptionName = (
		SELECT TOP 1 p.Title
		FROM cc.[Order] o
		LEFT JOIN cc.[OrderLine] ol ON ol.OrderId = o.Id AND ol.ProductType = 1 AND ol.ActiveOn IS NOT NULL -- subscriptions only
		LEFT JOIN cc.Product p ON ol.ProductId = p.Id
		WHERE o.CastingCafeCustomerId = cust.Id
		AND (cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())
		AND (ol.ValidUntil IS NULL OR ol.ValidUntil >= GETDATE())
		AND ol.OrderLineStatus = 2
		ORDER BY o.PaidOn DESC
	)
FROM cc.CastingCafeCustomer cust
INNER JOIN eit.EITCountry country ON country.Id = cust.EITCountryId
INNER JOIN dbo.AspNetUsers us ON us.Id = cust.EITUserId
LEFT JOIN cc.CastingCafePerson person ON person.Id = cust.CastingCafePersonId
LEFT JOIN cc.CastingCafeOrganization orga ON orga.Id = cust.CastingCafeOrganizationId
LEFT JOIN cc.NewsletterSubscription subsc ON subsc.CastingCafeCustomerId = cust.Id
GO
/****** Object:  View [cc].[CastingSearchView]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[CastingSearchView] AS 
SELECT 
	cust.Id,
	casting.Id as CastingId,
	casting.CastingTypeId,
	cust.Id AS CustomerId, 
	cust.CastingCafeRoleId as CustomerRoleId,
	cust.ValidUntil as CustomerValidUntil,
	cust.CustomerStatus as CustomerStatus,
	casting.EITCityId, 
	casting.EITCountryId,
	(cust.Rating * 20 * 1.0) + (100 + (DATEDIFF(DAY, casting.StartDateTime, GETDATE())) * 1) AS DisplayOrder
FROM 
	cc.Casting casting
INNER JOIN cc.CastingCafeCustomer AS cust ON cust.Id = casting.CastingCafeCustomerId
WHERE 
	(casting.PublicationMode = 0) AND 
	(casting.Status = 5) AND 
	(casting.EndDateTime >= GETDATE()) AND
	(cust.CustomerStatus = 4) AND 
	(cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())
GO
/****** Object:  Table [cc].[CustomerService]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CustomerService](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[EITCountryId] [int] NULL,
	[EITCityId] [int] NULL,
	[PriceUnitTypeId] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[PriceMax] [float] NULL,
	[PriceMin] [float] NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[Status] [int] NOT NULL,
	[MediaValue] [varchar](100) NULL,
	[MediaType] [int] NULL,
	[ManageComment] [text] NULL,
	[OrderLineId] [int] NULL,
	[EITCurrencyId] [int] NULL,
	[PublicationDate] [date] NOT NULL,
 CONSTRAINT [PK_55007474dba9961456b3c27f9aa] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [cc].[SearchView]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [cc].[SearchView] AS 
SELECT 
	casting.Id as ObjectId,
	'Casting' as ObjectType,
	cust.Id AS CustomerId, 
	cust.CastingCafeRoleId as CustomerRoleId,
	casting.EITCityId, 
	casting.EITCountryId,
	(cust.Rating * 20 * 1.0) + (100 + (DATEDIFF(DAY, casting.StartDateTime, GETDATE())) * 1) AS DisplayOrder,
	cust.Rating,
	cust.ProfileViews
FROM 
	cc.Casting casting
INNER JOIN cc.CastingCafeCustomer AS cust ON cust.Id = casting.CastingCafeCustomerId
WHERE 
	(casting.PublicationMode = 0) AND 
	(casting.Status = 3) AND 
	(casting.StartDateTime > GETDATE()) AND
	(cust.CustomerStatus = 4) AND 
	(cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())

UNION 

	SELECT 
		cust.Id AS ObjectId, 
		'Customer' AS ObjectType,
		cust.Id AS CustomerId, 
		cust.CastingCafeRoleId as CustomerRoleId,
		cust.EITCityId, 
		cust.EITCountryId, 
		(cust.Rating * 20 * 1.0) + ((100 - DATEDIFF(DAY, cust.LastProfileModification, GETDATE())) * 1) AS DisplayOrder,
		cust.Rating,
		cust.ProfileViews
	FROM            
		cc.CastingCafeCustomer AS cust 
	INNER JOIN cc.CastingCafeRole AS role ON role.Id = cust.CastingCafeRoleId 
	WHERE 
		(cust.CustomerStatus = 4) AND 
		(cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())


UNION
	 SELECT 
		custService.Id AS ObjectId, 
		'CustomerService' AS ObjectType,
		cust.Id AS CustomerId, 
		cust.CastingCafeRoleId as CustomerRoleId,
		cust.EITCityId, 
		cust.EITCountryId, 
		(cust.Rating * 20 * 1.0) + ((100 - DATEDIFF(DAY, custService.EITSvcStampUpdatedAt, GETDATE())) * 1) AS DisplayOrder,
		cust.Rating,
		cust.ProfileViews
	FROM            
		cc.CustomerService AS custService
	INNER JOIN cc.CastingCafeCustomer as cust ON custService.CastingCafeCustomerId = cust.Id
	INNER JOIN cc.CastingCafeRole AS role ON role.Id = cust.CastingCafeRoleId 
	WHERE 
		(cust.CustomerStatus = 4) AND 
		(cust.ValidUntil IS NULL OR cust.ValidUntil >= GETDATE())
		AND custService.Status = 2
GO
/****** Object:  View [cc].[RowCountByIndex]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [cc].[RowCountByIndex]
AS
SELECT id, rowcnt 
FROM sys.sysindexes
WHERE indid in (0,1);
GO
/****** Object:  Table [cc].[BlackListedWords]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[BlackListedWords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntityType] [int] NOT NULL,
	[Words] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_bfcf73d41dbb1eaf92647e832fd] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Book]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Book](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](499) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ManageComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_e8211fa48d28d501fef45180c95] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[BookItem]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[BookItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BookId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[Copyright] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[MediaType] [int] NOT NULL,
	[MediaValue] [varchar](100) NULL,
	[Dimensions] [varchar](20) NULL,
	[DateTaken] [date] NULL,
 CONSTRAINT [PK_fe644394cf9bf405d1d809f8b6c] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafeConfiguration]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeConfiguration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BankAccount] [nvarchar](255) NULL,
	[BankAccountBIC] [nvarchar](255) NULL,
	[BankAccountName] [nvarchar](255) NULL,
	[EmailPaymentLog] [nvarchar](255) NULL,
 CONSTRAINT [PK_222e9a64895b9118c1826b5234d] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafeConfigurationLocal]    Script Date: 31-05-21 15:25:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeConfigurationLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeConfigurationId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[BankAccount] [nvarchar](255) NULL,
	[BankAccountBIC] [nvarchar](255) NULL,
	[BankAccountName] [nvarchar](255) NULL,
	[EmailPaymentLog] [nvarchar](255) NULL,
	[VATRate] [decimal](4, 2) NOT NULL,
	[ApplyVatRateInOrders] [bit] NOT NULL,
	[IsHq] [bit] NOT NULL,
	[BankTransferDueDay] [int] NOT NULL,
	[VATRegEx] [nvarchar](250) NOT NULL,
	[Placeholder] [nvarchar](255) NULL,
 CONSTRAINT [PK_b263b67497990bcd588bc7273df] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingCafeRoleLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingCafeRoleLocal](
	[CastingCafeRoleId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](30) NULL,
 CONSTRAINT [PK_c82f4c347b58039f65493b9a318] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingSearchBooleanCriterion]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingSearchBooleanCriterion](
	[HeaderId] [int] NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [bit] NOT NULL,
 CONSTRAINT [PK_CastingSearchHeader_ProfileItemBool] PRIMARY KEY CLUSTERED 
(
	[HeaderId] ASC,
	[ProfileItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingSearchHeader]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingSearchHeader](
	[CastingId] [int] NOT NULL,
	[ZoneKm] [int] NOT NULL,
	[Gender] [int] NULL,
	[AgeMin] [int] NULL,
	[AgeMax] [int] NULL,
 CONSTRAINT [PK_CastingSearchHeader_1] PRIMARY KEY CLUSTERED 
(
	[CastingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingSearchIntCriterion]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingSearchIntCriterion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HeaderId] [int] NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_CastingSearchIntCriterion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingSetup]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingSetup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlertsEmail] [varchar](100) NOT NULL,
	[AlertsFrequencyType] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_c8c8b44470ea56e6928d3f4fc62] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CastingTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CastingTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[CastingTypeId] [int] NOT NULL,
	[Title] [varchar](30) NULL,
 CONSTRAINT [PK_07ad5a24bc6a19bc5d0de7d782b] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CodePromo]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CodePromo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CodePromoType] [int] NOT NULL,
	[DiscountType] [int] NOT NULL,
	[Code] [nvarchar](6) NOT NULL,
	[Amount] [float] NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[ProductId] [int] NULL,
	[IsUsed] [bit] NOT NULL,
	[OrderLineId] [int] NULL,
 CONSTRAINT [PK_955268b4309b3344c205436599c] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Composite]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Composite](
	[CustomerId] [int] NOT NULL,
	[UseAvatarForMainPicture] [bit] NOT NULL,
	[BookItem01Id] [int] NULL,
	[BookItem02Id] [int] NULL,
	[BookItem03Id] [int] NULL,
	[CreationDateTime] [datetime2](0) NOT NULL,
	[LastUpdateDateTime] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_Composite] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CreditNote]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CreditNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
	[CreditNoteType] [int] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[Amount] [float] NULL,
	[Reason] [nvarchar](max) NOT NULL,
	[BankAccount] [nvarchar](max) NULL,
 CONSTRAINT [PK_a7421ce448a860fdff89adcc4b9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[CustomerProfileHistory]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CustomerProfileHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CustomerStatus] [int] NOT NULL,
 CONSTRAINT [PK_1843127499bba27d030d15b32c9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CustomerSavedSearch]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CustomerSavedSearch](
	[CustomerId] [int] NOT NULL,
	[SearchRequestGuid] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DateSavedUtc] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_CustomerSavedSearch] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC,
	[SearchRequestGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[CustomerWallet]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[CustomerWallet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[MaskedPan] [nvarchar](max) NOT NULL,
	[PaymentMeanId] [nvarchar](max) NOT NULL,
	[Firstname] [nvarchar](max) NOT NULL,
	[Lastname] [nvarchar](max) NOT NULL,
	[CVVCrypted] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_340eb564416bdce41d4e51c6a57] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[DelegationRequest]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[DelegationRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SentDateTime] [datetime2](0) NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
	[Position] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_DelegationRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Domain]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Domain](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
 CONSTRAINT [PK_3f8bd0349b49eb2a1a77428c238] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[DomainLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[DomainLocal](
	[DomainId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_cc318884eef9ed7fc0e1065f286] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[Exposure]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Exposure](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExposureEntityId] [int] NOT NULL,
	[ExposureEntityType] [int] NOT NULL,
	[ExposurePositionType] [int] NOT NULL,
	[DateFrom] [datetime] NULL,
	[DateTo] [datetime] NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[OrderLineId] [int] NULL,
 CONSTRAINT [PK_Exposure] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[GlobalPromocode]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[GlobalPromocode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[DiscountType] [int] NULL,
	[Amount] [int] NOT NULL,
	[RoleType] [int] NULL,
	[DateCreated] [datetime2](0) NOT NULL,
	[ValidFrom] [date] NULL,
	[ValidUntil] [date] NULL,
 CONSTRAINT [PK_GlobalPromocode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[GlobalPromocode_Product]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[GlobalPromocode_Product](
	[PromocodeId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_GlobalPromocode_Product] PRIMARY KEY CLUSTERED 
(
	[PromocodeId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[GlobalPromocode_Role]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[GlobalPromocode_Role](
	[PromocodeId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_GlobalPromocode_Role] PRIMARY KEY CLUSTERED 
(
	[PromocodeId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[GlobalPromocodeUsage]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[GlobalPromocodeUsage](
	[PromocodeId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[DateUsed] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_GlobalPromocodeUsage] PRIMARY KEY CLUSTERED 
(
	[PromocodeId] ASC,
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[InternalMessage]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[InternalMessage](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuthorId] [int] NOT NULL,
	[RecipientId] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Subject] [varchar](150) NOT NULL,
	[Content] [varchar](4000) NOT NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_d27884940cda9e6eaf5887e096a] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[LegalStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[LegalStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
 CONSTRAINT [PK_70753a648758870ab5928802008] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[LegalStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[LegalStatusLocal](
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[LegalStatusId] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_2af42cb43818b0e10385af5df35] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[OnlinePaymentInfo]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[OnlinePaymentInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransactionReference] [nvarchar](50) NULL,
	[ResponseCode] [nvarchar](50) NULL,
	[AcquirerResponseCode] [nvarchar](50) NULL,
	[TransactionDateTime] [datetime] NULL,
	[Amount] [nvarchar](50) NULL,
	[CardCSCResultCode] [nvarchar](50) NULL,
	[CurrencyId] [int] NULL,
	[CustomerIpAddress] [nvarchar](max) NULL,
	[PaymentMeanBrand] [nvarchar](50) NULL,
	[PaymentMeanType] [nvarchar](max) NULL,
	[Datas] [nvarchar](max) NULL,
	[CustomerWalletId] [int] NULL,
 CONSTRAINT [PK__OnlinePa__3214EC0716DCBBD7] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[PriceUnitType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[PriceUnitType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](200) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_b16e3534771b036165ef30c6129] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[PriceUnitTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[PriceUnitTypeLocal](
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](20) NULL,
	[PriceUnitTypeId] [int] NOT NULL,
 CONSTRAINT [PK_65bcfac414182a357ee80c2f3c3] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[Profile]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Profile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_99cad14426197c4c6e814f74655] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[ProfileItemLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ProfileItemLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](40) NULL,
	[Description] [nvarchar](max) NULL,
	[ProfileItemId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[SearchLabel] [nvarchar](500) NULL,
	[UnitMeasures] [nvarchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[Publication]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Publication](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerId] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[PublicationName] [nvarchar](255) NOT NULL,
	[MediaType] [int] NOT NULL,
	[MediaValue] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[PublicationDate] [datetime] NOT NULL,
	[ManageComment] [nvarchar](255) NULL,
 CONSTRAINT [PK_5f57e814db1b2084b44f1d10173] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelCastingCafeCustomerCasting]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelCastingCafeCustomerCasting](
	[CastingCafeCustomerId] [int] NOT NULL,
	[CastingId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_e28cabe4ea4bec96bb190273c05] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelCastingCafeCustomerCastingCafeCustomer]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer](
	[FromCastingCafeCustomerId] [int] NOT NULL,
	[ToCastingCafeCustomerId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[Status] [int] NOT NULL,
	[OrderLineId] [int] NULL,
 CONSTRAINT [PK_4cbfa884a3ca24aaa0d31f0aea4] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelCastingCafeCustomerCustomerService]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelCastingCafeCustomerCustomerService](
	[CastingCafeCustomerId] [int] NOT NULL,
	[CustomerServiceId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_f169d1a4e8085024930d1dbb48f] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelCastingCafeRoleCastingCafeRole]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelCastingCafeRoleCastingCafeRole](
	[FromCastingCafeRoleId] [int] NOT NULL,
	[ToCastingCafeCustomerId] [int] NOT NULL,
 CONSTRAINT [PK_e9e3d634b8590cf88e5e91a17bd] PRIMARY KEY CLUSTERED 
(
	[FromCastingCafeRoleId] ASC,
	[ToCastingCafeCustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelCastingCafeRoleCustomerServiceType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelCastingCafeRoleCustomerServiceType](
	[CastingCafeRoleId] [int] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
 CONSTRAINT [PK_781f5424c169caad9d3e0152112] PRIMARY KEY CLUSTERED 
(
	[CastingCafeRoleId] ASC,
	[ServiceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelNewsletterSubscriptionTerm]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelNewsletterSubscriptionTerm](
	[NewsletterSubscriptionId] [int] NOT NULL,
	[TermId] [int] NOT NULL,
 CONSTRAINT [PK_6b31127467bbbba6dc07369820f] PRIMARY KEY CLUSTERED 
(
	[NewsletterSubscriptionId] ASC,
	[TermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[RelProductCastingCafeRole]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[RelProductCastingCafeRole](
	[CastingCafeRoleId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_36c606f40cea47f25fcc7b42389] PRIMARY KEY CLUSTERED 
(
	[CastingCafeRoleId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[Reviews]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[Reviews](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CastingCafeCustomerAuthorId] [int] NOT NULL,
	[CastingCafeCustomerTargetId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Comment] [varchar](max) NULL,
	[Rating] [int] NOT NULL,
 CONSTRAINT [PK_c4a95894526b013bcea3c25e2de] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cc].[ServiceType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ServiceType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_3e765f84a5d996bf9256833e6cb] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cc].[ServiceTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cc].[ServiceTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[Title] [varchar](30) NULL,
 CONSTRAINT [PK_0cdc5ca4197a4e9c433dc3d7a74] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [cms].[Block]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[SystemName] [nvarchar](255) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
 CONSTRAINT [PK_76424d24c728b2d68c2030ee327] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[BlockLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[BlockLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BlockId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Body] [varchar](max) NULL,
 CONSTRAINT [PK_8f6aa304a94a0de43dd96d76b1e] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[News]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Image] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Summary] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[TermId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[PromotedToHomepage] [bit] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageTitle] [nvarchar](160) NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_e1b881c46b39b7a213b0f2ae7ef] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[NewsLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[NewsLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[Title] [varchar](300) NULL,
	[Summary] [varchar](1500) NULL,
	[Description] [nvarchar](max) NULL,
	[NewsId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageTitle] [nvarchar](160) NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_0b9e16f41528394415b9fc8fd69] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[Page]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Page](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[MainContent] [nvarchar](max) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[IsProtected] [bit] NOT NULL,
	[SystemName] [nvarchar](255) NOT NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageTitle] [nvarchar](160) NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_e1f0bdf4fa7956d50d35ccf44a8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[PageLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[PageLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[MainContent] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageTitle] [nvarchar](160) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_9c075114d018663cdf90f5f9714] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[SliderItem]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[SliderItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[SliderRegion] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[MediaType] [int] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
 CONSTRAINT [PK_451856d4ab38e45a0acfa24de0e] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[SliderItemLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[SliderItemLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[SliderItemId] [int] NOT NULL,
	[Description] [varchar](max) NULL,
	[IsActiveInCulture] [bit] NOT NULL,
 CONSTRAINT [PK_b01ebe54c79876b37c4581602ed] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[Term]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[Term](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageTitle] [nvarchar](160) NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_ae53d5e4da6b5b0d0047a2e03b3] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[TermLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[TermLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITSvcPageTitle] [nvarchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[TermId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[EITSvcPageAdditionalMeta] [nvarchar](max) NULL,
	[EITSvcPageDescription] [nvarchar](355) NULL,
	[EITSvcPageURL] [nvarchar](255) NULL,
	[EITSvcPageOGDescription] [nvarchar](355) NULL,
	[EITSvcPageOGImage] [nvarchar](355) NULL,
	[EITSvcPageOGTitle] [nvarchar](355) NULL,
 CONSTRAINT [PK_8d042834c608f60f4973e31b89f] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[TextTemplate]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[TextTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](255) NOT NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[TextTemplateType] [int] NOT NULL,
	[EITSvcStampCreatedAt] [datetime] NULL,
	[EITSvcStampCreatedBy] [nvarchar](255) NULL,
	[EITSvcStampDeletedAt] [datetime] NULL,
	[EITSvcStampDeletedBy] [nvarchar](255) NULL,
	[EITSvcStampUpdatedAt] [datetime] NULL,
	[EITSvcStampUpdatedBy] [nvarchar](255) NULL,
 CONSTRAINT [PK_0e041a142e79721f3e052f12f4f] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [cms].[TextTemplateLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cms].[TextTemplateLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[TextTemplateId] [int] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_cdabc3442c58a6175c1fafc0c0b] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Discriminator] [nvarchar](256) NULL,
 CONSTRAINT [PK__AspNetRo__3214EC076D99EEFC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspnetRolesEITPermission]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspnetRolesEITPermission](
	[RoleId] [uniqueidentifier] NOT NULL,
	[PermissionId] [int] NOT NULL,
 CONSTRAINT [PK__AspnetRo__6400A1A8D3CAA2A3] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK__AspNetUs__3214EC0763D443A8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK__AspNetUs__663BD39E51B31908] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK__AspNetUs__AF2760AD2C48A32E] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsersCultures]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsersCultures](
	[UserId] [uniqueidentifier] NOT NULL,
	[EITCultureId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[EITCultureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsersEITCultures]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsersEITCultures](
	[UserId] [uniqueidentifier] NOT NULL,
	[EITCultureId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[EITCultureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Block]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Block](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](255) NULL,
	[Body] [varchar](max) NULL,
	[SystemName] [nvarchar](100) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Block] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlockLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Body] [varchar](max) NULL,
	[BlockId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_BlockLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOCustomerNote]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOCustomerNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BOUserEmail] [varchar](255) NOT NULL,
	[NoteText] [varchar](max) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_BOCustomerNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[City]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](60) NULL,
	[Title] [nvarchar](500) NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[Geography] [geography] NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[GeoPostCodeId] [bigint] NOT NULL,
	[StateId] [int] NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CityLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](500) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[CityId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
 CONSTRAINT [PK_CityLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NULL,
	[Label] [varchar](255) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[CurrencyId] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_CountryLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditPack]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditPack](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[Credits] [int] NULL,
	[EntityStatusId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CreditPack] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditPackLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditPackLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[CreditPackId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CreditPackLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Culture]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Culture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LCID] [varchar](50) NOT NULL,
	[Host] [varchar](30) NULL,
	[Name] [varchar](50) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[LanguageCode] [char](2) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Culture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](50) NOT NULL,
	[Code] [varchar](5) NOT NULL,
	[Symbol] [varchar](5) NOT NULL,
	[CodeSIPS] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](50) NULL,
	[CurrencyId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CurrencyLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NULL,
	[ProfessionnalName] [varchar](100) NULL,
	[Email]  AS ([dbo].[GetEmail]([UserId])),
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Birthdate] [date] NULL,
	[Avatar] [varchar](100) NULL,
	[NationalRegistrationNumber] [varchar](50) NULL,
	[Phone] [varchar](30) NULL,
	[IsChild] [bit] NULL,
	[ParentFirstName] [varchar](50) NULL,
	[ParentLastName] [varchar](50) NULL,
	[OrganizationId] [int] NULL,
	[MainRoleId] [int] NULL,
	[CustomerSubscriptionId] [int] NULL,
	[CreditsLeft]  AS ([dbo].[GetCreditsLeft]([Id])),
	[IsBillingAddressSameAsAddress] [bit] NULL,
	[VAT] [varchar](50) NULL,
	[IBAN] [varchar](50) NULL,
	[BIC] [varchar](8) NULL,
	[CustomerStatus] [int] NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[Rating] [int] NULL,
	[LastProfileModification] [datetime2](0) NULL,
	[CustomerEventSetupId] [int] NULL,
	[ProfileViews] [int] NULL,
	[CoverFile] [varchar](255) NULL,
	[AddressStreet] [varchar](500) NULL,
	[AddressNumber] [varchar](50) NULL,
	[AddressBox] [varchar](10) NULL,
	[BillingAddressStreet] [varchar](500) NULL,
	[BillingAddressNumber] [varchar](50) NULL,
	[BillingAddressBox] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerCreditPack]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCreditPack](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[BillNumber] [int] NULL,
	[CustomerId] [int] NOT NULL,
	[CustomerSubscriptionId] [int] NOT NULL,
	[CreditPackId] [int] NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[OrderLineStatusId] [int] NOT NULL,
	[OrderPaymentModeId] [int] NULL,
	[OrderReferenceRF] [varchar](max) NULL,
	[PriceUnit] [decimal](8, 2) NOT NULL,
	[NumberOfCredits] [int] NULL,
	[Quantity] [int] NOT NULL,
	[VATRate] [decimal](4, 2) NOT NULL,
	[BillingCountryId] [int] NOT NULL,
	[BillingCityId] [int] NOT NULL,
	[Discount] [decimal](8, 2) NOT NULL,
	[TotalToPay] [decimal](8, 2) NOT NULL,
	[CurrencyId] [int] NULL,
	[IsReverseCharge] [bit] NOT NULL,
	[DueDate] [date] NULL,
	[PaidOnDateTime] [datetime2](0) NULL,
	[PaymentTypeId] [int] NOT NULL,
	[ActiveOnDateTime] [datetime2](0) NULL,
	[ValidUntilDateTime] [datetime2](0) NULL,
	[VAT] [varchar](50) NOT NULL,
	[IBAN] [varchar](max) NOT NULL,
	[BIC] [varchar](8) NOT NULL,
	[BillingAddressStreet] [varchar](500) NOT NULL,
	[BillingAddressNumber] [varchar](10) NOT NULL,
	[BillingAddressBox] [varchar](10) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[PromoCodeId] [int] NULL,
 CONSTRAINT [PK_CustomerCreditPack] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEvent]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEvent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](7) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[CustomerId] [int] NOT NULL,
	[MediaType] [int] NOT NULL,
	[MediaValue] [varchar](100) NULL,
	[Status] [int] NULL,
	[OrderLineId] [int] NULL,
	[StartDateTime] [datetime2](0) NOT NULL,
	[EndDateTime] [datetime2](7) NOT NULL,
	[PublicationMode] [int] NOT NULL,
	[CroppedDescription]  AS (left([Description],(200))),
	[CustomerEventSetupId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[EventStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventParticipation]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventParticipation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_EventParticipation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventParticipationCriteria]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventParticipationCriteria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EventId] [int] NOT NULL,
	[Criteria] [varchar](max) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_EventParticipationCriteria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventParticipationStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventParticipationStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_EventParticipationStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventSetup]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventSetup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AlertsEmail] [varchar](100) NOT NULL,
	[AlertsFrequencyType] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CustomerEventSetup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventStatus](
	[id] [int] NOT NULL,
	[SystemName] [nchar](100) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[LastModifiedDateTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerEventStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](255) NOT NULL,
	[Title] [varchar](255) NULL,
 CONSTRAINT [PK_CustomerEventType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerEventTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerEventTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CustomerEventTypeId] [int] NOT NULL,
	[Title] [varchar](30) NULL,
 CONSTRAINT [PK_CustomerEventTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerFunctionality]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFunctionality](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[BillNumber] [int] NULL,
	[ActiveOnDateTime] [datetime2](0) NULL,
	[CustomerId] [int] NULL,
	[CustomerSubscriptionId] [int] NULL,
	[FunctionalityId] [int] NULL,
	[OrderReferenceRF] [varchar](max) NULL,
	[OrderStatusId] [int] NOT NULL,
	[OrderLineStatusId] [int] NOT NULL,
	[OrderPaymentModeId] [int] NULL,
	[PriceUnit] [decimal](8, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[VATRate] [decimal](4, 2) NOT NULL,
	[BillingCountryId] [int] NULL,
	[BillingCityId] [int] NULL,
	[Discount] [decimal](8, 2) NOT NULL,
	[TotalToPay] [decimal](4, 2) NOT NULL,
	[CurrencyId] [int] NULL,
	[DueDate] [date] NULL,
	[PaidOnDateTime] [datetime2](0) NULL,
	[PaymentTypeId] [int] NOT NULL,
	[ValidUntilDateTime] [datetime2](0) NULL,
	[IsReverseCharge] [bit] NOT NULL,
	[VAT] [varchar](50) NULL,
	[IBAN] [varchar](max) NULL,
	[BIC] [varchar](max) NULL,
	[BillingAddressStreet] [varchar](500) NULL,
	[BillingAddressNumber] [varchar](10) NULL,
	[BillingAddressBox] [varchar](10) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[PromoCodeId] [int] NULL,
 CONSTRAINT [PK_CustomerFunctionality] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRole]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Title] [varchar](500) NULL,
	[CanBeChild] [bit] NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[RoleType] [int] NULL,
	[EntityStatus] [int] NULL,
	[IsIncludedInSearch] [bit] NULL,
	[SkipBookStep] [bit] NULL,
 CONSTRAINT [PK_CustomerRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRoleLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRoleLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[CustomerRoleId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
 CONSTRAINT [PK_CustomerRoleLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRoleType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRoleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CustomerRoleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerRoleTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRoleTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[CustomerRoleTypeId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CustomerRoleTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerService]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerService](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[PriceUnit] [decimal](8, 2) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
	[ManageComment] [nvarchar](max) NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_CustomerService] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerServiceStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerServiceStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](max) NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_CustomerServiceStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CustomerStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerStatusLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[CustomerStatusId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_CustomerStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerSubscription]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerSubscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[BillNumber] [int] NULL,
	[OrderReferenceRF] [varchar](max) NULL,
	[ActiveOnDateTime] [datetime2](0) NULL,
	[ValidUntilDateTime] [datetime2](0) NULL,
	[SubscriptionId] [int] NULL,
	[CurrencyId] [int] NULL,
	[PeriodicityId] [int] NOT NULL,
	[OrderLineStatusId] [int] NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[OrderPaymentModeId] [int] NULL,
	[PaymentTypeId] [int] NOT NULL,
	[PriceUnit] [decimal](8, 2) NOT NULL,
	[SetupFee] [decimal](8, 2) NOT NULL,
	[VAT] [varchar](50) NULL,
	[IBAN] [varchar](max) NULL,
	[BIC] [varchar](8) NULL,
	[BillingAddressStreet] [varchar](500) NULL,
	[BillingAddressNumber] [varchar](10) NULL,
	[BillingAddressBox] [varchar](10) NULL,
	[BillingCountryId] [int] NULL,
	[BillingCityId] [int] NULL,
	[VATRate] [decimal](4, 2) NOT NULL,
	[IsReverseCharge] [bit] NOT NULL,
	[Discount] [decimal](8, 2) NOT NULL,
	[TotalToPay] [decimal](8, 2) NOT NULL,
	[DueDate] [date] NULL,
	[PaidOnDateTime] [datetime2](0) NULL,
	[Quantity] [int] NOT NULL,
	[Credits]  AS ([dbo].[GetCreditsForSubscription]([SubscriptionId],[Quantity])),
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[PromoCodeId] [int] NULL,
 CONSTRAINT [PK_CustomerSubscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_DiscountType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[DiscountTypeId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_DiscountTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Domain]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Domain](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](255) NOT NULL,
	[Title] [varchar](255) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Domain] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DomainLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DomainLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](255) NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[LanguageCode] [char](2) NULL,
	[DomainId] [int] NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_DomainLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editor]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editor](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Setup] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EITPermissions]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EITPermissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntityStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_EntityStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntityStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityStatusLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[EntityStatusId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_EntityStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FriendlyURL]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FriendlyURL](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Action] [varchar](100) NOT NULL,
	[IsFavorite] [bit] NOT NULL,
	[Link] [varchar](100) NOT NULL,
	[Module] [varchar](100) NOT NULL,
	[ObjectId] [int] NOT NULL,
	[Type] [varchar](50) NULL,
	[CultureId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_FriendlyURL] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Functionality]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Functionality](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NULL,
	[CreditsCost] [int] NOT NULL,
	[EntityStatusId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](7) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Functionality] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FunctionalityLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunctionalityLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[FunctionalityId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_FunctionalityLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeoPC_Places]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeoPC_Places](
	[ISO] [nvarchar](2) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[Language] [nvarchar](2) NOT NULL,
	[ID] [bigint] NOT NULL,
	[Region1] [nvarchar](80) NULL,
	[Region2] [nvarchar](80) NULL,
	[Region3] [nvarchar](80) NULL,
	[Region4] [nvarchar](80) NULL,
	[Locality] [nvarchar](80) NULL,
	[Postcode] [nvarchar](15) NULL,
	[Suburb] [nvarchar](80) NULL,
	[Latitude] [decimal](10, 6) NULL,
	[Longitude] [decimal](10, 6) NULL,
	[Elevation] [int] NULL,
	[ISO2] [nvarchar](10) NULL,
	[FIPS] [nvarchar](10) NULL,
	[NUTS] [nvarchar](12) NULL,
	[HASC] [nvarchar](12) NULL,
	[STAT] [nvarchar](20) NULL,
	[Timezone] [nvarchar](30) NULL,
	[UTC] [nvarchar](10) NULL,
	[DST] [nvarchar](10) NULL,
 CONSTRAINT [GeoPC_Places_pkey] PRIMARY KEY CLUSTERED 
(
	[Language] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalPromocode]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalPromocode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[DiscountTypeId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[CustomerRoleTypeId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[ValidFrom] [date] NULL,
	[ValidUntil] [date] NULL,
 CONSTRAINT [PK_GlobalPromocode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IpToCountry]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IpToCountry](
	[CodeFrom] [bigint] NOT NULL,
	[CodeTo] [bigint] NOT NULL,
	[CountryCode] [char](2) NOT NULL,
 CONSTRAINT [PK_IpToCountry] PRIMARY KEY CLUSTERED 
(
	[CodeFrom] ASC,
	[CodeTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Code] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LegalStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LegalStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](255) NULL,
	[Label] [varchar](255) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_LegalStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LegalStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LegalStatusLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](255) NULL,
	[IsActiveInCulture] [bit] NOT NULL,
	[LanguageCode] [char](2) NULL,
	[LegalStatusId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_LegalStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogEntry]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogEntry](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateAndTime] [datetime2](0) NOT NULL,
	[Category] [varchar](20) NOT NULL,
	[Message] [varchar](1000) NOT NULL,
	[RawUrl] [varchar](1000) NOT NULL,
	[Details] [varchar](max) NOT NULL,
 CONSTRAINT [PK_LogEntry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogItem]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateAndTime] [datetime2](0) NOT NULL,
	[ActivityType] [varchar](50) NOT NULL,
	[AuthorId] [varchar](50) NOT NULL,
	[SourceObjectId] [int] NULL,
	[RelatedObjectId] [int] NULL,
	[SourceObjectType] [varchar](100) NULL,
	[RelatedObjectType] [varchar](100) NULL,
 CONSTRAINT [PK_LogItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaType](
	[Id] [int] NOT NULL,
	[SystemName] [varchar](100) NULL,
	[CreatedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_MediaType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MediaTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaTypeLocal](
	[Id] [int] NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[MediaTypeId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_MediaTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[NotificationType] [varchar](100) NULL,
	[TargetId] [int] NOT NULL,
	[TargetType] [varchar](50) NOT NULL,
	[ValidityStartDate] [datetime] NULL,
	[ValidityEndDate] [datetime] NULL,
	[Text] [varchar](max) NULL,
	[Status] [int] NOT NULL,
	[LogItemId] [int] NULL,
	[Title] [varchar](100) NULL,
	[NotificationTypes] [int] NOT NULL,
	[Attachments] [varchar](max) NULL,
	[CroppedTitle]  AS (left([Title],(30))),
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderLineStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderLineStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderLineStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineStatusLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[OrderLineStatusId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderLineStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPaymentMode]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPaymentMode](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderPaymentMode] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPaymentModeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPaymentModeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[OrderPaymentModeId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderPaymentModeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatusLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_OrderStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organization]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organization](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](100) NULL,
	[WebSite] [varchar](255) NULL,
	[Number] [int] NULL,
	[ContactFirstName] [varchar](50) NULL,
	[ContactLastName] [varchar](50) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK__Organiza__3214EC076DA02A3C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Page]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](max) NOT NULL,
	[Title] [varchar](500) NULL,
	[MainContent] [varchar](max) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DeletedDateTime] [datetime] NULL,
	[LastModifiedDateTime] [datetime] NULL,
	[IsProtected] [bit] NULL,
	[SystemName] [varchar](255) NULL,
	[PageAdditionalMeta] [varchar](max) NULL,
	[PageDescription] [varchar](355) NULL,
	[PageTitle] [varchar](160) NULL,
	[PageURL] [varchar](255) NULL,
	[PageOGDescription] [varchar](355) NULL,
	[PageOGImage] [varchar](355) NULL,
	[PageOGTitle] [varchar](355) NULL,
 CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PageLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PageId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[Title] [varchar](255) NULL,
	[MainContent] [varchar](max) NULL,
	[IsActive] [bit] NULL,
	[PageURL] [varchar](255) NULL,
	[PageTitle] [varchar](160) NULL,
	[PageDescription] [varchar](355) NULL,
	[PageAdditionalMeta] [varchar](max) NULL,
	[PageOGDescription] [varchar](355) NULL,
	[PageOGImage] [varchar](355) NULL,
	[PageOGTitle] [varchar](355) NULL,
 CONSTRAINT [PK_PageLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_PaymentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[PaymentTypeId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_PaymentTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Periodicity]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Periodicity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Periodicity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeriodicityLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeriodicityLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[PeriodicityId] [int] NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_PeriodicityLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Portfolios]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Portfolios](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CustomerId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[OrderId] [int] NULL,
	[ManageComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_Portfolios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PortfoliosItems]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PortfoliosItems](
	[Id] [int] NOT NULL,
	[PortfoliosId] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MediaTypeId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
	[MediaValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PortfoliosItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PortfoliosStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PortfoliosStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](max) NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_PortfoliosStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileItem]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Structure] [varchar](max) NULL,
	[ProfileSectionId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileItemLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileItemLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[LanguageCode] [char](10) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileItemLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileSection]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileSection](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[IsGlobal] [bit] NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileSection] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfileSectionLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfileSectionLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProfileSectionId] [int] NOT NULL,
	[LanguageCode] [char](10) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileSectionLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publication]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publication](
	[Id] [int] NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NULL,
	[CustomerId] [int] NOT NULL,
	[PublicationName] [nvarchar](255) NOT NULL,
	[MediaTypeId] [int] NOT NULL,
	[MediaValue] [nvarchar](255) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
	[PublicationDate] [datetime2](0) NOT NULL,
	[ManageComment] [varchar](max) NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_Publication] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicationStatus](
	[Id] [int] NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_PublicationStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PublicationStatusLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PublicationStatusLocal](
	[Id] [int] NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[PublicationStatusId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_PublicationStatusLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelCustomerCustomerRole]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelCustomerCustomerRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_RelCustomerCustomerRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelProfileItemProfileSection]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelProfileItemProfileSection](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Orders] [varchar](100) NOT NULL,
	[ProfileSection] [int] NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileItemProfileSectoin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelProfileSectionCustomerRole]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelProfileSectionCustomerRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Orders] [varchar](100) NOT NULL,
	[ProfilesSectionId] [int] NOT NULL,
	[CustomerRoleId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ProfileSectionCustomerRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RelSubscriptionProfileItem]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelSubscriptionProfileItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionId] [int] NOT NULL,
	[ProfileItemId] [int] NOT NULL,
	[Setup] [varchar](max) NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_RelSubscriptionProfileItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[SenderCustomerId] [int] NOT NULL,
	[RecipientCustomerId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModifiedDateTime] [datetime2](7) NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[ReviewStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewStatus]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](7) NOT NULL,
	[LastModdifiedDateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_ReviewStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceType]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](100) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ServiceType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceTypeLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTypeLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](30) NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_ServiceTypeLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](255) NOT NULL,
	[Title] [varchar](255) NULL,
	[CountryId] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SystemName] [varchar](100) NOT NULL,
	[Description] [varchar](max) NULL,
	[Price] [decimal](8, 2) NOT NULL,
	[EntityStatusId] [int] NULL,
	[PeriodicityId] [int] NULL,
	[PricePerPeriod] [decimal](8, 2) NOT NULL,
	[CreditPerPeriod] [int] NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[DeletedDateTime] [datetime2](0) NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Translation] [varchar](100) NOT NULL,
	[SubscriptionId] [int] NOT NULL,
	[LanguageCode] [char](2) NOT NULL,
	[CreatedDateTime] [datetime2](0) NOT NULL,
	[LastModifiedDateTime] [datetime2](0) NULL,
 CONSTRAINT [PK_SubscriptionLocal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCity]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCity](
	[EITCountryId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [varchar](60) NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[EITStateId] [int] NULL,
	[Geography] [geography] NULL,
	[GeoPostCodeId] [bigint] NOT NULL,
 CONSTRAINT [PK_150e9b44458a1c76b3d61b20bd9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCityLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCityLocal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EITCityId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Title] [nvarchar](500) NULL,
 CONSTRAINT [PK_3a8265444ababad7ae510fd8ec8] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCountryLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCountryLocal](
	[EITCountryId] [int] NOT NULL,
	[EITCultureId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NULL,
 CONSTRAINT [PK_f628b214e4bbffcdddda2a7eb8e] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCulture]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCulture](
	[Culture] [varchar](50) NULL,
	[Host] [varchar](30) NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[URLPrefix] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[IsDefault] [bit] NOT NULL,
	[EITCountryId] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_628b9d14878b5735a49882ae495] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCurrency]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCurrency](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](5) NOT NULL,
	[Symbol] [nvarchar](5) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[CodeSIPS] [int] NOT NULL,
 CONSTRAINT [PK_734cbc24e57916e3ca29e502f51] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITCurrencyLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITCurrencyLocal](
	[EITCultureId] [int] NOT NULL,
	[EITCurrencyId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NULL,
 CONSTRAINT [PK_fb6c2f8445b92fdddcedaed6706] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITLogItem]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITLogItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ActivityType] [varchar](50) NOT NULL,
	[AuthorId] [varchar](50) NOT NULL,
	[SourceObjectId] [int] NULL,
	[RelatedObjectId] [int] NULL,
	[SourceObjectType] [varchar](100) NULL,
	[RelatedObjectType] [varchar](100) NULL,
 CONSTRAINT [PK_5422b8f422db2b1adc6822c4391] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITNotification]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITNotification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[NotificationType] [nvarchar](100) NULL,
	[TargetId] [int] NOT NULL,
	[TargetType] [nvarchar](50) NOT NULL,
	[ValidityStartDate] [datetime] NULL,
	[ValidityEndDate] [datetime] NULL,
	[Text] [varchar](max) NULL,
	[Status] [int] NOT NULL,
	[EITLogItemId] [int] NULL,
	[Title] [varchar](100) NULL,
	[NotificationTypes] [int] NOT NULL,
	[Attachments] [nvarchar](max) NULL,
	[CroppedTitle]  AS (left([Title],(30))),
 CONSTRAINT [PK_b09a319485296e52494459c0db9] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITState]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITState](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Label] [nvarchar](255) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[EITCountryId] [int] NOT NULL,
 CONSTRAINT [PK_f65052541bda8c821f7c1eb5951] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [eit].[EITStateLocal]    Script Date: 31-05-21 15:25:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [eit].[EITStateLocal](
	[EITCultureId] [int] NOT NULL,
	[EITStateId] [int] NOT NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_d11155e47a98a23ad33a92c95e0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'1', N'nathPo@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'NathPo', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'10', N'cohenp@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'CohenP', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'11', N'enrycov@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Enrycov', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'2', N'pedro_dasilva@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'PeDas', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'3', N'jp@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Jp09', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'4', N'avrilLavigne@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'AvVigne', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'5', N'alicezune@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'AlZ', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'6', N'jeanpaul@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Jp01', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'7', N'jeanmarc@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Jm01', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'8', N'lauradetournay@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'lauraDetour', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [Discriminator], [EITCultureId], [Token]) VALUES (N'9', N'henrytr@yopmail.com', 1, NULL, NULL, NULL, 0, 0, NULL, 0, 0, N'Henrytr', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Block] ON 

INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (7, N'TestAPI', N'<p>blablabla en Fran&ccedil;ais</p>
', N'TestAPI', CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (8, N'Test2', N'<p>Bonjour ceci est un test</p>
', N'Test2', CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (9, N'Test3', N'<p>Bonjour test3</p>
', N'Test3', CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (10, N'Test4', N'<p>Bonjour test 4</p>
', N'Test4', CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (11, N'Test5', N'<p>ksdjdkljsdkldjslk</p>
', N'Test5', CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (13, N'BlockLocal in Englsih', N'<p>BlockLocal in English</p>
', N'Test Creation block', CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (14, N'dddds', N'<p>dsdddsdsd</p>
', N'Ajout Block', CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2), NULL, CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2))
INSERT [dbo].[Block] ([Id], [Label], [Body], [SystemName], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (18, N'CréationTest', N'<p>Cr&eacute;ationTest</p>
', N'CréationTest', CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2), NULL, CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Block] OFF
GO
SET IDENTITY_INSERT [dbo].[BlockLocal] ON 

INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'<p>blablabla in English</p>
', 7, N'en', CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2), CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'<p>blablabla en Fran&ccedil;ais</p>
', 7, N'fr', CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2), CAST(N'2021-05-01T09:30:06.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'<p>Bonjour ceci est un test</p>
', 8, N'en', CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2), CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (6, N'<p>Bonjour ceci est un test</p>
', 8, N'fr', CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2), CAST(N'2021-05-01T16:56:44.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (7, N'<p>Bonjour test3</p>
', 9, N'en', CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2), CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (8, N'<p>Bonjour test3</p>
', 9, N'fr', CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2), CAST(N'2021-05-01T16:57:47.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (9, N'<p>Bonjour test 4</p>
', 10, N'en', CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2), CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (10, N'<p>Bonjour test 4</p>
', 10, N'fr', CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2), CAST(N'2021-05-01T16:58:56.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (11, N'<p>ksdjdkljsdkldjslk</p>
', 11, N'en', CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2), CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (12, N'<p>ksdjdkljsdkldjslk</p>
', 11, N'fr', CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2), CAST(N'2021-05-01T16:59:40.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (15, N'<p>BlockLocal in English</p>
', 13, N'en', CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2), CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (16, N'<p>BlockLocal in English</p>
', 13, N'fr', CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2), CAST(N'2021-05-01T17:56:47.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (17, N'<p>dsdddsdsd</p>
', 14, N'fr', CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2), CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (18, N'', 14, N'en', CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2), CAST(N'2021-05-01T18:00:15.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (25, N'<p>Cr&eacute;ationTest</p>
', 18, N'fr', CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2), CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2))
INSERT [dbo].[BlockLocal] ([Id], [Body], [BlockId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime]) VALUES (26, N'<p>Cr&eacute;ationTest</p>
', 18, N'en', CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2), CAST(N'2021-05-19T22:32:40.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[BlockLocal] OFF
GO
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([Id], [Label], [Title], [Zip], [Geography], [CreatedDateTime], [LastModifiedDateTime], [GeoPostCodeId], [StateId], [CountryId]) VALUES (1, N'Uccle', N'Uccle', N'1180', 0xE6100000010CCAC0012D5D7D45400FB4024356AF3940, CAST(N'2021-05-23T20:42:01.0000000' AS DateTime2), CAST(N'2021-05-23T20:42:01.0000000' AS DateTime2), 10003512, 3, 2)
INSERT [dbo].[City] ([Id], [Label], [Title], [Zip], [Geography], [CreatedDateTime], [LastModifiedDateTime], [GeoPostCodeId], [StateId], [CountryId]) VALUES (2, N'Schaerbeek', N'Schaerbeek', N'1030', NULL, CAST(N'2021-05-23T20:48:57.0000000' AS DateTime2), CAST(N'2021-05-23T20:48:57.0000000' AS DateTime2), 10003512, 3, 2)
INSERT [dbo].[City] ([Id], [Label], [Title], [Zip], [Geography], [CreatedDateTime], [LastModifiedDateTime], [GeoPostCodeId], [StateId], [CountryId]) VALUES (3, N'Etterbeek', N'Etterbeek', N'1040', NULL, CAST(N'2021-05-23T20:48:57.0000000' AS DateTime2), CAST(N'2021-05-23T20:48:57.0000000' AS DateTime2), 10003512, 3, 2)
SET IDENTITY_INSERT [dbo].[City] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([Id], [Name], [Label], [Code], [CreatedDateTime], [LastModifiedDateTime], [CurrencyId]) VALUES (1, N'Italie', N'Italia', N'IT', CAST(N'2021-05-23T20:24:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:24:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Country] ([Id], [Name], [Label], [Code], [CreatedDateTime], [LastModifiedDateTime], [CurrencyId]) VALUES (2, N'Belgique', N'Belgium', N'BE', CAST(N'2021-05-23T20:24:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:24:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[CreditPack] ON 

INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (1, N'Credits only Ristretto', N'<p>Pack 99 Credits for 33 euros</p>', CAST(33.00 AS Decimal(8, 2)), 99, 1, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2))
INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (2, N'Free', N'for free user profil', CAST(0.00 AS Decimal(8, 2)), 0, 2, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2))
INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (3, N'Credits only Espresso', N'<p>275 Crédits pour 55 euros</p>', CAST(55.00 AS Decimal(8, 2)), 275, 1, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2))
INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (4, N'Credits only Lungo', N'<p>Pack 347 Credits for 99 euros;</p>', CAST(99.00 AS Decimal(8, 2)), 347, 1, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:20:58.0000000' AS DateTime2))
INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (7, N'Crédits only Lungo', N'<p>Pack 540 Crédits pour 90 euros</p>', CAST(90.00 AS Decimal(8, 2)), 540, 1, CAST(N'2021-05-20T20:22:20.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:22:20.0000000' AS DateTime2))
INSERT [dbo].[CreditPack] ([Id], [SystemName], [Description], [Price], [Credits], [EntityStatusId], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (8, N'Crédits only Espresso', N'<p>Pack 215 Credits for 66 euros;</p>', CAST(66.00 AS Decimal(8, 2)), 215, 1, CAST(N'2021-05-20T20:22:20.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:22:20.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[CreditPack] OFF
GO
SET IDENTITY_INSERT [dbo].[Currency] ON 

INSERT [dbo].[Currency] ([Id], [SystemName], [Code], [Symbol], [CodeSIPS], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'Euro', N'EUR', N'€', 978, CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2), CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2))
INSERT [dbo].[Currency] ([Id], [SystemName], [Code], [Symbol], [CodeSIPS], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'Sterling Pound', N'GBP', N'£', 826, CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2), CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2))
INSERT [dbo].[Currency] ([Id], [SystemName], [Code], [Symbol], [CodeSIPS], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'Dollar Americain', N'USD', N'$', 840, CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2), CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2))
INSERT [dbo].[Currency] ([Id], [SystemName], [Code], [Symbol], [CodeSIPS], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'Franc Suisse', N'CHF', N'F', 756, CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2), CAST(N'2021-05-23T20:20:08.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Currency] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (1, NULL, NULL, N'phil', N'good', CAST(N'1980-12-25' AS Date), NULL, N'352698-984-61', N'0475959746', 0, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, 4, CAST(N'2021-05-20T22:20:34.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:20:34.0000000' AS DateTime2), 5, CAST(N'2021-05-20T22:20:34.0000000' AS DateTime2), NULL, 2458, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (2, N'1', NULL, N'nathalie', N'pomme', CAST(N'1990-12-25' AS Date), NULL, N'352698-984-61', N'0476979786', 0, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, 5, CAST(N'2021-05-20T22:37:38.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:37:38.0000000' AS DateTime2), 5, CAST(N'2021-05-20T22:37:38.0000000' AS DateTime2), NULL, 58, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (3, N'2', NULL, N'Pedro', N'Da Silva', CAST(N'1990-12-25' AS Date), NULL, N'975368-984-61', N'0476247986', 0, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 3, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 58, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (4, N'3', NULL, N'Jean Pierre', N'Zune', CAST(N'1990-12-12' AS Date), NULL, N'745963-984-61', N'0477946286', 0, NULL, NULL, NULL, 2, NULL, 1, NULL, NULL, NULL, 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 2, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 548, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (5, N'4', NULL, N'Avril', N'Lavigne', CAST(N'1991-01-13' AS Date), NULL, N'124894-984-61', N'0425649786', 0, NULL, NULL, NULL, 3, NULL, 1, NULL, NULL, NULL, 4, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 4, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 417, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (6, N'5', NULL, N'Alice Sophie', N'Zune', CAST(N'1999-09-26' AS Date), NULL, N'756975-984-61', N'0472439786', 0, NULL, NULL, NULL, 4, NULL, 1, NULL, NULL, NULL, 3, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 0, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 78, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (7, N'6', NULL, N'Jean Paul', N'Gauthier', CAST(N'2001-12-25' AS Date), NULL, N'214786-984-61', N'0476979341', 0, NULL, NULL, NULL, 5, NULL, 1, NULL, NULL, NULL, 2, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 76, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (8, N'7', NULL, N'Jean Marc', N'Bidou', CAST(N'1983-05-25' AS Date), NULL, N'137678-984-61', N'0358979786', 0, NULL, NULL, NULL, 6, NULL, 1, NULL, NULL, NULL, 7, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 2, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 214, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (9, N'8', NULL, N'Laua', N'Detournay', CAST(N'1992-05-18' AS Date), NULL, N'972643-984-61', N'0425439786', 0, NULL, NULL, NULL, 7, NULL, 1, NULL, NULL, NULL, 6, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 786, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (10, N'9', NULL, N'Henry', N'Tran', CAST(N'1985-12-31' AS Date), NULL, N'671958-984-61', N'0471973786', 0, NULL, NULL, NULL, 8, NULL, 1, NULL, NULL, NULL, 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 1, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 14, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (11, N'10', NULL, N'Pierre', N'Cohen', CAST(N'1973-07-15' AS Date), NULL, N'975813-984-61', N'0681979786', 0, NULL, NULL, NULL, 9, NULL, 1, NULL, NULL, NULL, 5, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 4, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 7965, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
INSERT [dbo].[Customer] ([Id], [UserId], [ProfessionnalName], [Firstname], [Lastname], [Birthdate], [Avatar], [NationalRegistrationNumber], [Phone], [IsChild], [ParentFirstName], [ParentLastName], [OrganizationId], [MainRoleId], [CustomerSubscriptionId], [IsBillingAddressSameAsAddress], [VAT], [IBAN], [BIC], [CustomerStatus], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [Rating], [LastProfileModification], [CustomerEventSetupId], [ProfileViews], [CoverFile], [AddressStreet], [AddressNumber], [AddressBox], [BillingAddressStreet], [BillingAddressNumber], [BillingAddressBox]) VALUES (12, N'11', NULL, N'Menthe', N'Enrycov', CAST(N'2004-12-25' AS Date), NULL, N'497628-984-61', N'0476979468', 0, NULL, NULL, NULL, 10, NULL, 1, NULL, NULL, NULL, 3, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), 2, CAST(N'2021-05-21T07:53:16.0000000' AS DateTime2), NULL, 457, NULL, N'Rue Jean Volders', N'224', NULL, N'Rue Jean Volders', N'224', NULL)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerEvent] ON 

INSERT [dbo].[CustomerEvent] ([Id], [SystemName], [Description], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [CustomerId], [MediaType], [MediaValue], [Status], [OrderLineId], [StartDateTime], [EndDateTime], [PublicationMode], [CustomerEventSetupId], [CountryId], [CityId], [EventStatusId]) VALUES (1, N'TestEvent', N'Ceci est un test de création de casting', CAST(N'2021-05-23T20:49:25.0000000' AS DateTime2), NULL, CAST(N'2021-05-24T10:35:13.0000000' AS DateTime2), 2, 1, NULL, NULL, NULL, CAST(N'2021-05-23T20:49:25.0000000' AS DateTime2), CAST(N'2021-05-23T20:49:24.6530000' AS DateTime2), 1, 1, 2, 1, 3)
SET IDENTITY_INSERT [dbo].[CustomerEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerEventSetup] ON 

INSERT [dbo].[CustomerEventSetup] ([Id], [AlertsEmail], [AlertsFrequencyType], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'pedro@yopmail.com', 2, CAST(N'2021-05-23T20:03:21.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[CustomerEventSetup] OFF
GO
INSERT [dbo].[CustomerEventStatus] ([id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'CREATED                                                                                             ', CAST(N'2021-05-24T09:02:11.950' AS DateTime), NULL)
INSERT [dbo].[CustomerEventStatus] ([id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'WAITING_VALIDATION                                                                                  ', CAST(N'2021-05-24T09:04:02.063' AS DateTime), NULL)
INSERT [dbo].[CustomerEventStatus] ([id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'VALIDATED                                                                                           ', CAST(N'2021-05-24T09:04:02.063' AS DateTime), NULL)
INSERT [dbo].[CustomerEventStatus] ([id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'ARCHIVED                                                                                            ', CAST(N'2021-05-24T09:04:02.063' AS DateTime), NULL)
INSERT [dbo].[CustomerEventStatus] ([id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'REJECTED                                                                                            ', CAST(N'2021-05-24T10:30:38.077' AS DateTime), CAST(N'2021-05-24T10:30:38.077' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[CustomerRole] ON 

INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (1, N'Model', N'Mannequin', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 0, 0, 1, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (2, N'Photographer', N'Photographe', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 1, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (3, N'Casting Director', N'Directeur de casting', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 0, 1)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (4, N'Makeup Artist', N'Maquilleur/Maquilleuse', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 1, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (5, N'Fashion Stylist', N'Fashion Stylist', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 1, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (6, N'Hairdresser', N'Coiffeur/Coiffeuse', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 1, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (7, N'Casting Assistant', N'Assistant(e) Casting', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 0, 1)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (8, N'Agent', N'Agent', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 0, 0)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (9, N'Art Director', N'Directeur artistique', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 0, 0, 1, 1)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (10, N'Executtive Producer', N'Directeur de Production', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 1, 0, 0, 1)
INSERT [dbo].[CustomerRole] ([Id], [SystemName], [Title], [CanBeChild], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [RoleType], [EntityStatus], [IsIncludedInSearch], [SkipBookStep]) VALUES (11, N'Actor', N'Commédien(ne)', 0, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T22:04:13.0000000' AS DateTime2), 0, 0, 1, 0)
SET IDENTITY_INSERT [dbo].[CustomerRole] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerRoleType] ON 

INSERT [dbo].[CustomerRoleType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'Talent', CAST(N'2021-05-20T21:52:44.0000000' AS DateTime2), CAST(N'2021-05-20T21:52:44.0000000' AS DateTime2))
INSERT [dbo].[CustomerRoleType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'Pro', CAST(N'2021-05-20T21:52:44.0000000' AS DateTime2), CAST(N'2021-05-20T21:52:44.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[CustomerRoleType] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerService] ON 

INSERT [dbo].[CustomerService] ([Id], [CustomerId], [ServiceTypeId], [CityId], [Title], [Description], [PriceUnit], [StartDate], [EndDate], [CreatedDateTime], [LastModifiedDateTime], [ManageComment], [StatusId]) VALUES (1, 2, 1, 1, N'Book pour mannequin chaussette', NULL, CAST(35.00 AS Decimal(8, 2)), CAST(N'2021-05-26T11:11:37.6200000' AS DateTime2), NULL, CAST(N'2021-05-26T11:11:37.6200000' AS DateTime2), NULL, NULL, 1)
INSERT [dbo].[CustomerService] ([Id], [CustomerId], [ServiceTypeId], [CityId], [Title], [Description], [PriceUnit], [StartDate], [EndDate], [CreatedDateTime], [LastModifiedDateTime], [ManageComment], [StatusId]) VALUES (2, 2, 5, 1, N'Cours de comédie pour Acteur débutant', NULL, CAST(75.00 AS Decimal(8, 2)), CAST(N'2021-05-26T11:11:37.6200000' AS DateTime2), NULL, CAST(N'2021-05-26T11:11:37.6200000' AS DateTime2), CAST(N'2021-05-26T20:38:39.3837942' AS DateTime2), NULL, 2)
SET IDENTITY_INSERT [dbo].[CustomerService] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerServiceStatus] ON 

INSERT [dbo].[CustomerServiceStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'WAITING_VALIDATION', CAST(N'2021-05-26T12:37:26.4500000' AS DateTime2), NULL)
INSERT [dbo].[CustomerServiceStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'VALIDATED', CAST(N'2021-05-26T12:37:26.4500000' AS DateTime2), NULL)
INSERT [dbo].[CustomerServiceStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'REJECTED', CAST(N'2021-05-26T12:37:26.4500000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[CustomerServiceStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerStatus] ON 

INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'CREATED', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'ACTIVATED', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'WAITING_VALIDATION', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'NEED_REVIEW_PROFILE', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'VALIDATED', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (6, N'ARCHIVED', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (7, N'BLACKLISTED', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
INSERT [dbo].[CustomerStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (8, N'NEED_ACCESS_PRODUCT', CAST(N'2021-05-18T15:00:14.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[CustomerStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[EntityStatus] ON 

INSERT [dbo].[EntityStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'Published', CAST(N'2021-05-18T14:42:49.0000000' AS DateTime2), NULL)
INSERT [dbo].[EntityStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'Unpublished', CAST(N'2021-05-18T14:42:49.0000000' AS DateTime2), NULL)
INSERT [dbo].[EntityStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'PUBLISHED', CAST(N'2021-05-20T19:54:15.0000000' AS DateTime2), CAST(N'2021-05-20T19:54:15.0000000' AS DateTime2))
INSERT [dbo].[EntityStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'UNPUBLISHED', CAST(N'2021-05-20T19:54:15.0000000' AS DateTime2), CAST(N'2021-05-20T19:54:15.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[EntityStatus] OFF
GO
INSERT [dbo].[GeoPC_Places] ([ISO], [Country], [Language], [ID], [Region1], [Region2], [Region3], [Region4], [Locality], [Postcode], [Suburb], [Latitude], [Longitude], [Elevation], [ISO2], [FIPS], [NUTS], [HASC], [STAT], [Timezone], [UTC], [DST]) VALUES (N'FR', N'2', N'fr', 10003512, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Language] ([Code], [CreatedDateTime], [LastModifiedDateTime]) VALUES (N'en', CAST(N'2020-10-14T14:16:30.0000000' AS DateTime2), CAST(N'2020-10-14T14:16:30.0000000' AS DateTime2))
INSERT [dbo].[Language] ([Code], [CreatedDateTime], [LastModifiedDateTime]) VALUES (N'fr', CAST(N'2020-10-14T14:16:49.0000000' AS DateTime2), CAST(N'2020-10-14T14:16:49.0000000' AS DateTime2))
GO
INSERT [dbo].[MediaType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'VIDEO', CAST(N'2021-05-22T22:50:49.0000000' AS DateTime2), CAST(N'2021-05-22T22:50:49.0000000' AS DateTime2))
INSERT [dbo].[MediaType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'IMAGE', CAST(N'2021-05-22T22:50:49.0000000' AS DateTime2), CAST(N'2021-05-22T22:50:49.0000000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'CREATED', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'PENDING', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'COMPLETED', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'CANCELED', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'PAYMENT_INCOMPLETE', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[OrderStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (6, N'PAYEMENT_ERROR', CAST(N'2021-05-18T14:47:16.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Page] ON 

INSERT [dbo].[Page] ([Id], [Label], [Title], [MainContent], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [IsProtected], [SystemName], [PageAdditionalMeta], [PageDescription], [PageTitle], [PageURL], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (1, N'TestPage_1', NULL, N'Ceci est un ajout de test', CAST(N'2021-05-19T08:44:24.827' AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Page] ([Id], [Label], [Title], [MainContent], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [IsProtected], [SystemName], [PageAdditionalMeta], [PageDescription], [PageTitle], [PageURL], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (3, N'TestPage_3', NULL, N'Ceci est un ajout de test', CAST(N'2021-05-19T08:45:09.043' AS DateTime), NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Page] ([Id], [Label], [Title], [MainContent], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [IsProtected], [SystemName], [PageAdditionalMeta], [PageDescription], [PageTitle], [PageURL], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (4, N'TestModification FR', N'TestModification FR', N'<p>texte de TestModification FR</p>
', CAST(N'2021-05-19T23:24:04.883' AS DateTime), NULL, CAST(N'2021-05-19T23:24:04.883' AS DateTime), 0, N'TestModification FR', N'TestModification', N'TestModification', N'TestModification FR', N'https//TestModificationFR.be', NULL, NULL, NULL)
INSERT [dbo].[Page] ([Id], [Label], [Title], [MainContent], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime], [IsProtected], [SystemName], [PageAdditionalMeta], [PageDescription], [PageTitle], [PageURL], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (5, N'TestCreateFrench', N'TestCreateFrench', N'<p>TestCreateFrench</p>
', CAST(N'2021-05-20T17:24:14.653' AS DateTime), NULL, CAST(N'2021-05-20T17:24:14.653' AS DateTime), 0, N'TestCreateFrench', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Page] OFF
GO
SET IDENTITY_INSERT [dbo].[PageLocal] ON 

INSERT [dbo].[PageLocal] ([Id], [PageId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime], [Title], [MainContent], [IsActive], [PageURL], [PageTitle], [PageDescription], [PageAdditionalMeta], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (1, 4, N'fr', CAST(N'2021-05-19T23:24:05.0000000' AS DateTime2), CAST(N'2021-05-19T23:24:05.0000000' AS DateTime2), NULL, N'<p>texte de TestModification FR</p>
', 0, N'https//TestModificationFR.be', N'TestModification FR', N'TestModification', N'TestModification', NULL, NULL, N'TestModification FR')
INSERT [dbo].[PageLocal] ([Id], [PageId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime], [Title], [MainContent], [IsActive], [PageURL], [PageTitle], [PageDescription], [PageAdditionalMeta], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (2, 4, N'en', CAST(N'2021-05-19T23:24:05.0000000' AS DateTime2), CAST(N'2021-05-19T23:24:05.0000000' AS DateTime2), NULL, N'<p>MOdification d&#39;une page local en d&quot;j&agrave; existante</p>
', 0, N'ModifEN.us', N'TestModification EN', N'ModifEN', N'ModifEN', NULL, NULL, N'ModifEN')
INSERT [dbo].[PageLocal] ([Id], [PageId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime], [Title], [MainContent], [IsActive], [PageURL], [PageTitle], [PageDescription], [PageAdditionalMeta], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (3, 5, N'fr', CAST(N'2021-05-20T17:24:15.0000000' AS DateTime2), CAST(N'2021-05-20T17:24:15.0000000' AS DateTime2), NULL, N'<p>TestCreateFrench</p>
', 0, NULL, N'TestCreateFrench', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PageLocal] ([Id], [PageId], [LanguageCode], [CreatedDateTime], [LastModifiedDateTime], [Title], [MainContent], [IsActive], [PageURL], [PageTitle], [PageDescription], [PageAdditionalMeta], [PageOGDescription], [PageOGImage], [PageOGTitle]) VALUES (4, 5, N'en', CAST(N'2021-05-20T17:24:15.0000000' AS DateTime2), CAST(N'2021-05-20T17:24:15.0000000' AS DateTime2), NULL, N'<p>TestCreateEnglish</p>
', 0, N'en.TestCreateEnglish.com', N'CreateEnglish', N'TestCreateEnglish', N'TestCreateEnglish', NULL, NULL, N'TestCreateEnglish')
SET IDENTITY_INSERT [dbo].[PageLocal] OFF
GO
SET IDENTITY_INSERT [dbo].[Periodicity] ON 

INSERT [dbo].[Periodicity] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'WEEKLY', CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2), CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2))
INSERT [dbo].[Periodicity] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'MONTHLY', CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2), CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2))
INSERT [dbo].[Periodicity] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'YEARLY', CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2), CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2))
INSERT [dbo].[Periodicity] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'UNLIMITED', CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2), CAST(N'2021-05-20T19:56:36.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Periodicity] OFF
GO
SET IDENTITY_INSERT [dbo].[Portfolios] ON 

INSERT [dbo].[Portfolios] ([Id], [Title], [Description], [CustomerId], [StatusId], [OrderId], [ManageComment]) VALUES (1, N'Portfolios Mannequin', N'BlmabLa', 4, 2, NULL, NULL)
INSERT [dbo].[Portfolios] ([Id], [Title], [Description], [CustomerId], [StatusId], [OrderId], [ManageComment]) VALUES (2, N'Portfolios Acteur', N'BlaBla', 10, 2, NULL, N'ChangerPhotos 5')
SET IDENTITY_INSERT [dbo].[Portfolios] OFF
GO
INSERT [dbo].[PortfoliosItems] ([Id], [PortfoliosId], [Description], [MediaTypeId], [CreatedDateTime], [LastModifiedDateTime], [MediaValue]) VALUES (1, 1, N'Photo de mon chat', 1, CAST(N'2021-05-25T21:20:28.4300000' AS DateTime2), CAST(N'2021-05-25T21:20:28.4300000' AS DateTime2), N'monchats.jpg')
INSERT [dbo].[PortfoliosItems] ([Id], [PortfoliosId], [Description], [MediaTypeId], [CreatedDateTime], [LastModifiedDateTime], [MediaValue]) VALUES (2, 1, N'Photo de mon chien', 1, CAST(N'2021-05-25T21:21:41.4900000' AS DateTime2), NULL, N'monChien.jpg')
INSERT [dbo].[PortfoliosItems] ([Id], [PortfoliosId], [Description], [MediaTypeId], [CreatedDateTime], [LastModifiedDateTime], [MediaValue]) VALUES (3, 1, N'Video de mon chien', 2, CAST(N'2021-05-25T21:21:41.4930000' AS DateTime2), NULL, N'monChien.mkv')
INSERT [dbo].[PortfoliosItems] ([Id], [PortfoliosId], [Description], [MediaTypeId], [CreatedDateTime], [LastModifiedDateTime], [MediaValue]) VALUES (4, 2, N'Vidéo de mon essaie pour le rôle de jack', 2, CAST(N'2021-05-25T21:24:14.1870000' AS DateTime2), NULL, N'essaie1.mkv')
INSERT [dbo].[PortfoliosItems] ([Id], [PortfoliosId], [Description], [MediaTypeId], [CreatedDateTime], [LastModifiedDateTime], [MediaValue]) VALUES (5, 2, N'Video de mon essaie 2', 2, CAST(N'2021-05-25T21:24:14.1870000' AS DateTime2), NULL, N'essaie2.mkv')
GO
SET IDENTITY_INSERT [dbo].[PortfoliosStatus] ON 

INSERT [dbo].[PortfoliosStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'WAITING_VALIDATION', CAST(N'2021-05-25T19:40:20.9470000' AS DateTime2), NULL)
INSERT [dbo].[PortfoliosStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'VALIDATED', CAST(N'2021-05-25T19:40:20.9470000' AS DateTime2), NULL)
INSERT [dbo].[PortfoliosStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'REJECTED', CAST(N'2021-05-25T19:40:20.9470000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[PortfoliosStatus] OFF
GO
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (1, N'Test Publication', N'Ceci est un test de création de publication', 2, N'Test', 2, N'Image', CAST(N'2021-05-24T12:05:44.0000000' AS DateTime2), CAST(N'2021-05-24T12:05:44.0000000' AS DateTime2), CAST(N'2021-05-24T12:05:44.0000000' AS DateTime2), N'Blabla', 3)
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (2, N'BlcaBla', N'BlaBlabLa', 3, N'TestBlabla', 1, N'Vidéo', CAST(N'2021-05-24T12:07:02.0000000' AS DateTime2), CAST(N'2021-05-24T12:07:02.0000000' AS DateTime2), CAST(N'2021-05-24T12:07:02.0000000' AS DateTime2), N'Blabla', 2)
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (3, N'TexteTexte', N'TexteTexteBlaBlabLaTexteTexte', 2, N'TexteTexteBlabla', 1, N'Vidéo', CAST(N'2021-05-24T12:08:06.0000000' AS DateTime2), CAST(N'2021-05-24T12:08:06.0000000' AS DateTime2), CAST(N'2021-05-24T12:08:06.0000000' AS DateTime2), N'TexteBlabla', 3)
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (4, N'publicationImage', N'insertion publicationImage', 2, N'Publication truc', 2, N'IMAGE', CAST(N'2021-05-24T12:09:12.0000000' AS DateTime2), CAST(N'2021-05-24T12:09:12.0000000' AS DateTime2), CAST(N'2021-05-24T12:09:12.0000000' AS DateTime2), N'TexteBlabla', 2)
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (5, N'publicationVideo', N'insertion publicationVideo', 5, N'Publication truc', 1, N'VIDEO', CAST(N'2021-05-24T12:10:23.0000000' AS DateTime2), CAST(N'2021-05-24T12:10:23.0000000' AS DateTime2), CAST(N'2021-05-24T12:10:23.0000000' AS DateTime2), N'TexteBlabla', 3)
INSERT [dbo].[Publication] ([Id], [SystemName], [Description], [CustomerId], [PublicationName], [MediaTypeId], [MediaValue], [CreatedDateTime], [LastModifiedDateTime], [PublicationDate], [ManageComment], [StatusId]) VALUES (6, N'publicationVideo', N'insertion publicationVideo', 1, N'Publication truc', 1, N'VIDEO', CAST(N'2021-05-24T12:10:46.0000000' AS DateTime2), CAST(N'2021-05-24T12:10:46.0000000' AS DateTime2), CAST(N'2021-05-24T12:10:46.0000000' AS DateTime2), N'TexteBlabla', 2)
GO
INSERT [dbo].[PublicationStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'CREATED', CAST(N'2021-05-18T14:37:46.4800000' AS DateTime2), NULL)
INSERT [dbo].[PublicationStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'WAITING_VALIDATION', CAST(N'2021-05-18T14:39:43.0830000' AS DateTime2), NULL)
INSERT [dbo].[PublicationStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'VALIDATED', CAST(N'2021-05-18T14:39:43.0830000' AS DateTime2), NULL)
INSERT [dbo].[PublicationStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'REJECTED', CAST(N'2021-05-18T14:39:43.0830000' AS DateTime2), NULL)
INSERT [dbo].[PublicationStatus] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'CANCELED', CAST(N'2021-05-18T14:39:43.0830000' AS DateTime2), NULL)
GO
INSERT [dbo].[Review] ([Id], [Title], [SenderCustomerId], [RecipientCustomerId], [CreatedDateTime], [LastModifiedDateTime], [Rating], [Comment], [ReviewStatusId]) VALUES (1, N'Super Pro', 2, 3, CAST(N'2021-05-24T21:44:39.2030000' AS DateTime2), CAST(N'2021-05-24T21:44:39.2030000' AS DateTime2), 5, N'Pedro est un mannequin super et talentueux', 3)
INSERT [dbo].[Review] ([Id], [Title], [SenderCustomerId], [RecipientCustomerId], [CreatedDateTime], [LastModifiedDateTime], [Rating], [Comment], [ReviewStatusId]) VALUES (2, N'Top', 3, 2, CAST(N'2021-05-24T21:45:53.0800000' AS DateTime2), CAST(N'2021-05-24T21:45:53.0800000' AS DateTime2), 5, N'Nathalie Pomme est une directrice de casting super professionnelle', 3)
GO
SET IDENTITY_INSERT [dbo].[ReviewStatus] ON 

INSERT [dbo].[ReviewStatus] ([Id], [SystemName], [CreatedDateTime], [LastModdifiedDateTime]) VALUES (1, N'CREATED', CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2), CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2))
INSERT [dbo].[ReviewStatus] ([Id], [SystemName], [CreatedDateTime], [LastModdifiedDateTime]) VALUES (2, N'WAITING_VALIDATION', CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2), CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2))
INSERT [dbo].[ReviewStatus] ([Id], [SystemName], [CreatedDateTime], [LastModdifiedDateTime]) VALUES (3, N'VALIDATED', CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2), CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2))
INSERT [dbo].[ReviewStatus] ([Id], [SystemName], [CreatedDateTime], [LastModdifiedDateTime]) VALUES (4, N'REJECTED', CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2), CAST(N'2021-05-24T20:53:15.7700000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ReviewStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceType] ON 

INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'Photo Book Maker', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'Shooting Photo', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'Cours de photo', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'Cours de maintient', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (5, N'Coaching Acteur', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (6, N'Location de Studio', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (7, N'Retouche Photo', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (8, N'Essayage', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (9, N'Doublure', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (10, N'Mise en Beauté Naturelle', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (11, N'Mise en Beauté Fashion', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (12, N'Organisation de Casting', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (13, N'Production de Shooting', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (14, N'Cours de Makeup', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
INSERT [dbo].[ServiceType] ([Id], [SystemName], [CreatedDateTime], [LastModifiedDateTime]) VALUES (15, N'Special effects makeup', CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2), CAST(N'2021-05-26T11:09:48.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ServiceType] OFF
GO
SET IDENTITY_INSERT [dbo].[State] ON 

INSERT [dbo].[State] ([Id], [Label], [Title], [CountryId], [CreatedDateTime], [LastModifiedDateTime]) VALUES (1, N'Rome', N'Roma', 1, CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2))
INSERT [dbo].[State] ([Id], [Label], [Title], [CountryId], [CreatedDateTime], [LastModifiedDateTime]) VALUES (2, N'Venise', N'Venise', 1, CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2))
INSERT [dbo].[State] ([Id], [Label], [Title], [CountryId], [CreatedDateTime], [LastModifiedDateTime]) VALUES (3, N'Bruxelles', N'Brussels', 2, CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2))
INSERT [dbo].[State] ([Id], [Label], [Title], [CountryId], [CreatedDateTime], [LastModifiedDateTime]) VALUES (4, N'Namur', N'Namur', 2, CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2), CAST(N'2021-05-23T20:28:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[State] OFF
GO
SET IDENTITY_INSERT [dbo].[Subscription] ON 

INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (1, N'Ristretto', N'', CAST(5.00 AS Decimal(8, 2)), 1, 2, CAST(5.00 AS Decimal(8, 2)), 15, CAST(N'2021-05-20T20:03:40.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:03:40.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (2, N'Lungo', N'', CAST(190.00 AS Decimal(8, 2)), 1, 4, CAST(190.00 AS Decimal(8, 2)), 800, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (3, N'Espresso', N'', CAST(10.00 AS Decimal(8, 2)), 1, 2, CAST(10.00 AS Decimal(8, 2)), 35, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (4, N'Free Ristretto', N'', CAST(0.00 AS Decimal(8, 2)), 1, 2, CAST(0.00 AS Decimal(8, 2)), 0, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (5, N'Free', N'', CAST(0.00 AS Decimal(8, 2)), 2, 4, CAST(0.00 AS Decimal(8, 2)), 0, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (6, N'Ristretto - Annuel - Nvx', N'', CAST(45.00 AS Decimal(8, 2)), 2, 3, CAST(45.00 AS Decimal(8, 2)), 225, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (7, N'Ristretto - Yearly - Nvx', N'', CAST(45.00 AS Decimal(8, 2)), 2, 3, CAST(45.00 AS Decimal(8, 2)), 225, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (8, N'Espresso - Annuel - Nvx', N'', CAST(90.00 AS Decimal(8, 2)), 2, 3, CAST(90.00 AS Decimal(8, 2)), 450, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
INSERT [dbo].[Subscription] ([Id], [SystemName], [Description], [Price], [EntityStatusId], [PeriodicityId], [PricePerPeriod], [CreditPerPeriod], [CreatedDateTime], [DeletedDateTime], [LastModifiedDateTime]) VALUES (9, N'Espresso - Yearly - Nvx', N'', CAST(90.00 AS Decimal(8, 2)), 2, 3, CAST(90.00 AS Decimal(8, 2)), 450, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2), NULL, CAST(N'2021-05-20T20:11:06.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Subscription] OFF
GO
/****** Object:  Index [IX_Book_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Book_CustomerId] ON [cc].[Book]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([Title],[Order],[Status]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BookItem_Covering]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_BookItem_Covering] ON [cc].[BookItem]
(
	[BookId] ASC
)
INCLUDE([DisplayOrder],[MediaType],[MediaValue],[Copyright],[Description],[DateTaken],[Dimensions]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Casting_Covering]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Casting_Covering] ON [cc].[Casting]
(
	[EndDateTime] ASC,
	[Status] ASC
)
INCLUDE([CastingCafeCustomerId],[CastingTypeId],[Title],[Description],[EITCityId],[EITCountryId],[MediaType],[MediaValue],[PublicationMode],[CastingCafeRoleId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Casting_ForCustomerDetails]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Casting_ForCustomerDetails] ON [cc].[Casting]
(
	[CastingCafeCustomerId] ASC,
	[Status] ASC,
	[EndDateTime] ASC
)
INCLUDE([Title],[EITCityId],[EITCountryId],[StartDateTime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Casting_Status_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Casting_Status_CustomerId] ON [cc].[Casting]
(
	[Status] ASC
)
INCLUDE([CastingCafeCustomerId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingCafeConfigurationLocal_ConfigId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCafeConfigurationLocal_ConfigId] ON [cc].[CastingCafeConfigurationLocal]
(
	[CastingCafeConfigurationId] ASC
)
INCLUDE([EITCultureId],[VATRegEx],[Placeholder],[ApplyVatRateInOrders],[IsHq]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_EITUserId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [index_EITUserId] ON [cc].[CastingCafeCustomer]
(
	[EITUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CastingCafeCustomer_Homepage]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCafeCustomer_Homepage] ON [cc].[CastingCafeCustomer]
(
	[EITCountryId] ASC,
	[CustomerStatus] ASC,
	[Avatar] ASC,
	[ValidUntil] ASC
)
INCLUDE([Id],[ProfessionalName],[CastingCafePersonId],[CastingCafeOrganizationId],[CastingCafeRoleId],[EITSvcStampCreatedAt],[Rating],[EITCityId],[LastProfileModification]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingCafeCustomer_RoleId_incl_CountryId_Status_Rating_CityId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCafeCustomer_RoleId_incl_CountryId_Status_Rating_CityId] ON [cc].[CastingCafeCustomer]
(
	[CastingCafeRoleId] ASC
)
INCLUDE([EITCountryId],[CustomerStatus],[Rating],[EITCityId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingCafeOrganization_Name_FirstName_LastName]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCafeOrganization_Name_FirstName_LastName] ON [cc].[CastingCafeOrganization]
(
	[Id] ASC
)
INCLUDE([Name],[ContactFirstname],[ContactLastname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingCafeRoleLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCafeRoleLocal_typical] ON [cc].[CastingCafeRoleLocal]
(
	[CastingCafeRoleId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingCalled_CastingId_Status]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingCalled_CastingId_Status] ON [cc].[CastingCalled]
(
	[Status] ASC,
	[CastingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingSearchIntCriterion_HeaderId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingSearchIntCriterion_HeaderId] ON [cc].[CastingSearchIntCriterion]
(
	[HeaderId] ASC
)
INCLUDE([ProfileItemId],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CastingTypeLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CastingTypeLocal_typical] ON [cc].[CastingTypeLocal]
(
	[CastingTypeId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CodePromo_OrderLineId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CodePromo_OrderLineId] ON [cc].[CodePromo]
(
	[OrderLineId] ASC
)
INCLUDE([CodePromoType],[DiscountType],[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerService_Covering]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_CustomerService_Covering] ON [cc].[CustomerService]
(
	[CastingCafeCustomerId] ASC,
	[Status] ASC,
	[ServiceTypeId] ASC,
	[PublicationDate] ASC
)
INCLUDE([Description],[EITCountryId],[EITCityId],[PriceUnitTypeId],[Title],[PriceMax],[PriceMin],[MediaValue],[MediaType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Exposure_Homepage]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Exposure_Homepage] ON [cc].[Exposure]
(
	[DateFrom] ASC,
	[DateTo] ASC,
	[ExposureEntityType] ASC
)
INCLUDE([ExposureEntityId],[OrderLineId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_InternalMessage_Inbox]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_InternalMessage_Inbox] ON [cc].[InternalMessage]
(
	[RecipientId] ASC
)
INCLUDE([AuthorId],[IsRead],[Date],[Subject]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_InternalMessage_Outbox]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_InternalMessage_Outbox] ON [cc].[InternalMessage]
(
	[AuthorId] ASC
)
INCLUDE([RecipientId],[IsRead],[Date],[Subject]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NewsletterSubscription_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_NewsletterSubscription_CustomerId] ON [cc].[NewsletterSubscription]
(
	[CastingCafeCustomerId] ASC,
	[Active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_CustomerId_Status]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Order_CustomerId_Status] ON [cc].[Order]
(
	[CastingCafeCustomerId] ASC,
	[OrderStatus] ASC
)
INCLUDE([EITSvcStampCreatedAt],[BillingEITCountryId],[VAT]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Order_ForLatestOrder]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Order_ForLatestOrder] ON [cc].[Order]
(
	[CastingCafeCustomerId] ASC,
	[OrderStatus] ASC
)
INCLUDE([PaidOn]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLine_ForCreditsStatus]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_OrderLine_ForCreditsStatus] ON [cc].[OrderLine]
(
	[OrderLineStatus] ASC,
	[NumberOfCredit] ASC,
	[ProductType] ASC
)
INCLUDE([OrderId],[ProductId],[PriceUnit],[Quantity],[ActiveOn],[ValidUntil]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLine_OrderId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_OrderLine_OrderId] ON [cc].[OrderLine]
(
	[OrderId] ASC
)
INCLUDE([PaymentType],[PriceUnit],[SetupFee],[Quantity],[Title],[UpdateFee],[CurrencyId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLine_Subscription]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_OrderLine_Subscription] ON [cc].[OrderLine]
(
	[ProductType] ASC,
	[ActiveOn] ASC,
	[ValidUntil] ASC
)
INCLUDE([OrderId],[ProductId],[OrderLineStatus],[PriceUnit]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PriceUnitTypeLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_PriceUnitTypeLocal_typical] ON [cc].[PriceUnitTypeLocal]
(
	[PriceUnitTypeId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Label]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_ProductType]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Product_ProductType] ON [cc].[Product]
(
	[ProductType] ASC,
	[EITCultureId] ASC,
	[EntityStatus] ASC
)
INCLUDE([Price]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItem_ForCompletionPercentage]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItem_ForCompletionPercentage] ON [cc].[ProfileItem]
(
	[Id] ASC,
	[ParentProfileItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItem_ForDetails]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItem_ForDetails] ON [cc].[ProfileItem]
(
	[ParentProfileItemId] ASC,
	[IsDisplayedInSignup] ASC
)
INCLUDE([ProfileItemType],[Label],[DisplayOrder],[IsMandatory],[NeedCheckBeforeValue],[IsMultiple],[IsMainInfo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItemLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItemLocal_typical] ON [cc].[ProfileItemLocal]
(
	[EITCultureId] ASC,
	[ProfileItemId] ASC
)
INCLUDE([Name],[UnitMeasures]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItemValueBoolean_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItemValueBoolean_CustomerId] ON [cc].[ProfileItemValueBoolean]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([ProfileItemId],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItemValueDate_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItemValueDate_CustomerId] ON [cc].[ProfileItemValueDate]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([ProfileItemId],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItemValueInt_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItemValueInt_CustomerId] ON [cc].[ProfileItemValueInt]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([ProfileItemId],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProfileItemValueString_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ProfileItemValueString_CustomerId] ON [cc].[ProfileItemValueString]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([ProfileItemId],[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Publication_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Publication_CustomerId] ON [cc].[Publication]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([Title],[PublicationName],[MediaType],[MediaValue],[PublicationDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelCastingCafeCustomerCasting_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_RelCastingCafeCustomerCasting_CustomerId] ON [cc].[RelCastingCafeCustomerCasting]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([CastingId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelCastingCafeCustomerCastingCafeCustomer_Contacts]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_RelCastingCafeCustomerCastingCafeCustomer_Contacts] ON [cc].[RelCastingCafeCustomerCastingCafeCustomer]
(
	[FromCastingCafeCustomerId] ASC,
	[ToCastingCafeCustomerId] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelCastingCafeCustomerCastingCafeCustomer_Selections]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_RelCastingCafeCustomerCastingCafeCustomer_Selections] ON [cc].[RelCastingCafeCustomerCastingCafeCustomer]
(
	[FromCastingCafeCustomerId] ASC,
	[Status] ASC,
	[OrderLineId] ASC
)
INCLUDE([ToCastingCafeCustomerId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RelCastingCafeCustomerCustomerService_CustomerId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_RelCastingCafeCustomerCustomerService_CustomerId] ON [cc].[RelCastingCafeCustomerCustomerService]
(
	[CastingCafeCustomerId] ASC
)
INCLUDE([CustomerServiceId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reviews_TargetId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_Reviews_TargetId] ON [cc].[Reviews]
(
	[CastingCafeCustomerTargetId] ASC
)
INCLUDE([CastingCafeCustomerAuthorId],[Rating],[Comment]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServiceTypeLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_ServiceTypeLocal_typical] ON [cc].[ServiceTypeLocal]
(
	[ServiceTypeId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ix_block_systemname]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [ix_block_systemname] ON [cms].[Block]
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_BlockLocal_incl_Body]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [index_BlockLocal_incl_Body] ON [cms].[BlockLocal]
(
	[BlockId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Body]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NewsLocal_IsActiveInCulture]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_NewsLocal_IsActiveInCulture] ON [cms].[NewsLocal]
(
	[EITCultureId] ASC,
	[IsActiveInCulture] ASC
)
INCLUDE([Title],[Summary],[NewsId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_PageLocal]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [index_PageLocal] ON [cms].[PageLocal]
(
	[EITCultureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SliderItemLocal_ActiveInCulture]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_SliderItemLocal_ActiveInCulture] ON [cms].[SliderItemLocal]
(
	[EITCultureId] ASC,
	[IsActiveInCulture] ASC
)
INCLUDE([SliderItemId],[Description]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TermLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_TermLocal_typical] ON [cms].[TermLocal]
(
	[EITCultureId] ASC
)
INCLUDE([TermId],[Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)
INCLUDE([LoginProvider],[ProviderKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CreditPack_Unique_SystemName]    Script Date: 31-05-21 15:25:19 ******/
ALTER TABLE [dbo].[CreditPack] ADD  CONSTRAINT [IX_CreditPack_Unique_SystemName] UNIQUE NONCLUSTERED 
(
	[SystemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EITCity_Label]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_EITCity_Label] ON [eit].[EITCity]
(
	[Label] ASC,
	[EITCountryId] ASC
)
INCLUDE([Zip]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_CityLocalTitle]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [index_CityLocalTitle] ON [eit].[EITCityLocal]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_EITCityLocal_51D2C4D1FCF0AE96EC57]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [nci_wi_EITCityLocal_51D2C4D1FCF0AE96EC57] ON [eit].[EITCityLocal]
(
	[EITCultureId] ASC
)
INCLUDE([EITCityId],[Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [nci_wi_EITCityLocal_78749C7ABFFAB78E531B]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [nci_wi_EITCityLocal_78749C7ABFFAB78E531B] ON [eit].[EITCityLocal]
(
	[EITCityId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EITCountryLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_EITCountryLocal_typical] ON [eit].[EITCountryLocal]
(
	[EITCountryId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EITCulture_IsActive_Host_Name_UrlPrefix]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_EITCulture_IsActive_Host_Name_UrlPrefix] ON [eit].[EITCulture]
(
	[IsActive] ASC
)
INCLUDE([Host],[Name],[URLPrefix]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EITCurrencyLocal_typical]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_EITCurrencyLocal_typical] ON [eit].[EITCurrencyLocal]
(
	[EITCurrencyId] ASC,
	[EITCultureId] ASC
)
INCLUDE([Name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_FriendlyUrl_Most]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_FriendlyUrl_Most] ON [eit].[EITFriendlyURL]
(
	[IsFavorite] ASC,
	[ObjectId] ASC,
	[Type] ASC,
	[EITCultureId] ASC
)
INCLUDE([Link]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EITNotification_TargetId_Status]    Script Date: 31-05-21 15:25:19 ******/
CREATE NONCLUSTERED INDEX [IX_EITNotification_TargetId_Status] ON [eit].[EITNotification]
(
	[TargetId] ASC,
	[Status] ASC,
	[NotificationType] ASC
)
INCLUDE([CreatedAt],[Title],[EITLogItemId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [cc].[Book] ADD  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [cc].[Casting] ADD  CONSTRAINT [DF__Casting__Casting__27F8EE98]  DEFAULT ((1)) FOR [CastingCafeRoleId]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] ADD  CONSTRAINT [DF__CastingCa__VATRa__671F4F74]  DEFAULT ((0)) FOR [VATRate]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] ADD  CONSTRAINT [DF__CastingCa__BankT__65370702]  DEFAULT ((5)) FOR [BankTransferDueDay]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] ADD  CONSTRAINT [DF__CastingCa__VATRe__662B2B3B]  DEFAULT ('') FOR [VATRegEx]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] ADD  CONSTRAINT [DF__CastingCa__Place__681373AD]  DEFAULT (' ') FOR [Placeholder]
GO
ALTER TABLE [cc].[CastingCafeCustomer] ADD  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [cc].[CastingCafeCustomer] ADD  DEFAULT ((0)) FOR [ProfileViews]
GO
ALTER TABLE [cc].[CastingCafePerson] ADD  DEFAULT ((0)) FOR [IsChild]
GO
ALTER TABLE [cc].[CastingCafeRole] ADD  DEFAULT ((0)) FOR [ProfileId]
GO
ALTER TABLE [cc].[CastingCafeRole] ADD  DEFAULT ((1)) FOR [IsIncludedInSearch]
GO
ALTER TABLE [cc].[CastingCafeRole] ADD  DEFAULT ((0)) FOR [SkipBookStep]
GO
ALTER TABLE [cc].[CastingSearchHeader] ADD  CONSTRAINT [DF_CastingSearchHeader_ZoneKm]  DEFAULT ((100)) FOR [ZoneKm]
GO
ALTER TABLE [cc].[CastingSetup] ADD  DEFAULT ((0)) FOR [AlertsFrequencyType]
GO
ALTER TABLE [cc].[Composite] ADD  DEFAULT ((0)) FOR [UseAvatarForMainPicture]
GO
ALTER TABLE [cc].[CustomerService] ADD  DEFAULT (sysdatetime()) FOR [PublicationDate]
GO
ALTER TABLE [cc].[GlobalPromocodeUsage] ADD  CONSTRAINT [DF_GlobalPromoCodeUsage_DateUsed]  DEFAULT (sysdatetime()) FOR [DateUsed]
GO
ALTER TABLE [cc].[InternalMessage] ADD  CONSTRAINT [DF_InternalMessage_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [cc].[NewsletterSubscription] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cc].[Product] ADD  CONSTRAINT [DF__Product__MinQuan__6CD828CA]  DEFAULT ((1)) FOR [MinQuantity]
GO
ALTER TABLE [cc].[ProfileItem] ADD  DEFAULT ((0)) FOR [SearchIsMultiple]
GO
ALTER TABLE [cc].[ProfileItem] ADD  DEFAULT ((0)) FOR [SearchIsApproximative]
GO
ALTER TABLE [cc].[ProfileItem] ADD  DEFAULT ((0)) FOR [IsMainInfo]
GO
ALTER TABLE [cc].[ProfileItem] ADD  DEFAULT ((1)) FOR [IsDisplayedInSignup]
GO
ALTER TABLE [cc].[ProfileItem] ADD  DEFAULT ((0)) FOR [IsRestrictedToContacts]
GO
ALTER TABLE [cc].[ProfileItemLocal] ADD  DEFAULT ((0)) FOR [IsActiveInCulture]
GO
ALTER TABLE [cms].[SliderItemLocal] ADD  DEFAULT ((0)) FOR [IsActiveInCulture]
GO
ALTER TABLE [dbo].[CustomerEvent] ADD  DEFAULT ((2)) FOR [EventStatusId]
GO
ALTER TABLE [dbo].[CustomerService] ADD  CONSTRAINT [defaultStatus]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[LogEntry] ADD  CONSTRAINT [DF_LogEntry_DateAndTime]  DEFAULT (sysdatetime()) FOR [DateAndTime]
GO
ALTER TABLE [dbo].[Notification] ADD  CONSTRAINT [DF_Notification_TargetId]  DEFAULT ((0)) FOR [TargetId]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Rating]  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_ReviewStatusId]  DEFAULT ((2)) FOR [ReviewStatusId]
GO
ALTER TABLE [eit].[EITCulture] ADD  CONSTRAINT [DV_EITCulture_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [eit].[EITCulture] ADD  CONSTRAINT [DF__EITCultur__IsAct__70A8B9AE]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [eit].[EITCurrency] ADD  DEFAULT ((0)) FOR [CodeSIPS]
GO
ALTER TABLE [eit].[EITNotification] ADD  CONSTRAINT [DF_EITNotification_TargetId]  DEFAULT ((0)) FOR [TargetId]
GO
ALTER TABLE [cc].[Book]  WITH CHECK ADD  CONSTRAINT [FK_93994384b6d877365999479745f] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[Book] CHECK CONSTRAINT [FK_93994384b6d877365999479745f]
GO
ALTER TABLE [cc].[BookItem]  WITH CHECK ADD  CONSTRAINT [FK_fe68dfd401dbde47bb969650dd6] FOREIGN KEY([BookId])
REFERENCES [cc].[Book] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[BookItem] CHECK CONSTRAINT [FK_fe68dfd401dbde47bb969650dd6]
GO
ALTER TABLE [cc].[Casting]  WITH CHECK ADD  CONSTRAINT [FK_3ece9874752b704612fd9cbddf4] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[Casting] CHECK CONSTRAINT [FK_3ece9874752b704612fd9cbddf4]
GO
ALTER TABLE [cc].[Casting]  WITH CHECK ADD  CONSTRAINT [FK_5b34a354ded8dac8c41c76ad083] FOREIGN KEY([CastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[Casting] CHECK CONSTRAINT [FK_5b34a354ded8dac8c41c76ad083]
GO
ALTER TABLE [cc].[Casting]  WITH CHECK ADD  CONSTRAINT [FK_5f67c424c1e9ae295a4377a61da] FOREIGN KEY([EITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[Casting] CHECK CONSTRAINT [FK_5f67c424c1e9ae295a4377a61da]
GO
ALTER TABLE [cc].[Casting]  WITH CHECK ADD  CONSTRAINT [FK_Casting_CastingSetup] FOREIGN KEY([CastingSetupId])
REFERENCES [cc].[CastingSetup] ([Id])
GO
ALTER TABLE [cc].[Casting] CHECK CONSTRAINT [FK_Casting_CastingSetup]
GO
ALTER TABLE [cc].[Casting]  WITH CHECK ADD  CONSTRAINT [FK_eb28dc54b2f9735cafa21387bbd] FOREIGN KEY([CastingTypeId])
REFERENCES [cc].[CastingType] ([Id])
GO
ALTER TABLE [cc].[Casting] CHECK CONSTRAINT [FK_eb28dc54b2f9735cafa21387bbd]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal]  WITH CHECK ADD  CONSTRAINT [FK_2d1cae2492f9ed7ac78f1744766] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] CHECK CONSTRAINT [FK_2d1cae2492f9ed7ac78f1744766]
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal]  WITH CHECK ADD  CONSTRAINT [FK_7e98dcf4186ba553092da32c80c] FOREIGN KEY([CastingCafeConfigurationId])
REFERENCES [cc].[CastingCafeConfiguration] ([Id])
GO
ALTER TABLE [cc].[CastingCafeConfigurationLocal] CHECK CONSTRAINT [FK_7e98dcf4186ba553092da32c80c]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_1432d00411896f2a4178b20f46f] FOREIGN KEY([EITUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_1432d00411896f2a4178b20f46f]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_227866041be8ed1ebc34ee70c59] FOREIGN KEY([EITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_227866041be8ed1ebc34ee70c59]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_29c05364aac9410a4c7506eb6de] FOREIGN KEY([CastingCafePersonId])
REFERENCES [cc].[CastingCafePerson] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_29c05364aac9410a4c7506eb6de]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_2c106124cabb8cb78300b9ef9fc] FOREIGN KEY([BillingEITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_2c106124cabb8cb78300b9ef9fc]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_62f865f4316b985f8de46f1b57f] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_62f865f4316b985f8de46f1b57f]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_7d11276434e92d264392b3bdb66] FOREIGN KEY([CastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_7d11276434e92d264392b3bdb66]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_9436833461bbb966db868d5e721] FOREIGN KEY([CastingCafeOrganizationId])
REFERENCES [cc].[CastingCafeOrganization] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_9436833461bbb966db868d5e721]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CastingSetup] FOREIGN KEY([CastingSetupId])
REFERENCES [cc].[CastingSetup] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_Customer_CastingSetup]
GO
ALTER TABLE [cc].[CastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_d761e434f9ea01892df0e908340] FOREIGN KEY([BillingEITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
GO
ALTER TABLE [cc].[CastingCafeCustomer] CHECK CONSTRAINT [FK_d761e434f9ea01892df0e908340]
GO
ALTER TABLE [cc].[CastingCafeOrganization]  WITH CHECK ADD  CONSTRAINT [FK_a20c71c46e19ff9efc98b01a24c] FOREIGN KEY([DomainId])
REFERENCES [cc].[Domain] ([Id])
GO
ALTER TABLE [cc].[CastingCafeOrganization] CHECK CONSTRAINT [FK_a20c71c46e19ff9efc98b01a24c]
GO
ALTER TABLE [cc].[CastingCafeOrganization]  WITH CHECK ADD  CONSTRAINT [FK_e4f2f43428a92cc57b12ae5c5bb] FOREIGN KEY([LegalStatuId])
REFERENCES [cc].[LegalStatus] ([Id])
GO
ALTER TABLE [cc].[CastingCafeOrganization] CHECK CONSTRAINT [FK_e4f2f43428a92cc57b12ae5c5bb]
GO
ALTER TABLE [cc].[CastingCafeRole]  WITH CHECK ADD  CONSTRAINT [FK_c19ffc64cb9820e94d649d35bd9] FOREIGN KEY([ProfileId])
REFERENCES [cc].[Profile] ([Id])
GO
ALTER TABLE [cc].[CastingCafeRole] CHECK CONSTRAINT [FK_c19ffc64cb9820e94d649d35bd9]
GO
ALTER TABLE [cc].[CastingCafeRoleLocal]  WITH CHECK ADD  CONSTRAINT [FK_1b04209465f806ae422ee2d4f63] FOREIGN KEY([CastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingCafeRoleLocal] CHECK CONSTRAINT [FK_1b04209465f806ae422ee2d4f63]
GO
ALTER TABLE [cc].[CastingCafeRoleLocal]  WITH CHECK ADD  CONSTRAINT [FK_209481f47de951cf41f607d0e58] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[CastingCafeRoleLocal] CHECK CONSTRAINT [FK_209481f47de951cf41f607d0e58]
GO
ALTER TABLE [cc].[CastingCalled]  WITH CHECK ADD  CONSTRAINT [FK_2320ba743d29f09a81b467d976b] FOREIGN KEY([CastingId])
REFERENCES [cc].[Casting] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingCalled] CHECK CONSTRAINT [FK_2320ba743d29f09a81b467d976b]
GO
ALTER TABLE [cc].[CastingCalled]  WITH CHECK ADD  CONSTRAINT [FK_9e1abaf40b4819c77bedf822fdd] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingCalled] CHECK CONSTRAINT [FK_9e1abaf40b4819c77bedf822fdd]
GO
ALTER TABLE [cc].[CastingSearchBooleanCriterion]  WITH CHECK ADD  CONSTRAINT [FK_CastingSearchHeader_ProfileItemBool_CastingSearchHeader] FOREIGN KEY([HeaderId])
REFERENCES [cc].[CastingSearchHeader] ([CastingId])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingSearchBooleanCriterion] CHECK CONSTRAINT [FK_CastingSearchHeader_ProfileItemBool_CastingSearchHeader]
GO
ALTER TABLE [cc].[CastingSearchBooleanCriterion]  WITH CHECK ADD  CONSTRAINT [FK_CastingSearchHeader_ProfileItemBool_ProfileItem] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingSearchBooleanCriterion] CHECK CONSTRAINT [FK_CastingSearchHeader_ProfileItemBool_ProfileItem]
GO
ALTER TABLE [cc].[CastingSearchHeader]  WITH CHECK ADD  CONSTRAINT [FK_CastingSearchHeader_Casting] FOREIGN KEY([CastingId])
REFERENCES [cc].[Casting] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingSearchHeader] CHECK CONSTRAINT [FK_CastingSearchHeader_Casting]
GO
ALTER TABLE [cc].[CastingSearchIntCriterion]  WITH CHECK ADD  CONSTRAINT [FK_CastingSearchHeader_ProfileItemInt_CastingSearchHeader] FOREIGN KEY([HeaderId])
REFERENCES [cc].[CastingSearchHeader] ([CastingId])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingSearchIntCriterion] CHECK CONSTRAINT [FK_CastingSearchHeader_ProfileItemInt_CastingSearchHeader]
GO
ALTER TABLE [cc].[CastingSearchIntCriterion]  WITH CHECK ADD  CONSTRAINT [FK_CastingSearchHeader_ProfileItemInt_ProfileItem] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingSearchIntCriterion] CHECK CONSTRAINT [FK_CastingSearchHeader_ProfileItemInt_ProfileItem]
GO
ALTER TABLE [cc].[CastingTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_644a15346c5ad3ffdcd60e2ce72] FOREIGN KEY([CastingTypeId])
REFERENCES [cc].[CastingType] ([Id])
GO
ALTER TABLE [cc].[CastingTypeLocal] CHECK CONSTRAINT [FK_644a15346c5ad3ffdcd60e2ce72]
GO
ALTER TABLE [cc].[CastingTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_c277f4e437f82c2e99d90cf2013] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CastingTypeLocal] CHECK CONSTRAINT [FK_c277f4e437f82c2e99d90cf2013]
GO
ALTER TABLE [cc].[CodePromo]  WITH CHECK ADD  CONSTRAINT [FK_171f86c45c593ac8bc2213e562c] FOREIGN KEY([ProductId])
REFERENCES [cc].[Product] ([Id])
GO
ALTER TABLE [cc].[CodePromo] CHECK CONSTRAINT [FK_171f86c45c593ac8bc2213e562c]
GO
ALTER TABLE [cc].[CodePromo]  WITH CHECK ADD  CONSTRAINT [FK_c47f1fb4cecaf3e48b667be2a8d] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CodePromo] CHECK CONSTRAINT [FK_c47f1fb4cecaf3e48b667be2a8d]
GO
ALTER TABLE [cc].[CodePromo]  WITH CHECK ADD  CONSTRAINT [FK_e7004944d7db41f7108535a1d0e] FOREIGN KEY([OrderLineId])
REFERENCES [cc].[OrderLine] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CodePromo] CHECK CONSTRAINT [FK_e7004944d7db41f7108535a1d0e]
GO
ALTER TABLE [cc].[Composite]  WITH CHECK ADD  CONSTRAINT [FK_Composite_BookItem01] FOREIGN KEY([BookItem01Id])
REFERENCES [cc].[BookItem] ([Id])
GO
ALTER TABLE [cc].[Composite] CHECK CONSTRAINT [FK_Composite_BookItem01]
GO
ALTER TABLE [cc].[Composite]  WITH CHECK ADD  CONSTRAINT [FK_Composite_BookItem02] FOREIGN KEY([BookItem02Id])
REFERENCES [cc].[BookItem] ([Id])
GO
ALTER TABLE [cc].[Composite] CHECK CONSTRAINT [FK_Composite_BookItem02]
GO
ALTER TABLE [cc].[Composite]  WITH CHECK ADD  CONSTRAINT [FK_Composite_BookItem03] FOREIGN KEY([BookItem03Id])
REFERENCES [cc].[BookItem] ([Id])
GO
ALTER TABLE [cc].[Composite] CHECK CONSTRAINT [FK_Composite_BookItem03]
GO
ALTER TABLE [cc].[Composite]  WITH CHECK ADD  CONSTRAINT [FK_Composite_Customer] FOREIGN KEY([CustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[Composite] CHECK CONSTRAINT [FK_Composite_Customer]
GO
ALTER TABLE [cc].[CreditNote]  WITH CHECK ADD  CONSTRAINT [FK_f7842c946afb2392e89255840f1] FOREIGN KEY([OrderId])
REFERENCES [cc].[Order] ([Id])
GO
ALTER TABLE [cc].[CreditNote] CHECK CONSTRAINT [FK_f7842c946afb2392e89255840f1]
GO
ALTER TABLE [cc].[CustomerProfileHistory]  WITH CHECK ADD  CONSTRAINT [FK_03e25c74c4ca1c664d3892366c6] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CustomerProfileHistory] CHECK CONSTRAINT [FK_03e25c74c4ca1c664d3892366c6]
GO
ALTER TABLE [cc].[CustomerSavedSearch]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSavedSearch_CastingCafeCustomer] FOREIGN KEY([CustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CustomerSavedSearch] CHECK CONSTRAINT [FK_CustomerSavedSearch_CastingCafeCustomer]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_21062d6409590bb08dceb0e2735] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_21062d6409590bb08dceb0e2735]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_7b7b82a48e48f23b0c74bb07d79] FOREIGN KEY([PriceUnitTypeId])
REFERENCES [cc].[PriceUnitType] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_7b7b82a48e48f23b0c74bb07d79]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_a0fd4c64e818a115be75511f7b6] FOREIGN KEY([EITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_a0fd4c64e818a115be75511f7b6]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_a316f0941ffad3cea0e09ae405e] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_a316f0941ffad3cea0e09ae405e]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_aeede634bc9ad563aee7b7236da] FOREIGN KEY([OrderLineId])
REFERENCES [cc].[OrderLine] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_aeede634bc9ad563aee7b7236da]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_b7814a844e0b7f59984ab80d407] FOREIGN KEY([ServiceTypeId])
REFERENCES [cc].[ServiceType] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_b7814a844e0b7f59984ab80d407]
GO
ALTER TABLE [cc].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_f2636cf48a799ba16b6c7bf8efd] FOREIGN KEY([EITCurrencyId])
REFERENCES [eit].[EITCurrency] ([Id])
GO
ALTER TABLE [cc].[CustomerService] CHECK CONSTRAINT [FK_f2636cf48a799ba16b6c7bf8efd]
GO
ALTER TABLE [cc].[CustomerWallet]  WITH CHECK ADD  CONSTRAINT [FK_db33a0d4c7eb54739c08741bbbf] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[CustomerWallet] CHECK CONSTRAINT [FK_db33a0d4c7eb54739c08741bbbf]
GO
ALTER TABLE [cc].[DelegationRequest]  WITH CHECK ADD  CONSTRAINT [FK_DelegationRequest_CastingCafeRole] FOREIGN KEY([RoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[DelegationRequest] CHECK CONSTRAINT [FK_DelegationRequest_CastingCafeRole]
GO
ALTER TABLE [cc].[DelegationRequest]  WITH CHECK ADD  CONSTRAINT [FK_DelegationRequest_EITCity] FOREIGN KEY([CityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[DelegationRequest] CHECK CONSTRAINT [FK_DelegationRequest_EITCity]
GO
ALTER TABLE [cc].[DomainLocal]  WITH CHECK ADD  CONSTRAINT [FK_4566b7c44b38ba5ef90151043dd] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[DomainLocal] CHECK CONSTRAINT [FK_4566b7c44b38ba5ef90151043dd]
GO
ALTER TABLE [cc].[DomainLocal]  WITH CHECK ADD  CONSTRAINT [FK_a72b6d241dc8b41c0e1925cb303] FOREIGN KEY([DomainId])
REFERENCES [cc].[Domain] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[DomainLocal] CHECK CONSTRAINT [FK_a72b6d241dc8b41c0e1925cb303]
GO
ALTER TABLE [cc].[GlobalPromocode_Product]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_Product_GlobalPromocode] FOREIGN KEY([PromocodeId])
REFERENCES [cc].[GlobalPromocode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocode_Product] CHECK CONSTRAINT [FK_GlobalPromocode_Product_GlobalPromocode]
GO
ALTER TABLE [cc].[GlobalPromocode_Product]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_Product_Product] FOREIGN KEY([ProductId])
REFERENCES [cc].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocode_Product] CHECK CONSTRAINT [FK_GlobalPromocode_Product_Product]
GO
ALTER TABLE [cc].[GlobalPromocode_Role]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_Role_CastingCafeRole] FOREIGN KEY([RoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocode_Role] CHECK CONSTRAINT [FK_GlobalPromocode_Role_CastingCafeRole]
GO
ALTER TABLE [cc].[GlobalPromocode_Role]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_Role_GlobalPromocode] FOREIGN KEY([PromocodeId])
REFERENCES [cc].[GlobalPromocode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocode_Role] CHECK CONSTRAINT [FK_GlobalPromocode_Role_GlobalPromocode]
GO
ALTER TABLE [cc].[GlobalPromocodeUsage]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocodeUsage_CastingCafeCustomer] FOREIGN KEY([CustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocodeUsage] CHECK CONSTRAINT [FK_GlobalPromocodeUsage_CastingCafeCustomer]
GO
ALTER TABLE [cc].[GlobalPromocodeUsage]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocodeUsage_GlobalPromocode] FOREIGN KEY([PromocodeId])
REFERENCES [cc].[GlobalPromocode] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[GlobalPromocodeUsage] CHECK CONSTRAINT [FK_GlobalPromocodeUsage_GlobalPromocode]
GO
ALTER TABLE [cc].[InternalMessage]  WITH CHECK ADD  CONSTRAINT [FK_2d701c9444baf2636dac95f3542] FOREIGN KEY([AuthorId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[InternalMessage] CHECK CONSTRAINT [FK_2d701c9444baf2636dac95f3542]
GO
ALTER TABLE [cc].[InternalMessage]  WITH CHECK ADD  CONSTRAINT [FK_ba30f1748a4b6d3c3d7de9b86f5] FOREIGN KEY([RecipientId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[InternalMessage] CHECK CONSTRAINT [FK_ba30f1748a4b6d3c3d7de9b86f5]
GO
ALTER TABLE [cc].[InternalMessage]  WITH CHECK ADD  CONSTRAINT [FK_InternalMessage_InternalMessage] FOREIGN KEY([ParentId])
REFERENCES [cc].[InternalMessage] ([Id])
GO
ALTER TABLE [cc].[InternalMessage] CHECK CONSTRAINT [FK_InternalMessage_InternalMessage]
GO
ALTER TABLE [cc].[LegalStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_2659f664dbd8b2f90d11f5a62fe] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[LegalStatusLocal] CHECK CONSTRAINT [FK_2659f664dbd8b2f90d11f5a62fe]
GO
ALTER TABLE [cc].[LegalStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_f4c727448cbbb2d949c13a520ef] FOREIGN KEY([LegalStatusId])
REFERENCES [cc].[LegalStatus] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[LegalStatusLocal] CHECK CONSTRAINT [FK_f4c727448cbbb2d949c13a520ef]
GO
ALTER TABLE [cc].[NewsletterSubscription]  WITH CHECK ADD  CONSTRAINT [FK_f2e995548dd8af610a3bf81764c] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[NewsletterSubscription] CHECK CONSTRAINT [FK_f2e995548dd8af610a3bf81764c]
GO
ALTER TABLE [cc].[OnlinePaymentInfo]  WITH CHECK ADD  CONSTRAINT [FK_60c4fca48298d9aee33068fe4a7] FOREIGN KEY([CustomerWalletId])
REFERENCES [cc].[CustomerWallet] ([Id])
GO
ALTER TABLE [cc].[OnlinePaymentInfo] CHECK CONSTRAINT [FK_60c4fca48298d9aee33068fe4a7]
GO
ALTER TABLE [cc].[Order]  WITH CHECK ADD  CONSTRAINT [FK_8ff7e2b4aa2b6e58c08ab8ebe75] FOREIGN KEY([BillingEITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
GO
ALTER TABLE [cc].[Order] CHECK CONSTRAINT [FK_8ff7e2b4aa2b6e58c08ab8ebe75]
GO
ALTER TABLE [cc].[Order]  WITH CHECK ADD  CONSTRAINT [FK_acecf6849c9a0646060ebb218f8] FOREIGN KEY([BillingEITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [cc].[Order] CHECK CONSTRAINT [FK_acecf6849c9a0646060ebb218f8]
GO
ALTER TABLE [cc].[Order]  WITH CHECK ADD  CONSTRAINT [FK_d3c145b4008b42ddd16bbaea2c5] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[Order] CHECK CONSTRAINT [FK_d3c145b4008b42ddd16bbaea2c5]
GO
ALTER TABLE [cc].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_02931bd42b8957bb200989b513c] FOREIGN KEY([ProductId])
REFERENCES [cc].[Product] ([Id])
GO
ALTER TABLE [cc].[OrderLine] CHECK CONSTRAINT [FK_02931bd42b8957bb200989b513c]
GO
ALTER TABLE [cc].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_79ff5724434bdd8c128f1fc63fa] FOREIGN KEY([OrderId])
REFERENCES [cc].[Order] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[OrderLine] CHECK CONSTRAINT [FK_79ff5724434bdd8c128f1fc63fa]
GO
ALTER TABLE [cc].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_ab09b504b66b83e116d81755ae1] FOREIGN KEY([CurrencyId])
REFERENCES [eit].[EITCurrency] ([Id])
GO
ALTER TABLE [cc].[OrderLine] CHECK CONSTRAINT [FK_ab09b504b66b83e116d81755ae1]
GO
ALTER TABLE [cc].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_GlobalPromocode] FOREIGN KEY([PromocodeId])
REFERENCES [cc].[GlobalPromocode] ([Id])
GO
ALTER TABLE [cc].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_GlobalPromocode]
GO
ALTER TABLE [cc].[PriceUnitTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_ed1c71f4bad864ad0f018bbd2d8] FOREIGN KEY([PriceUnitTypeId])
REFERENCES [cc].[PriceUnitType] ([Id])
GO
ALTER TABLE [cc].[PriceUnitTypeLocal] CHECK CONSTRAINT [FK_ed1c71f4bad864ad0f018bbd2d8]
GO
ALTER TABLE [cc].[PriceUnitTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_PriceUnitTypeLocal_EITCulture] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[PriceUnitTypeLocal] CHECK CONSTRAINT [FK_PriceUnitTypeLocal_EITCulture]
GO
ALTER TABLE [cc].[Product]  WITH CHECK ADD  CONSTRAINT [FK_d86edc04fdcb0d7caab46b0fb89] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[Product] CHECK CONSTRAINT [FK_d86edc04fdcb0d7caab46b0fb89]
GO
ALTER TABLE [cc].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ff004294e439f638f1825067ac7] FOREIGN KEY([ParentProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[ProfileItem] CHECK CONSTRAINT [FK_ff004294e439f638f1825067ac7]
GO
ALTER TABLE [cc].[ProfileItemLocal]  WITH CHECK ADD  CONSTRAINT [FK_3016f5d4b51b780157e36650bba] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[ProfileItemLocal] CHECK CONSTRAINT [FK_3016f5d4b51b780157e36650bba]
GO
ALTER TABLE [cc].[ProfileItemLocal]  WITH CHECK ADD  CONSTRAINT [FK_f6e0c1a4bd49825653481296420] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[ProfileItemLocal] CHECK CONSTRAINT [FK_f6e0c1a4bd49825653481296420]
GO
ALTER TABLE [cc].[ProfileItemValueBoolean]  WITH CHECK ADD  CONSTRAINT [FK_8a9022a4bc59d0d02d3b8bf808d] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[ProfileItemValueBoolean] CHECK CONSTRAINT [FK_8a9022a4bc59d0d02d3b8bf808d]
GO
ALTER TABLE [cc].[ProfileItemValueBoolean]  WITH CHECK ADD  CONSTRAINT [FK_d06f7ad426fada4dd6d071c871a] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[ProfileItemValueBoolean] CHECK CONSTRAINT [FK_d06f7ad426fada4dd6d071c871a]
GO
ALTER TABLE [cc].[ProfileItemValueDate]  WITH CHECK ADD  CONSTRAINT [FK_31ab2bd4c51898bde961133dfba] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[ProfileItemValueDate] CHECK CONSTRAINT [FK_31ab2bd4c51898bde961133dfba]
GO
ALTER TABLE [cc].[ProfileItemValueDate]  WITH CHECK ADD  CONSTRAINT [FK_8aa710c4216a7710a81cb605471] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[ProfileItemValueDate] CHECK CONSTRAINT [FK_8aa710c4216a7710a81cb605471]
GO
ALTER TABLE [cc].[ProfileItemValueInt]  WITH CHECK ADD  CONSTRAINT [FK_6aa101741928567fa5e06838df6] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[ProfileItemValueInt] CHECK CONSTRAINT [FK_6aa101741928567fa5e06838df6]
GO
ALTER TABLE [cc].[ProfileItemValueInt]  WITH CHECK ADD  CONSTRAINT [FK_bba54384375abbd52b0094ec0de] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[ProfileItemValueInt] CHECK CONSTRAINT [FK_bba54384375abbd52b0094ec0de]
GO
ALTER TABLE [cc].[ProfileItemValueString]  WITH CHECK ADD  CONSTRAINT [FK_055d58f43519b2fa63450adc5cf] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[ProfileItemValueString] CHECK CONSTRAINT [FK_055d58f43519b2fa63450adc5cf]
GO
ALTER TABLE [cc].[ProfileItemValueString]  WITH CHECK ADD  CONSTRAINT [FK_bf857574be1a903f5f456a86243] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[ProfileItemValueString] CHECK CONSTRAINT [FK_bf857574be1a903f5f456a86243]
GO
ALTER TABLE [cc].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_74abb8d4b0c803e129efd11cb22] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[Publication] CHECK CONSTRAINT [FK_74abb8d4b0c803e129efd11cb22]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCasting]  WITH CHECK ADD  CONSTRAINT [FK_38006074465a428241ad04b48ab] FOREIGN KEY([CastingId])
REFERENCES [cc].[Casting] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCasting] CHECK CONSTRAINT [FK_38006074465a428241ad04b48ab]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCasting]  WITH CHECK ADD  CONSTRAINT [FK_c971a6c4d2ba81c217c80e6158f] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCasting] CHECK CONSTRAINT [FK_c971a6c4d2ba81c217c80e6158f]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_a8e6d2d47108f3cb9b6338fd234] FOREIGN KEY([FromCastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer] CHECK CONSTRAINT [FK_a8e6d2d47108f3cb9b6338fd234]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_add67c54e009a3c9dff586ebfa6] FOREIGN KEY([ToCastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer] CHECK CONSTRAINT [FK_add67c54e009a3c9dff586ebfa6]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer]  WITH CHECK ADD  CONSTRAINT [FK_b3a21504f498e19c5ae5ab8bf32] FOREIGN KEY([OrderLineId])
REFERENCES [cc].[OrderLine] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCastingCafeCustomer] CHECK CONSTRAINT [FK_b3a21504f498e19c5ae5ab8bf32]
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCustomerService]  WITH CHECK ADD  CONSTRAINT [FK_74c42c04869b228f4f6e3262c47] FOREIGN KEY([CastingCafeCustomerId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cc].[RelCastingCafeCustomerCustomerService] CHECK CONSTRAINT [FK_74c42c04869b228f4f6e3262c47]
GO
ALTER TABLE [cc].[RelCastingCafeRoleCastingCafeRole]  WITH CHECK ADD  CONSTRAINT [FK_7036bca40fbb37eec206a7efeb5] FOREIGN KEY([ToCastingCafeCustomerId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeRoleCastingCafeRole] CHECK CONSTRAINT [FK_7036bca40fbb37eec206a7efeb5]
GO
ALTER TABLE [cc].[RelCastingCafeRoleCastingCafeRole]  WITH CHECK ADD  CONSTRAINT [FK_b0d29744205bb9db73bfa6f5a2e] FOREIGN KEY([FromCastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeRoleCastingCafeRole] CHECK CONSTRAINT [FK_b0d29744205bb9db73bfa6f5a2e]
GO
ALTER TABLE [cc].[RelCastingCafeRoleCustomerServiceType]  WITH CHECK ADD  CONSTRAINT [FK_3fdd3424751825ae64a19da01a2] FOREIGN KEY([ServiceTypeId])
REFERENCES [cc].[ServiceType] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeRoleCustomerServiceType] CHECK CONSTRAINT [FK_3fdd3424751825ae64a19da01a2]
GO
ALTER TABLE [cc].[RelCastingCafeRoleCustomerServiceType]  WITH CHECK ADD  CONSTRAINT [FK_4990e5b4583902b61691853cbef] FOREIGN KEY([CastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[RelCastingCafeRoleCustomerServiceType] CHECK CONSTRAINT [FK_4990e5b4583902b61691853cbef]
GO
ALTER TABLE [cc].[RelNewsletterSubscriptionTerm]  WITH CHECK ADD  CONSTRAINT [FK_1ea48c14b39913a3ff77f7840a2] FOREIGN KEY([TermId])
REFERENCES [cms].[Term] ([Id])
GO
ALTER TABLE [cc].[RelNewsletterSubscriptionTerm] CHECK CONSTRAINT [FK_1ea48c14b39913a3ff77f7840a2]
GO
ALTER TABLE [cc].[RelNewsletterSubscriptionTerm]  WITH CHECK ADD  CONSTRAINT [FK_8cce5194f86875ea0258eefe5ef] FOREIGN KEY([NewsletterSubscriptionId])
REFERENCES [cc].[NewsletterSubscription] ([Id])
GO
ALTER TABLE [cc].[RelNewsletterSubscriptionTerm] CHECK CONSTRAINT [FK_8cce5194f86875ea0258eefe5ef]
GO
ALTER TABLE [cc].[RelProductCastingCafeRole]  WITH CHECK ADD  CONSTRAINT [FK_992229c49a8959585e8e53665fd] FOREIGN KEY([ProductId])
REFERENCES [cc].[Product] ([Id])
GO
ALTER TABLE [cc].[RelProductCastingCafeRole] CHECK CONSTRAINT [FK_992229c49a8959585e8e53665fd]
GO
ALTER TABLE [cc].[RelProductCastingCafeRole]  WITH CHECK ADD  CONSTRAINT [FK_ff30dc4489899ec25f526036172] FOREIGN KEY([CastingCafeRoleId])
REFERENCES [cc].[CastingCafeRole] ([Id])
GO
ALTER TABLE [cc].[RelProductCastingCafeRole] CHECK CONSTRAINT [FK_ff30dc4489899ec25f526036172]
GO
ALTER TABLE [cc].[RelProfileItemProfile]  WITH CHECK ADD  CONSTRAINT [FK__RelProfil__Profi__3587F3E0] FOREIGN KEY([ProfileItemId])
REFERENCES [cc].[ProfileItem] ([Id])
GO
ALTER TABLE [cc].[RelProfileItemProfile] CHECK CONSTRAINT [FK__RelProfil__Profi__3587F3E0]
GO
ALTER TABLE [cc].[RelProfileItemProfile]  WITH CHECK ADD  CONSTRAINT [FK__RelProfil__Profi__367C1819] FOREIGN KEY([ProfileId])
REFERENCES [cc].[Profile] ([Id])
GO
ALTER TABLE [cc].[RelProfileItemProfile] CHECK CONSTRAINT [FK__RelProfil__Profi__367C1819]
GO
ALTER TABLE [cc].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_9707ddc40a78ea25243c15632ae] FOREIGN KEY([CastingCafeCustomerAuthorId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[Reviews] CHECK CONSTRAINT [FK_9707ddc40a78ea25243c15632ae]
GO
ALTER TABLE [cc].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_ed002834b7096a5694dd005532e] FOREIGN KEY([CastingCafeCustomerTargetId])
REFERENCES [cc].[CastingCafeCustomer] ([Id])
GO
ALTER TABLE [cc].[Reviews] CHECK CONSTRAINT [FK_ed002834b7096a5694dd005532e]
GO
ALTER TABLE [cc].[ServiceTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_23fe9484ee5920410d380fc6dae] FOREIGN KEY([ServiceTypeId])
REFERENCES [cc].[ServiceType] ([Id])
GO
ALTER TABLE [cc].[ServiceTypeLocal] CHECK CONSTRAINT [FK_23fe9484ee5920410d380fc6dae]
GO
ALTER TABLE [cc].[ServiceTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_80575194c4f9b13ad5bc27bf9ef] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
GO
ALTER TABLE [cc].[ServiceTypeLocal] CHECK CONSTRAINT [FK_80575194c4f9b13ad5bc27bf9ef]
GO
ALTER TABLE [cms].[BlockLocal]  WITH CHECK ADD  CONSTRAINT [FK_075f4344ddb834eacf1b432c3e5] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[BlockLocal] CHECK CONSTRAINT [FK_075f4344ddb834eacf1b432c3e5]
GO
ALTER TABLE [cms].[BlockLocal]  WITH CHECK ADD  CONSTRAINT [FK_b40f1da44beb09c1897456cfa31] FOREIGN KEY([BlockId])
REFERENCES [cms].[Block] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[BlockLocal] CHECK CONSTRAINT [FK_b40f1da44beb09c1897456cfa31]
GO
ALTER TABLE [cms].[News]  WITH CHECK ADD  CONSTRAINT [FK_d662780411f8d9092e0698e55b9] FOREIGN KEY([TermId])
REFERENCES [cms].[Term] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[News] CHECK CONSTRAINT [FK_d662780411f8d9092e0698e55b9]
GO
ALTER TABLE [cms].[NewsLocal]  WITH CHECK ADD  CONSTRAINT [FK_63334414e0ba67dd33056105980] FOREIGN KEY([NewsId])
REFERENCES [cms].[News] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[NewsLocal] CHECK CONSTRAINT [FK_63334414e0ba67dd33056105980]
GO
ALTER TABLE [cms].[NewsLocal]  WITH CHECK ADD  CONSTRAINT [FK_a0613dc4c2b9716be16ba94149a] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[NewsLocal] CHECK CONSTRAINT [FK_a0613dc4c2b9716be16ba94149a]
GO
ALTER TABLE [cms].[PageLocal]  WITH CHECK ADD  CONSTRAINT [FK_942e8ce44ffad65e5fda47e3768] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[PageLocal] CHECK CONSTRAINT [FK_942e8ce44ffad65e5fda47e3768]
GO
ALTER TABLE [cms].[PageLocal]  WITH CHECK ADD  CONSTRAINT [FK_dd2a9044d80b9df75abf18e64a0] FOREIGN KEY([PageId])
REFERENCES [cms].[Page] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[PageLocal] CHECK CONSTRAINT [FK_dd2a9044d80b9df75abf18e64a0]
GO
ALTER TABLE [cms].[SliderItemLocal]  WITH CHECK ADD  CONSTRAINT [FK_661c13047a3bcf08084c42151a3] FOREIGN KEY([SliderItemId])
REFERENCES [cms].[SliderItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[SliderItemLocal] CHECK CONSTRAINT [FK_661c13047a3bcf08084c42151a3]
GO
ALTER TABLE [cms].[SliderItemLocal]  WITH CHECK ADD  CONSTRAINT [FK_daf3c414ba989a05a9dcd2738d5] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[SliderItemLocal] CHECK CONSTRAINT [FK_daf3c414ba989a05a9dcd2738d5]
GO
ALTER TABLE [cms].[TermLocal]  WITH CHECK ADD  CONSTRAINT [FK_5da9c644a1886e068c8d311eb90] FOREIGN KEY([TermId])
REFERENCES [cms].[Term] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[TermLocal] CHECK CONSTRAINT [FK_5da9c644a1886e068c8d311eb90]
GO
ALTER TABLE [cms].[TermLocal]  WITH CHECK ADD  CONSTRAINT [FK_8339130465a9a46feb0dfc24d48] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[TermLocal] CHECK CONSTRAINT [FK_8339130465a9a46feb0dfc24d48]
GO
ALTER TABLE [cms].[TextTemplateLocal]  WITH CHECK ADD  CONSTRAINT [FK_33faee44cd0a9197da10626ee82] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[TextTemplateLocal] CHECK CONSTRAINT [FK_33faee44cd0a9197da10626ee82]
GO
ALTER TABLE [cms].[TextTemplateLocal]  WITH CHECK ADD  CONSTRAINT [FK_b7127584222a9f2fa38ef36b840] FOREIGN KEY([TextTemplateId])
REFERENCES [cms].[TextTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cms].[TextTemplateLocal] CHECK CONSTRAINT [FK_b7127584222a9f2fa38ef36b840]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK__AspNetUse__UserI__1CBC4616] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK__AspNetUse__UserI__1CBC4616]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK__AspNetUse__UserI__1DB06A4F] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK__AspNetUse__UserI__1DB06A4F]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK__AspNetUse__RoleI__1EA48E88] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK__AspNetUse__RoleI__1EA48E88]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK__AspNetUse__UserI__1F98B2C1] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK__AspNetUse__UserI__1F98B2C1]
GO
ALTER TABLE [dbo].[BlockLocal]  WITH CHECK ADD  CONSTRAINT [FK_BlockLocal_Block] FOREIGN KEY([BlockId])
REFERENCES [dbo].[Block] ([Id])
GO
ALTER TABLE [dbo].[BlockLocal] CHECK CONSTRAINT [FK_BlockLocal_Block]
GO
ALTER TABLE [dbo].[BlockLocal]  WITH CHECK ADD  CONSTRAINT [FK_BlockLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[BlockLocal] CHECK CONSTRAINT [FK_BlockLocal_Language]
GO
ALTER TABLE [dbo].[CityLocal]  WITH CHECK ADD  CONSTRAINT [FK_CityLocal_City1] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CityLocal] CHECK CONSTRAINT [FK_CityLocal_City1]
GO
ALTER TABLE [dbo].[CityLocal]  WITH CHECK ADD  CONSTRAINT [FK_CityLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CityLocal] CHECK CONSTRAINT [FK_CityLocal_Language]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Currency]
GO
ALTER TABLE [dbo].[CountryLocal]  WITH CHECK ADD  CONSTRAINT [FK_CountryLocal_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[CountryLocal] CHECK CONSTRAINT [FK_CountryLocal_Country]
GO
ALTER TABLE [dbo].[CountryLocal]  WITH CHECK ADD  CONSTRAINT [FK_CountryLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CountryLocal] CHECK CONSTRAINT [FK_CountryLocal_Language]
GO
ALTER TABLE [dbo].[CreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CreditPack_EntityStatus] FOREIGN KEY([EntityStatusId])
REFERENCES [dbo].[EntityStatus] ([Id])
GO
ALTER TABLE [dbo].[CreditPack] CHECK CONSTRAINT [FK_CreditPack_EntityStatus]
GO
ALTER TABLE [dbo].[CreditPackLocal]  WITH CHECK ADD  CONSTRAINT [FK_CreditPackLocal_CreditPack] FOREIGN KEY([CreditPackId])
REFERENCES [dbo].[CreditPack] ([Id])
GO
ALTER TABLE [dbo].[CreditPackLocal] CHECK CONSTRAINT [FK_CreditPackLocal_CreditPack]
GO
ALTER TABLE [dbo].[CreditPackLocal]  WITH CHECK ADD  CONSTRAINT [FK_CreditPackLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CreditPackLocal] CHECK CONSTRAINT [FK_CreditPackLocal_Language]
GO
ALTER TABLE [dbo].[CurrencyLocal]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyLocal_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CurrencyLocal] CHECK CONSTRAINT [FK_CurrencyLocal_Currency]
GO
ALTER TABLE [dbo].[CurrencyLocal]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CurrencyLocal] CHECK CONSTRAINT [FK_CurrencyLocal_Language]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_AspNetUsers]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Customer] FOREIGN KEY([Id])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Customer]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerEventSetup] FOREIGN KEY([CustomerEventSetupId])
REFERENCES [dbo].[CustomerEventSetup] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_CustomerEventSetup]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerRole] FOREIGN KEY([MainRoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_CustomerRole]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_CustomerSubscription] FOREIGN KEY([CustomerSubscriptionId])
REFERENCES [dbo].[CustomerSubscription] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_CustomerSubscription]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Organization] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Organization]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_City] FOREIGN KEY([BillingCityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_City]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_Country] FOREIGN KEY([BillingCountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_Country]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_CreditPack] FOREIGN KEY([CreditPackId])
REFERENCES [dbo].[CreditPack] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_CreditPack]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_Currency]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_Customer]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_CustomerSubscription] FOREIGN KEY([CustomerSubscriptionId])
REFERENCES [dbo].[CustomerSubscription] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_CustomerSubscription]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_GlobalPromocode] FOREIGN KEY([PromoCodeId])
REFERENCES [dbo].[GlobalPromocode] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_GlobalPromocode]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_OrderLineStatus] FOREIGN KEY([OrderLineStatusId])
REFERENCES [dbo].[OrderLineStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_OrderLineStatus]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_OrderPaymentMode] FOREIGN KEY([OrderPaymentModeId])
REFERENCES [dbo].[OrderPaymentMode] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_OrderPaymentMode]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_OrderStatus]
GO
ALTER TABLE [dbo].[CustomerCreditPack]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCreditPack_PaymentType] FOREIGN KEY([PaymentTypeId])
REFERENCES [dbo].[PaymentType] ([Id])
GO
ALTER TABLE [dbo].[CustomerCreditPack] CHECK CONSTRAINT [FK_CustomerCreditPack_PaymentType]
GO
ALTER TABLE [dbo].[CustomerEvent]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEvent_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CustomerEvent] CHECK CONSTRAINT [FK_CustomerEvent_City]
GO
ALTER TABLE [dbo].[CustomerEvent]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEvent_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[CustomerEvent] CHECK CONSTRAINT [FK_CustomerEvent_Country]
GO
ALTER TABLE [dbo].[CustomerEvent]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEvent_CustomerEvent] FOREIGN KEY([CustomerEventSetupId])
REFERENCES [dbo].[CustomerEventSetup] ([Id])
GO
ALTER TABLE [dbo].[CustomerEvent] CHECK CONSTRAINT [FK_CustomerEvent_CustomerEvent]
GO
ALTER TABLE [dbo].[CustomerEvent]  WITH CHECK ADD  CONSTRAINT [FK_EventStatus] FOREIGN KEY([EventStatusId])
REFERENCES [dbo].[CustomerEventStatus] ([id])
GO
ALTER TABLE [dbo].[CustomerEvent] CHECK CONSTRAINT [FK_EventStatus]
GO
ALTER TABLE [dbo].[CustomerEventParticipation]  WITH CHECK ADD  CONSTRAINT [FK_customerEventParticipation_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[CustomerEventParticipation] CHECK CONSTRAINT [FK_customerEventParticipation_Customer]
GO
ALTER TABLE [dbo].[CustomerEventParticipation]  WITH CHECK ADD  CONSTRAINT [FK_customerEventParticipation_CustomerEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[CustomerEvent] ([Id])
GO
ALTER TABLE [dbo].[CustomerEventParticipation] CHECK CONSTRAINT [FK_customerEventParticipation_CustomerEvent]
GO
ALTER TABLE [dbo].[CustomerEventParticipationCriteria]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEventParticipationCriteria_CustomerEvent] FOREIGN KEY([EventId])
REFERENCES [dbo].[CustomerEvent] ([Id])
GO
ALTER TABLE [dbo].[CustomerEventParticipationCriteria] CHECK CONSTRAINT [FK_CustomerEventParticipationCriteria_CustomerEvent]
GO
ALTER TABLE [dbo].[CustomerEventTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEventTypeLocal_CustomerEventType] FOREIGN KEY([CustomerEventTypeId])
REFERENCES [dbo].[CustomerEventType] ([Id])
GO
ALTER TABLE [dbo].[CustomerEventTypeLocal] CHECK CONSTRAINT [FK_CustomerEventTypeLocal_CustomerEventType]
GO
ALTER TABLE [dbo].[CustomerEventTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerEventTypeLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CustomerEventTypeLocal] CHECK CONSTRAINT [FK_CustomerEventTypeLocal_Language]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_City] FOREIGN KEY([BillingCityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_City]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_Country] FOREIGN KEY([BillingCountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_Country]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_Currency]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_Customer] FOREIGN KEY([OrderLineStatusId])
REFERENCES [dbo].[OrderLineStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_Customer]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_Customer1] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_Customer1]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_CustomerFunctionality] FOREIGN KEY([Id])
REFERENCES [dbo].[CustomerFunctionality] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_CustomerFunctionality]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_CustomerFunctionality1] FOREIGN KEY([Id])
REFERENCES [dbo].[CustomerFunctionality] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_CustomerFunctionality1]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_CustomerSubscription] FOREIGN KEY([CustomerSubscriptionId])
REFERENCES [dbo].[CustomerSubscription] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_CustomerSubscription]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_Functionality] FOREIGN KEY([FunctionalityId])
REFERENCES [dbo].[Functionality] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_Functionality]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_GlobalPromocode] FOREIGN KEY([PromoCodeId])
REFERENCES [dbo].[GlobalPromocode] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_GlobalPromocode]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_OrderPaymentMode] FOREIGN KEY([OrderPaymentModeId])
REFERENCES [dbo].[OrderPaymentMode] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_OrderPaymentMode]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_OrderStatus]
GO
ALTER TABLE [dbo].[CustomerFunctionality]  WITH CHECK ADD  CONSTRAINT [FK_CustomerFunctionality_PaymentType] FOREIGN KEY([PaymentTypeId])
REFERENCES [dbo].[PaymentType] ([Id])
GO
ALTER TABLE [dbo].[CustomerFunctionality] CHECK CONSTRAINT [FK_CustomerFunctionality_PaymentType]
GO
ALTER TABLE [dbo].[CustomerRoleLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRoleLocal_CustomerRole] FOREIGN KEY([CustomerRoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
GO
ALTER TABLE [dbo].[CustomerRoleLocal] CHECK CONSTRAINT [FK_CustomerRoleLocal_CustomerRole]
GO
ALTER TABLE [dbo].[CustomerRoleLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRoleLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CustomerRoleLocal] CHECK CONSTRAINT [FK_CustomerRoleLocal_Language]
GO
ALTER TABLE [dbo].[CustomerRoleTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerRoleTypeLocal_CustomerRoleType] FOREIGN KEY([CustomerRoleTypeId])
REFERENCES [dbo].[CustomerRoleType] ([Id])
GO
ALTER TABLE [dbo].[CustomerRoleTypeLocal] CHECK CONSTRAINT [FK_CustomerRoleTypeLocal_CustomerRoleType]
GO
ALTER TABLE [dbo].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_CustomerService_City] FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CustomerService] CHECK CONSTRAINT [FK_CustomerService_City]
GO
ALTER TABLE [dbo].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_CustomerService_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[CustomerService] CHECK CONSTRAINT [FK_CustomerService_Customer]
GO
ALTER TABLE [dbo].[CustomerService]  WITH CHECK ADD  CONSTRAINT [FK_CustomerService_ServiceType] FOREIGN KEY([ServiceTypeId])
REFERENCES [dbo].[ServiceType] ([Id])
GO
ALTER TABLE [dbo].[CustomerService] CHECK CONSTRAINT [FK_CustomerService_ServiceType]
GO
ALTER TABLE [dbo].[CustomerStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerStatusLocal_CustomerStatus] FOREIGN KEY([CustomerStatusId])
REFERENCES [dbo].[CustomerStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerStatusLocal] CHECK CONSTRAINT [FK_CustomerStatusLocal_CustomerStatus]
GO
ALTER TABLE [dbo].[CustomerStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_CustomerStatusLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[CustomerStatusLocal] CHECK CONSTRAINT [FK_CustomerStatusLocal_Language]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_City] FOREIGN KEY([BillingCityId])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_City]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_Country] FOREIGN KEY([BillingCountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_Country]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_Currency]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_CustomerSubscription] FOREIGN KEY([Id])
REFERENCES [dbo].[CustomerSubscription] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_CustomerSubscription]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_GlobalPromocode] FOREIGN KEY([PromoCodeId])
REFERENCES [dbo].[GlobalPromocode] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_GlobalPromocode]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_OrderLineStatus] FOREIGN KEY([OrderLineStatusId])
REFERENCES [dbo].[OrderLineStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_OrderLineStatus]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_OrderPaymentMode] FOREIGN KEY([OrderPaymentModeId])
REFERENCES [dbo].[OrderPaymentMode] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_OrderPaymentMode]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_OrderStatus]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_PaymentType] FOREIGN KEY([PaymentTypeId])
REFERENCES [dbo].[PaymentType] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_PaymentType]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_Periodicity] FOREIGN KEY([PeriodicityId])
REFERENCES [dbo].[Periodicity] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_Periodicity]
GO
ALTER TABLE [dbo].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([Id])
GO
ALTER TABLE [dbo].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_Subscription]
GO
ALTER TABLE [dbo].[DiscountTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_DiscountTypeLocal_CustomerRoleType] FOREIGN KEY([DiscountTypeId])
REFERENCES [dbo].[DiscountType] ([Id])
GO
ALTER TABLE [dbo].[DiscountTypeLocal] CHECK CONSTRAINT [FK_DiscountTypeLocal_CustomerRoleType]
GO
ALTER TABLE [dbo].[DomainLocal]  WITH CHECK ADD  CONSTRAINT [FK_DomainLocal_Domain] FOREIGN KEY([DomainId])
REFERENCES [dbo].[Domain] ([Id])
GO
ALTER TABLE [dbo].[DomainLocal] CHECK CONSTRAINT [FK_DomainLocal_Domain]
GO
ALTER TABLE [dbo].[DomainLocal]  WITH CHECK ADD  CONSTRAINT [FK_DomainLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[DomainLocal] CHECK CONSTRAINT [FK_DomainLocal_Language]
GO
ALTER TABLE [dbo].[EntityStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_EntityStatusLocal_EntityStatus] FOREIGN KEY([EntityStatusId])
REFERENCES [dbo].[EntityStatus] ([Id])
GO
ALTER TABLE [dbo].[EntityStatusLocal] CHECK CONSTRAINT [FK_EntityStatusLocal_EntityStatus]
GO
ALTER TABLE [dbo].[EntityStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_EntityStatusLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[EntityStatusLocal] CHECK CONSTRAINT [FK_EntityStatusLocal_Language]
GO
ALTER TABLE [dbo].[FriendlyURL]  WITH CHECK ADD  CONSTRAINT [FK_FriendlyURL_Culture] FOREIGN KEY([CultureId])
REFERENCES [dbo].[Culture] ([Id])
GO
ALTER TABLE [dbo].[FriendlyURL] CHECK CONSTRAINT [FK_FriendlyURL_Culture]
GO
ALTER TABLE [dbo].[Functionality]  WITH CHECK ADD  CONSTRAINT [FK_Functionality_EntityStatus] FOREIGN KEY([EntityStatusId])
REFERENCES [dbo].[EntityStatus] ([Id])
GO
ALTER TABLE [dbo].[Functionality] CHECK CONSTRAINT [FK_Functionality_EntityStatus]
GO
ALTER TABLE [dbo].[FunctionalityLocal]  WITH CHECK ADD  CONSTRAINT [FK_FunctionalityLocal_Functionality] FOREIGN KEY([FunctionalityId])
REFERENCES [dbo].[Functionality] ([Id])
GO
ALTER TABLE [dbo].[FunctionalityLocal] CHECK CONSTRAINT [FK_FunctionalityLocal_Functionality]
GO
ALTER TABLE [dbo].[FunctionalityLocal]  WITH CHECK ADD  CONSTRAINT [FK_FunctionalityLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[FunctionalityLocal] CHECK CONSTRAINT [FK_FunctionalityLocal_Language]
GO
ALTER TABLE [dbo].[GlobalPromocode]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_CustomerRoleType] FOREIGN KEY([CustomerRoleTypeId])
REFERENCES [dbo].[CustomerRoleType] ([Id])
GO
ALTER TABLE [dbo].[GlobalPromocode] CHECK CONSTRAINT [FK_GlobalPromocode_CustomerRoleType]
GO
ALTER TABLE [dbo].[GlobalPromocode]  WITH CHECK ADD  CONSTRAINT [FK_GlobalPromocode_DiscountType] FOREIGN KEY([DiscountTypeId])
REFERENCES [dbo].[DiscountType] ([Id])
GO
ALTER TABLE [dbo].[GlobalPromocode] CHECK CONSTRAINT [FK_GlobalPromocode_DiscountType]
GO
ALTER TABLE [dbo].[LegalStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_LegalStatusLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[LegalStatusLocal] CHECK CONSTRAINT [FK_LegalStatusLocal_Language]
GO
ALTER TABLE [dbo].[LegalStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_LegalStatusLocal_LegalStatus] FOREIGN KEY([LegalStatusId])
REFERENCES [dbo].[LegalStatus] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LegalStatusLocal] CHECK CONSTRAINT [FK_LegalStatusLocal_LegalStatus]
GO
ALTER TABLE [dbo].[MediaTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_MediaTypeLocal_MediaType] FOREIGN KEY([MediaTypeId])
REFERENCES [dbo].[MediaType] ([Id])
GO
ALTER TABLE [dbo].[MediaTypeLocal] CHECK CONSTRAINT [FK_MediaTypeLocal_MediaType]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_LogItemId] FOREIGN KEY([LogItemId])
REFERENCES [dbo].[LogItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_LogItemId]
GO
ALTER TABLE [dbo].[OrderLineStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineStatusLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[OrderLineStatusLocal] CHECK CONSTRAINT [FK_OrderLineStatusLocal_Language]
GO
ALTER TABLE [dbo].[OrderLineStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineStatusLocal_OrderLineStatus] FOREIGN KEY([OrderLineStatusId])
REFERENCES [dbo].[OrderLineStatus] ([Id])
GO
ALTER TABLE [dbo].[OrderLineStatusLocal] CHECK CONSTRAINT [FK_OrderLineStatusLocal_OrderLineStatus]
GO
ALTER TABLE [dbo].[OrderPaymentModeLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderPaymentModeLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[OrderPaymentModeLocal] CHECK CONSTRAINT [FK_OrderPaymentModeLocal_Language]
GO
ALTER TABLE [dbo].[OrderPaymentModeLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderPaymentModeLocal_OrderPaymentMode] FOREIGN KEY([OrderPaymentModeId])
REFERENCES [dbo].[OrderPaymentMode] ([Id])
GO
ALTER TABLE [dbo].[OrderPaymentModeLocal] CHECK CONSTRAINT [FK_OrderPaymentModeLocal_OrderPaymentMode]
GO
ALTER TABLE [dbo].[OrderStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderStatusLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[OrderStatusLocal] CHECK CONSTRAINT [FK_OrderStatusLocal_Language]
GO
ALTER TABLE [dbo].[OrderStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_OrderStatusLocal_OrderStatus] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([Id])
GO
ALTER TABLE [dbo].[OrderStatusLocal] CHECK CONSTRAINT [FK_OrderStatusLocal_OrderStatus]
GO
ALTER TABLE [dbo].[PageLocal]  WITH CHECK ADD  CONSTRAINT [FK_PageLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[PageLocal] CHECK CONSTRAINT [FK_PageLocal_Language]
GO
ALTER TABLE [dbo].[PageLocal]  WITH CHECK ADD  CONSTRAINT [FK_PageLocal_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[PageLocal] CHECK CONSTRAINT [FK_PageLocal_Page]
GO
ALTER TABLE [dbo].[PaymentTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_PaymentType_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[PaymentTypeLocal] CHECK CONSTRAINT [FK_PaymentType_Language]
GO
ALTER TABLE [dbo].[PaymentTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTypeLocal_PaymentType] FOREIGN KEY([PaymentTypeId])
REFERENCES [dbo].[PaymentType] ([Id])
GO
ALTER TABLE [dbo].[PaymentTypeLocal] CHECK CONSTRAINT [FK_PaymentTypeLocal_PaymentType]
GO
ALTER TABLE [dbo].[PeriodicityLocal]  WITH CHECK ADD  CONSTRAINT [FK_PeriodicityLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[PeriodicityLocal] CHECK CONSTRAINT [FK_PeriodicityLocal_Language]
GO
ALTER TABLE [dbo].[PeriodicityLocal]  WITH CHECK ADD  CONSTRAINT [FK_PeriodicityLocal_Periodicity] FOREIGN KEY([PeriodicityId])
REFERENCES [dbo].[Periodicity] ([Id])
GO
ALTER TABLE [dbo].[PeriodicityLocal] CHECK CONSTRAINT [FK_PeriodicityLocal_Periodicity]
GO
ALTER TABLE [dbo].[Portfolios]  WITH CHECK ADD  CONSTRAINT [FK_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Portfolios] CHECK CONSTRAINT [FK_Customer]
GO
ALTER TABLE [dbo].[Portfolios]  WITH CHECK ADD  CONSTRAINT [FK_PortfoliosStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[PortfoliosStatus] ([Id])
GO
ALTER TABLE [dbo].[Portfolios] CHECK CONSTRAINT [FK_PortfoliosStatus]
GO
ALTER TABLE [dbo].[ProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItem_ProfileSection] FOREIGN KEY([ProfileSectionId])
REFERENCES [dbo].[ProfileSection] ([Id])
GO
ALTER TABLE [dbo].[ProfileItem] CHECK CONSTRAINT [FK_ProfileItem_ProfileSection]
GO
ALTER TABLE [dbo].[ProfileItemLocal]  WITH CHECK ADD  CONSTRAINT [FK_ProfileItemLocal_ProfileItem] FOREIGN KEY([ProfileItemId])
REFERENCES [dbo].[ProfileItem] ([Id])
GO
ALTER TABLE [dbo].[ProfileItemLocal] CHECK CONSTRAINT [FK_ProfileItemLocal_ProfileItem]
GO
ALTER TABLE [dbo].[ProfileSectionLocal]  WITH CHECK ADD  CONSTRAINT [FK_ProfileSectionLocal_ProfileSection] FOREIGN KEY([ProfileSectionId])
REFERENCES [dbo].[ProfileSection] ([Id])
GO
ALTER TABLE [dbo].[ProfileSectionLocal] CHECK CONSTRAINT [FK_ProfileSectionLocal_ProfileSection]
GO
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_Customer]
GO
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_MediaType] FOREIGN KEY([MediaTypeId])
REFERENCES [dbo].[MediaType] ([Id])
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_MediaType]
GO
ALTER TABLE [dbo].[Publication]  WITH CHECK ADD  CONSTRAINT [FK_Publication_PublicationStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[PublicationStatus] ([Id])
GO
ALTER TABLE [dbo].[Publication] CHECK CONSTRAINT [FK_Publication_PublicationStatus]
GO
ALTER TABLE [dbo].[PublicationStatusLocal]  WITH CHECK ADD  CONSTRAINT [FK_PublicationStatusLocal_PublicationStatus] FOREIGN KEY([PublicationStatusId])
REFERENCES [dbo].[PublicationStatus] ([Id])
GO
ALTER TABLE [dbo].[PublicationStatusLocal] CHECK CONSTRAINT [FK_PublicationStatusLocal_PublicationStatus]
GO
ALTER TABLE [dbo].[RelCustomerCustomerRole]  WITH CHECK ADD  CONSTRAINT [FK_RelCustomerCustomerRole_CustomerRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
GO
ALTER TABLE [dbo].[RelCustomerCustomerRole] CHECK CONSTRAINT [FK_RelCustomerCustomerRole_CustomerRole]
GO
ALTER TABLE [dbo].[RelProfileItemProfileSection]  WITH CHECK ADD  CONSTRAINT [FK_RelProfileItemProfileSection_ProfileItem] FOREIGN KEY([ProfileItemId])
REFERENCES [dbo].[ProfileItem] ([Id])
GO
ALTER TABLE [dbo].[RelProfileItemProfileSection] CHECK CONSTRAINT [FK_RelProfileItemProfileSection_ProfileItem]
GO
ALTER TABLE [dbo].[RelProfileItemProfileSection]  WITH CHECK ADD  CONSTRAINT [FK_RelProfileItemProfileSection_ProfileSection] FOREIGN KEY([ProfileSection])
REFERENCES [dbo].[ProfileSection] ([Id])
GO
ALTER TABLE [dbo].[RelProfileItemProfileSection] CHECK CONSTRAINT [FK_RelProfileItemProfileSection_ProfileSection]
GO
ALTER TABLE [dbo].[RelProfileSectionCustomerRole]  WITH CHECK ADD  CONSTRAINT [FK_RelProfileSectionCustomerRole_CustomerRole] FOREIGN KEY([CustomerRoleId])
REFERENCES [dbo].[CustomerRole] ([Id])
GO
ALTER TABLE [dbo].[RelProfileSectionCustomerRole] CHECK CONSTRAINT [FK_RelProfileSectionCustomerRole_CustomerRole]
GO
ALTER TABLE [dbo].[RelProfileSectionCustomerRole]  WITH CHECK ADD  CONSTRAINT [FK_RelProfileSectionCustomerRole_ProfileSection] FOREIGN KEY([ProfilesSectionId])
REFERENCES [dbo].[ProfileSection] ([Id])
GO
ALTER TABLE [dbo].[RelProfileSectionCustomerRole] CHECK CONSTRAINT [FK_RelProfileSectionCustomerRole_ProfileSection]
GO
ALTER TABLE [dbo].[RelSubscriptionProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_RelSubscriptionProfileItem_ProfileItem] FOREIGN KEY([ProfileItemId])
REFERENCES [dbo].[ProfileItem] ([Id])
GO
ALTER TABLE [dbo].[RelSubscriptionProfileItem] CHECK CONSTRAINT [FK_RelSubscriptionProfileItem_ProfileItem]
GO
ALTER TABLE [dbo].[RelSubscriptionProfileItem]  WITH CHECK ADD  CONSTRAINT [FK_RelSubscriptionProfileItem_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([Id])
GO
ALTER TABLE [dbo].[RelSubscriptionProfileItem] CHECK CONSTRAINT [FK_RelSubscriptionProfileItem_Subscription]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_RecipientCustomer] FOREIGN KEY([RecipientCustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_RecipientCustomer]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_ReviewStatus] FOREIGN KEY([ReviewStatusId])
REFERENCES [dbo].[ReviewStatus] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_ReviewStatus]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_SenderCustomer] FOREIGN KEY([SenderCustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_SenderCustomer]
GO
ALTER TABLE [dbo].[ServiceTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_ServiceTypeLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[ServiceTypeLocal] CHECK CONSTRAINT [FK_ServiceTypeLocal_Language]
GO
ALTER TABLE [dbo].[ServiceTypeLocal]  WITH CHECK ADD  CONSTRAINT [FK_ServiceTypeLocal_ServiceType] FOREIGN KEY([ServiceTypeId])
REFERENCES [dbo].[ServiceType] ([Id])
GO
ALTER TABLE [dbo].[ServiceTypeLocal] CHECK CONSTRAINT [FK_ServiceTypeLocal_ServiceType]
GO
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_State_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Country]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_EntityStatus] FOREIGN KEY([EntityStatusId])
REFERENCES [dbo].[EntityStatus] ([Id])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_EntityStatus]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Periodicity] FOREIGN KEY([PeriodicityId])
REFERENCES [dbo].[Periodicity] ([Id])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Periodicity]
GO
ALTER TABLE [dbo].[SubscriptionLocal]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionLocal_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([Code])
GO
ALTER TABLE [dbo].[SubscriptionLocal] CHECK CONSTRAINT [FK_SubscriptionLocal_Language]
GO
ALTER TABLE [dbo].[SubscriptionLocal]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionLocal_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionLocal] CHECK CONSTRAINT [FK_SubscriptionLocal_Subscription]
GO
ALTER TABLE [eit].[EITCity]  WITH NOCHECK ADD  CONSTRAINT [FK_1e140e0453098b031582c6abe1c] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
GO
ALTER TABLE [eit].[EITCity] CHECK CONSTRAINT [FK_1e140e0453098b031582c6abe1c]
GO
ALTER TABLE [eit].[EITCity]  WITH NOCHECK ADD  CONSTRAINT [FK_7c64c4b43bcba384d7eb64125ba] FOREIGN KEY([EITStateId])
REFERENCES [eit].[EITState] ([Id])
GO
ALTER TABLE [eit].[EITCity] CHECK CONSTRAINT [FK_7c64c4b43bcba384d7eb64125ba]
GO
ALTER TABLE [eit].[EITCityLocal]  WITH NOCHECK ADD  CONSTRAINT [FK_af797c74dc09dc7ab56a499292c] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCityLocal] CHECK CONSTRAINT [FK_af797c74dc09dc7ab56a499292c]
GO
ALTER TABLE [eit].[EITCityLocal]  WITH NOCHECK ADD  CONSTRAINT [FK_e326b28482f9c4af3c1f791a037] FOREIGN KEY([EITCityId])
REFERENCES [eit].[EITCity] ([Id])
GO
ALTER TABLE [eit].[EITCityLocal] CHECK CONSTRAINT [FK_e326b28482f9c4af3c1f791a037]
GO
ALTER TABLE [eit].[EITCountry]  WITH CHECK ADD  CONSTRAINT [FK_4ca99e84b3a86e2f72c154ccf2e] FOREIGN KEY([EITCurrencyId])
REFERENCES [eit].[EITCurrency] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCountry] CHECK CONSTRAINT [FK_4ca99e84b3a86e2f72c154ccf2e]
GO
ALTER TABLE [eit].[EITCountryLocal]  WITH CHECK ADD  CONSTRAINT [FK_1b637af4388a0bc8bc02d22e58b] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCountryLocal] CHECK CONSTRAINT [FK_1b637af4388a0bc8bc02d22e58b]
GO
ALTER TABLE [eit].[EITCountryLocal]  WITH CHECK ADD  CONSTRAINT [FK_e5f0ef943bba5f3c729ea7c5959] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCountryLocal] CHECK CONSTRAINT [FK_e5f0ef943bba5f3c729ea7c5959]
GO
ALTER TABLE [eit].[EITCulture]  WITH CHECK ADD  CONSTRAINT [FK_cc088e64f6aaf6a4c8ffd71aeb8] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [eit].[EITCulture] CHECK CONSTRAINT [FK_cc088e64f6aaf6a4c8ffd71aeb8]
GO
ALTER TABLE [eit].[EITCurrencyLocal]  WITH CHECK ADD  CONSTRAINT [FK_569b8004eb69de459d1838bae1a] FOREIGN KEY([EITCurrencyId])
REFERENCES [eit].[EITCurrency] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCurrencyLocal] CHECK CONSTRAINT [FK_569b8004eb69de459d1838bae1a]
GO
ALTER TABLE [eit].[EITCurrencyLocal]  WITH CHECK ADD  CONSTRAINT [FK_b5ba9e24a20b896355c1b279cd2] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITCurrencyLocal] CHECK CONSTRAINT [FK_b5ba9e24a20b896355c1b279cd2]
GO
ALTER TABLE [eit].[EITNotification]  WITH CHECK ADD  CONSTRAINT [FK_c77129648a990e0a8f5a0f6102d] FOREIGN KEY([EITLogItemId])
REFERENCES [eit].[EITLogItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITNotification] CHECK CONSTRAINT [FK_c77129648a990e0a8f5a0f6102d]
GO
ALTER TABLE [eit].[EITState]  WITH CHECK ADD  CONSTRAINT [FK_344a51d47518f8efab74a0f67be] FOREIGN KEY([EITCountryId])
REFERENCES [eit].[EITCountry] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITState] CHECK CONSTRAINT [FK_344a51d47518f8efab74a0f67be]
GO
ALTER TABLE [eit].[EITStateLocal]  WITH CHECK ADD  CONSTRAINT [FK_305648d43a1a3428af92d97b4a8] FOREIGN KEY([EITStateId])
REFERENCES [eit].[EITState] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITStateLocal] CHECK CONSTRAINT [FK_305648d43a1a3428af92d97b4a8]
GO
ALTER TABLE [eit].[EITStateLocal]  WITH CHECK ADD  CONSTRAINT [FK_d0d4ad446a8a4f576084480f644] FOREIGN KEY([EITCultureId])
REFERENCES [eit].[EITCulture] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [eit].[EITStateLocal] CHECK CONSTRAINT [FK_d0d4ad446a8a4f576084480f644]
GO
ALTER TABLE [dbo].[Editor]  WITH CHECK ADD  CONSTRAINT [CST_Editor_Setup] CHECK  ((isjson([Setup])>(0)))
GO
ALTER TABLE [dbo].[Editor] CHECK CONSTRAINT [CST_Editor_Setup]
GO
/****** Object:  StoredProcedure [cc].[GeneralSearch]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [cc].[GeneralSearch]
	@currentCultureId INT,
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@offset INT,
	@limit INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	CREATE TABLE #ids(id int not null); -- temp table because potentially lots of results
	
	INSERT INTO #ids
	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
	CROSS APPLY (
		SELECT i.id
		FROM @ints i
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
	) AS IntCriteriaId
	LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
	CROSS APPLY (
		SELECT b.id
		FROM @bits b
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
	) AS BooleanCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	AND (cust.ValidUntil IS NULL OR cust.ValidUntil >= @now)
	GROUP BY cust.Id
	OPTION (RECOMPILE);

	CREATE NONCLUSTERED INDEX IX_Id ON #ids(id);

	DECLARE @pagedIds TABLE( -- table variable because never more than @limit (20-30) results
		Id INT NOT NULL PRIMARY KEY CLUSTERED,
		[Status] INT NOT NULL,
		Avatar VARCHAR(100) NULL,
		ProfessionalName VARCHAR(50) NULL,
		PersonId INT NULL,
		PersonGender INT NULL,
		PersonFirstName VARCHAR(50) NULL,
		PersonLastName VARCHAR(50) NULL,
		OrgId INT NULL,
		OrgName VARCHAR(50) NULL,
		OrgContactFirstName VARCHAR(50) NULL,
		OrgContactLastName VARCHAR(50) NULL,
		[Url] VARCHAR(255) NOT NULL,
		RoleType INT NOT NULL,
		RoleTitle VARCHAR(30) NULL,
		Rating INT NOT NULL,
		CityLabel VARCHAR(60) NULL,
		CountryName VARCHAR(30) NULL
	);
	INSERT INTO @pagedIds
	SELECT
		v.Id,
		c.CustomerStatus as [Status],
		v.Avatar,
		v.ProfessionalName,
		v.PersonId,
		v.PersonGender,
		v.PersonFirstName,
		v.PersonLastName,
		v.OrgId,
		v.OrgName,
		v.OrgContactFirstName,
		v.OrgContactLastName,
		v.[Url],
		r.RoleType,
		rl.Title AS RoleTitle,
		c.Rating,
		city.Label AS CityLabel,
		country.[Name] AS CountryName
	FROM cc.CustomerDisplayView v
	JOIN cc.CastingCafeCustomer c ON v.Id = c.Id
	JOIN cc.CastingCafeRole r ON c.CastingCafeRoleId = r.Id
	JOIN cc.CastingCafeRoleLocal rl ON r.Id = rl.CastingCafeRoleId
	LEFT JOIN eit.EITCity city on c.EITCityId = city.Id
	JOIN eit.EITCountryLocal country on c.EITCountryId = country.EITCountryId
	WHERE v.Id in (
		SELECT id FROM #ids
	)
	AND v.UrlCultureId = @currentCultureId
	AND rl.EITCultureId = @currentCultureId
	AND country.EITCultureId = @currentCultureId
	ORDER BY v.Id
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
	OPTION (RECOMPILE);

	SELECT
		Id,
		[Status],
		Avatar,
		ProfessionalName,
		PersonId,
		PersonGender,
		PersonFirstName,
		PersonLastName,
		OrgId,
		OrgName,
		OrgContactFirstName,
		OrgContactLastName,
		[Url],
		RoleType,
		RoleTitle,
		Rating,
		CityLabel,
		CountryName
	FROM @pagedIds;

	SELECT
		Book.CastingCafeCustomerId as CustomerId,
		BookItem.Id as BookItemId,
		Book.Id as BookId,
		Book.[Status] as BookStatus,
		BookItem.MediaType,
		BookItem.MediaValue,
		BookItem.DisplayOrder
	FROM cc.BookItem
	JOIN cc.Book ON BookItem.BookId = Book.Id
	WHERE Book.CastingCafeCustomerId IN (
		SELECT Id from @pagedIds
	)
	OPTION (RECOMPILE);

	RETURN (SELECT COUNT(1) FROM #ids);
END
GO
/****** Object:  StoredProcedure [cc].[GeneralSearchIds]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [cc].[GeneralSearchIds]
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY -- idem
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();
	
	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	CROSS APPLY (
		SELECT ProfileItemValueInt.CastingCafeCustomerId
		FROM @ints i
		LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
		GROUP BY ProfileItemValueInt.CastingCafeCustomerId
		HAVING ProfileItemValueInt.CastingCafeCustomerId IS NULL or COUNT(ProfileItemValueInt.CastingCafeCustomerId) >= (SELECT COUNT(DISTINCT id) FROM @ints)
	) AS IntCriteriaId
	CROSS APPLY (
		SELECT ProfileItemValueBoolean.CastingCafeCustomerId
		FROM @bits b
		LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
		GROUP BY ProfileItemValueBoolean.CastingCafeCustomerId
		HAVING ProfileItemValueBoolean.CastingCafeCustomerId IS NULL OR COUNT(ProfileItemValueBoolean.CastingCafeCustomerId) >= (SELECT COUNT(DISTINCT id) FROM @bits)
	) AS BooleanCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	GROUP BY cust.Id
	OPTION (RECOMPILE);

END
GO
/****** Object:  StoredProcedure [cc].[GeneralSearchV2]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cc].[GeneralSearchV2]
	@currentCultureId INT,
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@offset INT,
	@limit INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	CREATE TABLE #ids(id int not null); -- temp table because potentially lots of results
	
	INSERT INTO #ids
	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
	CROSS APPLY (
		SELECT i.id
		FROM @ints i
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
	) AS IntCriteriaId
	LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
	CROSS APPLY (
		SELECT b.id
		FROM @bits b
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
	) AS BooleanCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	AND (cust.ValidUntil IS NULL OR cust.ValidUntil >= @now)
	GROUP BY cust.Id
	OPTION (RECOMPILE);

	CREATE NONCLUSTERED INDEX IX_Id ON #ids(id);

	DECLARE @pagedIds TABLE( -- table variable because never more than @limit (20-30) results
		Id INT NOT NULL,
		[Status] INT NOT NULL,
		Avatar VARCHAR(100) NULL,
		ProfessionalName VARCHAR(50) NULL,
		PersonId INT NULL,
		PersonGender INT NULL,
		PersonFirstName VARCHAR(50) NULL,
		PersonLastName VARCHAR(50) NULL,		
		PersonBirthDate DATETIME NULL,
		OrgId INT NULL,
		OrgName VARCHAR(50) NULL,
		OrgContactFirstName VARCHAR(50) NULL,
		OrgContactLastName VARCHAR(50) NULL,
		[Url] VARCHAR(255) NOT NULL,
		RoleType INT NOT NULL,
		RoleTitle VARCHAR(30) NULL,
		Rating INT NOT NULL,
		CityLabel VARCHAR(60) NULL,
		CountryName VARCHAR(30) NULL
	);
	INSERT INTO @pagedIds
	SELECT
		v.Id,
		c.CustomerStatus as [Status],
		v.Avatar,
		v.ProfessionalName,
		v.PersonId,
		v.PersonGender,
		v.PersonFirstName,
		v.PersonLastName,
		v.PersonBirthDate,
		v.OrgId,
		v.OrgName,
		v.OrgContactFirstName,
		v.OrgContactLastName,
		v.[Url],
		r.RoleType,
		rl.Title AS RoleTitle,
		c.Rating,
		city.Label AS CityLabel,
		country.[Name] AS CountryName
	FROM cc.CustomerDisplayView v
	JOIN cc.CastingCafeCustomer c ON v.Id = c.Id
	JOIN cc.CastingCafeRole r ON c.CastingCafeRoleId = r.Id
	JOIN cc.CastingCafeRoleLocal rl ON r.Id = rl.CastingCafeRoleId
	LEFT JOIN eit.EITCity city on c.EITCityId = city.Id
	JOIN eit.EITCountryLocal country on c.EITCountryId = country.EITCountryId
	WHERE v.Id in (
		SELECT id FROM #ids
	)
	AND v.UrlCultureId = @currentCultureId
	AND rl.EITCultureId = @currentCultureId
	AND country.EITCultureId = @currentCultureId
	ORDER BY v.Id
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
	OPTION (RECOMPILE);

	SELECT
		Id,
		[Status],
		Avatar,
		ProfessionalName,
		PersonId,
		PersonGender,
		PersonFirstName,
		PersonLastName,
		PersonBirthDate,
		OrgId,
		OrgName,
		OrgContactFirstName,
		OrgContactLastName,
		[Url],
		RoleType,
		RoleTitle,
		Rating,
		CityLabel,
		CountryName
	FROM @pagedIds;

	RETURN (SELECT COUNT(1) FROM #ids);
END
GO
/****** Object:  StoredProcedure [cc].[GeneralSearchV3]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [cc].[GeneralSearchV3]
	@currentCultureId INT,
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@offset INT,
	@limit INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	CREATE TABLE #ids(id int not null); -- temp table because potentially lots of results
	
	INSERT INTO #ids
	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	CROSS APPLY (
		SELECT ProfileItemValueInt.CastingCafeCustomerId
		FROM @ints i
		LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
		GROUP BY ProfileItemValueInt.CastingCafeCustomerId
		HAVING ProfileItemValueInt.CastingCafeCustomerId IS NULL or COUNT(ProfileItemValueInt.CastingCafeCustomerId) >= (SELECT COUNT(DISTINCT id) FROM @ints)
	) AS IntCriteriaId
	CROSS APPLY (
		SELECT ProfileItemValueBoolean.CastingCafeCustomerId
		FROM @bits b
		LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
		GROUP BY ProfileItemValueBoolean.CastingCafeCustomerId
		HAVING ProfileItemValueBoolean.CastingCafeCustomerId IS NULL OR COUNT(ProfileItemValueBoolean.CastingCafeCustomerId) >= (SELECT COUNT(DISTINCT id) FROM @bits)
	) AS BooleanCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	GROUP BY cust.Id
	OPTION (RECOMPILE);

	CREATE NONCLUSTERED INDEX IX_Id ON #ids(id);

	DECLARE @pagedIds TABLE( -- table variable because never more than @limit (20-30) results
		Id INT NOT NULL,
		[Status] INT NOT NULL,
		Avatar VARCHAR(100) NULL,
		ProfessionalName VARCHAR(50) NULL,
		PersonId INT NULL,
		PersonGender INT NULL,
		PersonFirstName VARCHAR(50) NULL,
		PersonLastName VARCHAR(50) NULL,		
		PersonBirthDate DATETIME NULL,
		OrgId INT NULL,
		OrgName VARCHAR(50) NULL,
		OrgContactFirstName VARCHAR(50) NULL,
		OrgContactLastName VARCHAR(50) NULL,
		[Url] VARCHAR(255) NOT NULL,
		RoleType INT NOT NULL,
		RoleTitle VARCHAR(30) NULL,
		Rating INT NOT NULL,
		CityLabel VARCHAR(60) NULL,
		CountryName VARCHAR(30) NULL,
		ValidUntil datetime NULL
	);
	INSERT INTO @pagedIds
	SELECT
		v.Id,
		c.CustomerStatus as [Status],
		v.Avatar,
		v.ProfessionalName,
		v.PersonId,
		v.PersonGender,
		v.PersonFirstName,
		v.PersonLastName,
		v.PersonBirthDate,
		v.OrgId,
		v.OrgName,
		v.OrgContactFirstName,
		v.OrgContactLastName,
		v.[Url],
		r.RoleType,
		rl.Title AS RoleTitle,
		c.Rating,
		city.Label AS CityLabel,
		country.[Name] AS CountryName,
		c.ValidUntil AS ValidUntil
	FROM cc.CustomerDisplayView v
	JOIN cc.CastingCafeCustomer c ON v.Id = c.Id
	JOIN cc.CastingCafeRole r ON c.CastingCafeRoleId = r.Id
	JOIN cc.CastingCafeRoleLocal rl ON r.Id = rl.CastingCafeRoleId
	LEFT JOIN eit.EITCity city on c.EITCityId = city.Id
	JOIN eit.EITCountryLocal country on c.EITCountryId = country.EITCountryId
	WHERE v.Id in (
		SELECT id FROM #ids
	)
	AND v.UrlCultureId = @currentCultureId
	AND rl.EITCultureId = @currentCultureId
	AND country.EITCultureId = @currentCultureId
	ORDER BY
		CASE
			WHEN c.ValidUntil IS NULL OR c.ValidUntil >= @now THEN 1
			ELSE 0
		END DESC,
		ISNULL(c.LastProfileModification, c.EITSvcStampCreatedAt) DESC,
		c.Rating DESC
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
	OPTION (RECOMPILE);

	SELECT
		Id,
		[Status],
		Avatar,
		ProfessionalName,
		PersonId,
		PersonGender,
		PersonFirstName,
		PersonLastName,
		PersonBirthDate,
		OrgId,
		OrgName,
		OrgContactFirstName,
		OrgContactLastName,
		[Url],
		RoleType,
		RoleTitle,
		Rating,
		CityLabel,
		CountryName,
		ValidUntil
	FROM @pagedIds;

	RETURN (SELECT COUNT(1) FROM #ids);
END
GO
/****** Object:  StoredProcedure [cc].[GetCastingRecap]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [cc].[GetCastingRecap]
AS
BEGIN
    SET NOCOUNT ON

	DECLARE @date DATETIME2(0) = SYSDATETIME();

	SELECT Casting.Id AS CastingId,
		   Casting.Title AS CastingTitle,
		   cust.Id AS CustomerId,
		   setup.AlertsEmail,
		   setup.frequency / 24 AS FrequencyDaysCount
	FROM cc.CastingCafeCustomer cust
	JOIN cc.Casting ON casting.CastingCafeCustomerId = cust.Id
	JOIN cc.CastingCalled ON casting.Id = CastingCalled.CastingId
	LEFT JOIN cc.CastingSetup specificSetup ON Casting.CastingSetupId = specificSetup.Id
	LEFT JOIN cc.CastingSetup custSetup ON cust.CastingSetupId = custSetup.Id
	CROSS APPLY (
		SELECT TOP 1
			AlertsEmail = COALESCE(specificSetup.AlertsEmail, custSetup.AlertsEmail),
			frequency = 
				CASE
					WHEN COALESCE(specificSetup.AlertsFrequencyType, custSetup.AlertsFrequencyType) = 1 THEN 24
					WHEN COALESCE(specificSetup.AlertsFrequencyType, custSetup.AlertsFrequencyType) = 2 THEN 72
				END
		FROM cc.Casting c
		LEFT JOIN cc.CastingSetup custSetup ON (custSetup.Id = cust.CastingSetupId AND custSetup.AlertsFrequencyType <> 0)
		LEFT JOIN cc.CastingSetup specificSetup ON (specificSetup.Id = c.CastingSetupId AND specificSetup.AlertsFrequencyType <> 0)
		WHERE c.Id = Casting.Id
		ORDER BY CASE WHEN specificSetup.Id IS NOT NULL THEN 0 ELSE 1 END
	) AS setup
	LEFT JOIN eit.EITNotification notif ON (notif.TargetId = cust.Id AND notif.NotificationType = 'CASTINGS_RECAP')
	LEFT JOIN eit.EITLogItem ON notif.EITLogItemId = EITLogItem.Id
	WHERE CastingCalled.[Status] in (4, 5, 6)
	AND (notif.Id IS NULL OR EITLogItem.RelatedObjectId <> Casting.Id OR DATEDIFF(HOUR, notif.CreatedAt, @date) >= setup.frequency)
	AND DATEDIFF(HOUR, CastingCalled.EITSvcStampUpdatedAt, @date) <= setup.frequency
	GROUP BY Casting.Id, Casting.Title, cust.Id, setup.AlertsEmail, setup.frequency;

END
GO
/****** Object:  StoredProcedure [cc].[GetCreditsStatus]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cc].[GetCreditsStatus]
	@customerId INT,
	@cultureId INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		CustomerId = cust.Id,
		CreditsBought,
		CreditsUsed
	FROM
		cc.CastingCafeCustomer cust
		CROSS APPLY (
			SELECT CreditsBought = ISNULL(SUM(
			CASE 
				WHEN Product.ProductType = 0 THEN lbought.NumberOfCredit * lbought.Quantity
				WHEN Product.ProductType = 1 THEN
					CASE
						WHEN Product.ReccurenceType = 0 THEN CONVERT(INT, lbought.NumberOfCredit / 7.0 * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil))
						WHEN Product.ReccurenceType = 1 THEN CONVERT(INT, lbought.NumberOfCredit / 30.4 * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil))
						WHEN Product.ReccurenceType = 2 THEN CONVERT(INT, lbought.NumberOfCredit / 365.0 * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil))
						WHEN Product.ReccurenceType = 3 THEN lbought.NumberOfCredit
						ELSE lbought.NumberOfCredit * DATEDIFF(DAY, lbought.ActiveOn, lbought.ValidUntil)
					END
			END), 0)
			FROM cc.[Order] obought
			LEFT JOIN cc.OrderLine lbought ON obought.Id = lbought.OrderId
										   AND lbought.ProductType IN (0, 1)
										   AND lbought.OrderLineStatus = 2
										   AND lbought.NumberOfCredit IS NOT NULL
										   --AND (lbought.ValidUntil iS NULL OR lbought.ValidUntil >= SYSDATETIME())
			LEFT JOIN cc.Product ON lbought.ProductId = Product.Id
			WHERE
				obought.CastingCafeCustomerId = cust.Id
				AND obought.OrderStatus = 2
				--AND Product.EITCultureId = @cultureId
		) AS CreditsBought
		CROSS APPLY (
			SELECT CreditsUsed = ISNULL(SUM(CONVERT(INT, lused.PriceUnit * lused.Quantity)), 0)
			FROM cc.[Order] oused
			LEFT JOIN cc.OrderLine lused ON oused.Id = lused.OrderId
										 AND lused.ProductType = 2
										 AND lused.OrderLineStatus = 2
			LEFT JOIN cc.Product ON lused.ProductId = Product.Id
			WHERE
				oused.CastingCafeCustomerId = cust.Id
				AND oused.OrderStatus = 2
				--AND Product.EITCultureId = @cultureId
		) AS CreditsUsed
	WHERE cust.Id = @customerId;
END

GO
/****** Object:  StoredProcedure [cc].[MatchingCastings]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [cc].[MatchingCastings]
	@customerId INT,
	@cultureId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ids TABLE(Id INT NOT NULL);

	INSERT INTO @ids
	EXEC cc.MatchingCastingsIds @customerId, @cultureId;

	SELECT
		CastingId = Casting.Id,
		[Url] = EITFriendlyURL.Link,
		Title = Casting.Title,
		TypeTitle = CastingTypeLocal.Title,
		[Description] = Casting.[Description],
		EndDateTime = Casting.EndDateTime,
		RoleId = Casting.CastingCafeRoleId,
		RoleTitle = CastingCafeRoleLocal.Title,
		PublicationMode = Casting.PublicationMode,
		[Status] = Casting.[Status],
		CityLabel = EITCity.Label,
		CountryName = EITCountryLocal.[Name],
		MediaType = Casting.MediaType,
		MediaValue = Casting.MediaValue,
		OwnerRoleType = ownerRole.RoleType,
		OwnerRoleTitle = ownerRoleLocal.Title,
		OwnerId = CastingCafeCustomer.Id
	FROM Casting
	JOIN cc.CastingTypeLocal ON Casting.CastingTypeId = CastingTypeLocal.CastingTypeId
	JOIN eit.EITFriendlyURL ON Casting.Id = EITFriendlyURL.ObjectId
	JOIN cc.CastingCafeRoleLocal ON Casting.CastingCafeRoleId = CastingCafeRoleLocal.CastingCafeRoleId
	JOIN eit.EITCity ON Casting.EITCityId = EITCity.Id
	JOIN eit.EITCountryLocal ON EITCity.EITCountryId = EITCountryLocal.EITCountryId
	JOIN cc.CastingCafeCustomer ON Casting.CastingCafeCustomerId = CastingCafeCustomer.Id
	JOIN cc.CastingCafeRole ownerRole ON ownerRole.Id = CastingCafeCustomer.CastingCafeRoleId
	JOIN cc.CastingCafeRoleLocal ownerRoleLocal ON ownerRoleLocal.CastingCafeRoleId = ownerRole.Id
	WHERE Casting.Id IN (SELECT Id FROM @ids)
	AND EITFriendlyURL.EITCultureId = @cultureId
	AND EITFriendlyURL.[Type] = 'CastingDetail'
	AND EITFriendlyURL.IsFavorite = 1
	AND CastingTypeLocal.EITCultureId = @cultureId
	AND CastingCafeRoleLocal.EITCultureId = @cultureId
	AND EITCountryLocal.EITCultureId = @cultureId
	AND ownerRoleLocal.EITCultureId = @cultureId
	OPTION (RECOMPILE);

	SELECT
		CustomerDisplayView.*
	FROM cc.CustomerDisplayView
	JOIN Casting ON Casting.CastingCafeCustomerId = CustomerDisplayView.Id
	WHERE Casting.Id IN (SELECT Id FROM @ids)
	AND CustomerDisplayView.UrlCultureId = @cultureId
	OPTION (RECOMPILE);

	SELECT
		CastingId = Casting.Id,
		AppliedCount = (
			SELECT COUNT(1)
			FROM cc.CastingCalled
			WHERE CastingCalled.CastingId = Casting.Id
			AND CastingCalled.[Status] IN (4, 6, 7) -- accepted, answered, confirmed
		),
		HasUserApplied = CAST(CASE WHEN EXISTS (
			SELECT CastingCalled.Id
			FROM cc.CastingCalled
			WHERE CastingCalled.CastingId = Casting.Id
			AND CastingCalled.CastingCafeCustomerId = @customerId
			AND CastingCalled.[Status] IN (4, 6, 7)
		) THEN 1 ELSE 0 END AS BIT)
	FROM cc.Casting
	WHERE Casting.Id IN (SELECT Id FROM @ids)
	OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [cc].[MatchingCastingsIds]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [cc].[MatchingCastingsIds]
	@customerId INT,
	@cultureId INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @now DATETIME2(7) = SYSDATETIME();

	SELECT Casting.Id
	FROM cc.Casting
	JOIN cc.CastingSearchHeader ON CastingSearchHeader.CastingId = Casting.Id
	JOIN eit.EITCity ON Casting.EITCityId = EITCity.Id
	JOIN cc.CastingCafeCustomer ON CastingCafeCustomer.Id = @customerId
	JOIN cc.CastingCafePerson ON CastingCafePerson.Id = CastingCafeCustomer.CastingCafePersonId
	JOIN eit.EITCity customerCity ON CastingCafeCustomer.EITCityId = customerCity.Id
	LEFT JOIN cc.CastingSearchIntCriterion ON CastingSearchIntCriterion.HeaderId = CastingSearchHeader.CastingId
	OUTER APPLY (
		SELECT ProfileItemValueInt.Id
		FROM cc.ProfileItemValueInt
		WHERE ProfileItemValueInt.CastingCafeCustomerId = CastingCafeCustomer.Id
		AND ProfileItemValueInt.ProfileItemId = CastingSearchIntCriterion.ProfileItemId
		AND ProfileItemValueInt.[Value] = CastingSearchIntCriterion.[Value]
	) AS IntCriteriaId
	LEFT JOIN cc.CastingSearchBooleanCriterion ON CastingSearchBooleanCriterion.HeaderId = CastingSearchHeader.CastingId
	OUTER APPLY (
		SELECT ProfileItemValueBoolean.Id
		FROM cc.ProfileItemValueBoolean
		WHERE ProfileItemValueBoolean.CastingCafeCustomerId = CastingCafeCustomer.Id
		AND ProfileItemValueBoolean.ProfileItemId = CastingSearchBooleanCriterion.ProfileItemId
		AND ProfileItemValueBoolean.[Value] = CastingSearchBooleanCriterion.[Value] 
	) AS BooleanCriteriaId
	LEFT JOIN cc.CastingCalled ON (
		CastingCalled.CastingId = Casting.Id
		AND CastingCalled.[Status] NOT IN (5, 8) -- declined, discarded
	)
	WHERE (Casting.CastingCafeRoleId = CastingCafeCustomer.CastingCafeRoleId)
	AND (CastingSearchHeader.Gender IS NULL OR CastingSearchHeader.Gender = CastingCafePerson.Gender)
	AND (CastingSearchHeader.AgeMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= CastingSearchHeader.AgeMin)
	AND (CastingSearchHeader.AgeMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= CastingSearchHeader.AgeMax)
	AND (EITCity.[Geography].STDistance(customerCity.[Geography]) <= CastingSearchHeader.ZoneKm * 1000)
	AND Casting.PublicationMode = 0 -- public
	AND Casting.[Status]  IN (3, 5) -- validated, published
	AND Casting.EndDateTime >= @now
	GROUP BY Casting.Id
	OPTION (RECOMPILE);

END
GO
/****** Object:  StoredProcedure [cc].[ScopedSearch]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cc].[ScopedSearch]
	@currentCultureId INT,
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@customerIds cc.idonly READONLY, -- idem
	@offset INT,
	@limit INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	CREATE TABLE #ids(id int not null); -- temp table because potentially lots of results
	
	INSERT INTO #ids
	EXEC cc.ScopedSearchIds @roleId, @cityId, @zone, @gender, @ageMin, @ageMax, @ints, @bits, @customerIds;

	CREATE NONCLUSTERED INDEX IX_Id ON #ids(id);

	DECLARE @pagedIds TABLE( -- table variable because never more than @limit (20-30) results
		Id INT NOT NULL PRIMARY KEY CLUSTERED,
		[Status] INT NOT NULL,
		Avatar VARCHAR(100) NULL,
		ProfessionalName VARCHAR(50) NULL,
		PersonId INT NULL,
		PersonGender INT NULL,
		PersonFirstName VARCHAR(50) NULL,
		PersonLastName VARCHAR(50) NULL,
		OrgId INT NULL,
		OrgName VARCHAR(50) NULL,
		OrgContactFirstName VARCHAR(50) NULL,
		OrgContactLastName VARCHAR(50) NULL,
		[Url] VARCHAR(255) NOT NULL,
		RoleType INT NOT NULL,
		RoleTitle VARCHAR(30) NULL,
		Rating INT NOT NULL,
		CityLabel VARCHAR(60) NULL,
		CountryName VARCHAR(30) NULL
	);
	INSERT INTO @pagedIds
	SELECT
		v.Id,
		c.CustomerStatus as [Status],
		v.Avatar,
		v.ProfessionalName,
		v.PersonId,
		v.PersonGender,
		v.PersonFirstName,
		v.PersonLastName,
		v.OrgId,
		v.OrgName,
		v.OrgContactFirstName,
		v.OrgContactLastName,
		v.[Url],
		r.RoleType,
		rl.Title AS RoleTitle,
		c.Rating,
		city.Label AS CityLabel,
		country.[Name] AS CountryName
	FROM cc.CustomerDisplayView v
	JOIN cc.CastingCafeCustomer c ON v.Id = c.Id
	JOIN cc.CastingCafeRole r ON c.CastingCafeRoleId = r.Id
	JOIN cc.CastingCafeRoleLocal rl ON r.Id = rl.CastingCafeRoleId
	LEFT JOIN eit.EITCity city on c.EITCityId = city.Id
	JOIN eit.EITCountryLocal country on c.EITCountryId = country.EITCountryId
	WHERE v.Id in (
		SELECT id FROM #ids
	)
	AND v.UrlCultureId = @currentCultureId
	AND rl.EITCultureId = @currentCultureId
	AND country.EITCultureId = @currentCultureId
	ORDER BY v.Id
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
	OPTION (RECOMPILE);

	SELECT
		Id,
		[Status],
		Avatar,
		ProfessionalName,
		PersonId,
		PersonGender,
		PersonFirstName,
		PersonLastName,
		OrgId,
		OrgName,
		OrgContactFirstName,
		OrgContactLastName,
		[Url],
		RoleType,
		RoleTitle,
		Rating,
		CityLabel,
		CountryName
	FROM @pagedIds;

	SELECT
		Book.CastingCafeCustomerId as CustomerId,
		BookItem.Id as BookItemId,
		Book.Id as BookId,
		Book.[Status] as BookStatus,
		BookItem.MediaType,
		BookItem.MediaValue,
		BookItem.DisplayOrder
	FROM cc.BookItem
	JOIN cc.Book ON BookItem.BookId = Book.Id
	WHERE Book.CastingCafeCustomerId IN (
		SELECT Id from @pagedIds
	)
	OPTION (RECOMPILE);

	RETURN (SELECT COUNT(1) FROM #ids);
END
GO
/****** Object:  StoredProcedure [cc].[ScopedSearchIds]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [cc].[ScopedSearchIds]
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@customerIds cc.idonly READONLY -- idem
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
	CROSS APPLY (
		SELECT i.id
		FROM @ints i
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
	) AS IntCriteriaId
	LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
	CROSS APPLY (
		SELECT b.id
		FROM @bits b
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
	) AS BooleanCriteriaId
	CROSS APPLY (
		SELECT c.id
		FROM @customerIds c
		WHERE c.id = cust.Id
	) AS CustomerCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	AND (cust.ValidUntil IS NULL OR cust.ValidUntil >= @now)
	GROUP BY cust.Id
	OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [cc].[ScopedSearchIdsV2]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cc].[ScopedSearchIdsV2]
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@customerIds cc.idonly READONLY -- idem
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	SELECT cust.Id
	FROM cc.CastingCafeCustomer cust
	LEFT JOIN eit.EITCity ON cust.EITCityId = EITCity.Id
	LEFT JOIN cc.CastingCafePerson ON cust.CastingCafePersonId = CastingCafePerson.Id
	LEFT JOIN cc.ProfileItemValueInt ON cust.Id = ProfileItemValueInt.CastingCafeCustomerId
	CROSS APPLY (
		SELECT i.id
		FROM @ints i
		WHERE i.id = -1 OR (i.id = ProfileItemValueInt.ProfileItemId AND i.val = ProfileItemValueInt.[Value])
	) AS IntCriteriaId
	LEFT JOIN cc.ProfileItemValueBoolean ON cust.Id = ProfileItemValueBoolean.CastingCafeCustomerId
	CROSS APPLY (
		SELECT b.id
		FROM @bits b
		WHERE b.id = -1 OR (b.id = ProfileItemValueBoolean.ProfileItemId AND ProfileItemValueBoolean.[Value] = 1)
	) AS BooleanCriteriaId
	CROSS APPLY (
		SELECT c.id
		FROM @customerIds c
		WHERE c.id = cust.Id
	) AS CustomerCriteriaId
	WHERE (@roleid IS NULL OR cust.CastingCafeRoleId = @roleId)
	AND (@gender IS NULL OR CastingCafePerson.Gender = @gender)
	AND (@ageMin IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) >= @ageMin)
	AND (@ageMax IS NULL OR DATEDIFF(YEAR, CastingCafePerson.Birthdate, @now) <= @ageMax)
	AND (@cityGeography IS NULL OR EITCity.[Geography].STDistance(@cityGeography) <= @zone)
	AND cust.CustomerStatus = 4
	GROUP BY cust.Id
	OPTION (RECOMPILE);
END
GO
/****** Object:  StoredProcedure [cc].[ScopedSearchV2]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cc].[ScopedSearchV2]
	@currentCultureId INT,
	@roleId INT = NULL,
	@cityId INT = NULL,
	@zone INT = 100000, -- 100 Km by default
	@gender INT = NULL,
	@ageMin INT = NULL,
	@ageMax INT = NULL,
	@ints cc.idvalueint READONLY, -- with at least one dummy row (id = -1) in it
	@bits cc.idonly READONLY, -- idem
	@customerIds cc.idonly READONLY, -- idem
	@offset INT,
	@limit INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @cityGeography GEOGRAPHY = (
		SELECT [geography]
		FROM eit.EITCity
		WHERE EITCity.Id = @cityId
	);
	DECLARE @now DATETIME2(7) = SYSDATETIME();

	CREATE TABLE #ids(id int not null); -- temp table because potentially lots of results
	
	INSERT INTO #ids
	EXEC cc.ScopedSearchIds @roleId, @cityId, @zone, @gender, @ageMin, @ageMax, @ints, @bits, @customerIds;

	CREATE NONCLUSTERED INDEX IX_Id ON #ids(id);

	DECLARE @pagedIds TABLE( -- table variable because never more than @limit (20-30) results
		Id INT NOT NULL,
		[Status] INT NOT NULL,
		Avatar VARCHAR(100) NULL,
		ProfessionalName VARCHAR(50) NULL,
		PersonId INT NULL,
		PersonGender INT NULL,
		PersonFirstName VARCHAR(50) NULL,
		PersonLastName VARCHAR(50) NULL,
		OrgId INT NULL,
		OrgName VARCHAR(50) NULL,
		OrgContactFirstName VARCHAR(50) NULL,
		OrgContactLastName VARCHAR(50) NULL,
		[Url] VARCHAR(255) NOT NULL,
		RoleType INT NOT NULL,
		RoleTitle VARCHAR(30) NULL,
		Rating INT NOT NULL,
		CityLabel VARCHAR(60) NULL,
		CountryName VARCHAR(30) NULL,
		ValidUntil DATETIME NULL
	);
	INSERT INTO @pagedIds
	SELECT
		v.Id,
		c.CustomerStatus as [Status],
		v.Avatar,
		v.ProfessionalName,
		v.PersonId,
		v.PersonGender,
		v.PersonFirstName,
		v.PersonLastName,
		v.OrgId,
		v.OrgName,
		v.OrgContactFirstName,
		v.OrgContactLastName,
		v.[Url],
		r.RoleType,
		rl.Title AS RoleTitle,
		c.Rating,
		city.Label AS CityLabel,
		country.[Name] AS CountryName,
		ValidUntil AS ValidUntil
	FROM cc.CustomerDisplayView v
	JOIN cc.CastingCafeCustomer c ON v.Id = c.Id
	JOIN cc.CastingCafeRole r ON c.CastingCafeRoleId = r.Id
	JOIN cc.CastingCafeRoleLocal rl ON r.Id = rl.CastingCafeRoleId
	LEFT JOIN eit.EITCity city on c.EITCityId = city.Id
	JOIN eit.EITCountryLocal country on c.EITCountryId = country.EITCountryId
	WHERE v.Id in (
		SELECT id FROM #ids
	)
	AND v.UrlCultureId = @currentCultureId
	AND rl.EITCultureId = @currentCultureId
	AND country.EITCultureId = @currentCultureId
	ORDER BY
		CASE
			WHEN c.ValidUntil IS NULL OR c.ValidUntil >= @now THEN 1
			ELSE 0
		END DESC,
		ISNULL(c.LastProfileModification, c.EITSvcStampCreatedAt) DESC,
		c.Rating DESC
	OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
	OPTION (RECOMPILE);

	SELECT
		Id,
		[Status],
		Avatar,
		ProfessionalName,
		PersonId,
		PersonGender,
		PersonFirstName,
		PersonLastName,
		OrgId,
		OrgName,
		OrgContactFirstName,
		OrgContactLastName,
		[Url],
		RoleType,
		RoleTitle,
		Rating,
		CityLabel,
		CountryName,
		ValidUntil
	FROM @pagedIds;

	RETURN (SELECT COUNT(1) FROM #ids);
END
GO
/****** Object:  StoredProcedure [cc].[USP_OrderCastingCafeCustomer]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Expert-IT
-- Create date: 2015-09-07
-- Description:	This method returns the list of customer passed in arguments ordered.
-- The order is calculated on :
--		* The Rating
--		* The Lst modification date of the profile
-- We convert the rating and the last profile modification date to a value between 0 and 100 
-- We multiply the value by a coefficient of importance for each criterias
-- =============================================
CREATE PROCEDURE [cc].[USP_OrderCastingCafeCustomer]
	@CustomerIds nvarchar(MAX)
AS


BEGIN
	SET NOCOUNT ON;

	SELECT 
		customer.Id,
		(
			((customer.Rating * 20) * 1)
			+
			((100 - DATEDIFF(DAY, customer.LastProfileModification, GETDATE())) * 1)
		) as DisplayOrder

	FROM cc.CastingCafeCustomer customer
	WHERE 
		customer.Id IN (SELECT Value FROM dbo.SplitList(@CustomerIds, '|'))
		
	ORDER BY DisplayOrder DESC

END
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerById]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetCustomerById]
(   
    @id int
   
)
AS
BEGIN
    
    SET NOCOUNT ON

select *
from customer c
left outer join Organization o on c.OrganizationId = o.Id
where c.id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  StoredProcedure [eit].[FindCityByLatitudeLongitudeRadius]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [eit].[FindCityByLatitudeLongitudeRadius]
	-- Add the parameters for the stored procedure here
	@Lat decimal(9,6) = 0,
	@Lon decimal(9,6) = 0,
	@Distance int = 0
AS
BEGIN
	
	DECLARE @point geography = geography::Point(@Lat, @Lon, 4326);

	SELECT city.Id,ROW_NUMBER() OVER (ORDER BY city.[Geography].STDistance(@point) DESC)  FROM eit.[EITCity] city WHERE city.[Geography].STDistance(@point) < @Distance ORDER BY city.[Geography].STDistance(@point)

END
GO
/****** Object:  StoredProcedure [eit].[FindCustomerFrontSearchByLatitudeLongitudeRadius]    Script Date: 31-05-21 15:25:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [eit].[FindCustomerFrontSearchByLatitudeLongitudeRadius]
	-- Add the parameters for the stored procedure here	
	@Lat decimal(9,6) = 0,
	@Lon decimal(9,6) = 0,
	@Distance int = 0	
AS
BEGIN
	
	DECLARE @point geography = geography::Point(@Lat, @Lon, 4326);
	
	SELECT  cust.Id 
	FROM cc.CustomerFrontSearch cust inner join eit.[EITCity] city on cust.EITCityId = city.Id WHERE city.[Geography].STDistance(@point) < @Distance ORDER BY city.[Geography].STDistance(@point)

END
GO
USE [master]
GO
ALTER DATABASE [kkmic-acc] SET  READ_WRITE 
GO
