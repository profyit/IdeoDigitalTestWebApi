USE [master]
GO
/****** Object:  Database [Accounting]    Script Date: 16-Jul-23 2:17:14 PM ******/
CREATE DATABASE [Accounting]
 CONTAINMENT = NONE

GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Accounting].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Accounting] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Accounting] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Accounting] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Accounting] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Accounting] SET ARITHABORT OFF 
GO
ALTER DATABASE [Accounting] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Accounting] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Accounting] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Accounting] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Accounting] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Accounting] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Accounting] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Accounting] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Accounting] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Accounting] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Accounting] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Accounting] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Accounting] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Accounting] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Accounting] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Accounting] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Accounting] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Accounting] SET RECOVERY FULL 
GO
ALTER DATABASE [Accounting] SET  MULTI_USER 
GO
ALTER DATABASE [Accounting] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Accounting] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Accounting] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Accounting] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Accounting] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Accounting] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Accounting', N'ON'
GO
ALTER DATABASE [Accounting] SET QUERY_STORE = OFF
GO
USE [Accounting]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceId] [uniqueidentifier] NOT NULL,
	[InvoiceName] [varchar](50) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Amount] [bigint] NOT NULL,
	[DeletedAt] [datetime] NULL,
	[InvoiceType] [int] NOT NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceType]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceType](
	[InvoiceTypeID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceTypeDesc] [varchar](50) NULL,
 CONSTRAINT [PK_InvoiceType] PRIMARY KEY CLUSTERED 
(
	[InvoiceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Invoices] ([InvoiceId], [InvoiceName], [CreatedAt], [Amount], [DeletedAt], [InvoiceType]) VALUES (N'c14bd47c-0b90-4327-918d-1ec1b195995e', N'Furniture', CAST(N'2023-07-14T14:49:12.513' AS DateTime), 102, NULL, 1)
INSERT [dbo].[Invoices] ([InvoiceId], [InvoiceName], [CreatedAt], [Amount], [DeletedAt], [InvoiceType]) VALUES (N'2805e1df-12de-4f24-a8bc-36f0a44be750', N'Cleaning Supplies', CAST(N'2023-07-14T14:49:55.627' AS DateTime), 452, NULL, 1)
INSERT [dbo].[Invoices] ([InvoiceId], [InvoiceName], [CreatedAt], [Amount], [DeletedAt], [InvoiceType]) VALUES (N'b16b10d6-e9d4-4120-aa95-7f80240cdfff', N'Office Supplies', CAST(N'2023-07-14T14:49:40.677' AS DateTime), 125, NULL, 1)
INSERT [dbo].[Invoices] ([InvoiceId], [InvoiceName], [CreatedAt], [Amount], [DeletedAt], [InvoiceType]) VALUES (N'343c22b7-2ef6-419c-b588-a743dcfbc9b7', N'FurnitureSupply', CAST(N'2023-07-15T22:44:52.500' AS DateTime), 105, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[InvoiceType] ON 

INSERT [dbo].[InvoiceType] ([InvoiceTypeID], [InvoiceTypeDesc]) VALUES (1, N'Open')
INSERT [dbo].[InvoiceType] ([InvoiceTypeID], [InvoiceTypeDesc]) VALUES (2, N'Closed')
SET IDENTITY_INSERT [dbo].[InvoiceType] OFF
GO
ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_invoiceId]  DEFAULT (newid()) FOR [InvoiceId]
GO
ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[Invoices] ADD  CONSTRAINT [DF_Invoices_InvoiceType]  DEFAULT ((1)) FOR [InvoiceType]
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD  CONSTRAINT [FK_Invoices_InvoiceType] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoices] ([InvoiceId])
GO
ALTER TABLE [dbo].[Invoices] CHECK CONSTRAINT [FK_Invoices_InvoiceType]
GO
/****** Object:  StoredProcedure [dbo].[AddInvoice]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


    
    
     
CREATE PROCEDURE [dbo].[AddInvoice]
	
	@InvoiceName varchar(50), 
	@Amount bigint,
	@InvoiceType int
AS
BEGIN

	INSERT INTO Invoices
	(InvoiceName, 
	Amount,
	InvoiceType)
	values 
	(
	@InvoiceName,
	@Amount,
	@InvoiceType
	)
	
END
GO
/****** Object:  StoredProcedure [dbo].[DeteleInvoiceByID]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[DeteleInvoiceByID]
	-- Add the parameters for the stored procedure here
	@InvoiceID uniqueidentifier 
AS
BEGIN

	SET NOCOUNT ON;
	UPDATE Invoices SET DeletedAt = GETDATE()
	WHERE InvoiceID = @InvoiceID AND
	DeletedAt is null
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllInvoices]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetAllInvoices]
	
	
AS
BEGIN

	SELECT [InvoiceId]
		  ,[InvoiceName]
		  ,[Amount]
		  ,[CreatedAt]
		  ,[InvoiceType]
		 , InvoiceType.[InvoiceTypeDesc]
	FROM Invoices JOIN
	InvoiceType ON InvoiceType.InvoiceTypeID = Invoices.InvoiceType
	Where Invoices.DeletedAt is null
END
-- exec GetAllInvoices
GO
/****** Object:  StoredProcedure [dbo].[GetInvoiceByID]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[GetInvoiceByID]
	-- Add the parameters for the stored procedure here
	@InvoiceID uniqueidentifier 
AS
BEGIN

	SET NOCOUNT ON;
	SELECT [InvoiceId]
		  ,[InvoiceName]
		  ,[Amount]
		  ,[CreatedAt]
		  ,[InvoiceType]
		 , InvoiceType.[InvoiceTypeDesc]
	FROM Invoices 
	JOIN InvoiceType ON InvoiceType.InvoiceTypeID = Invoices.InvoiceType
	Where DeletedAt is null
	AND [InvoiceId] = @InvoiceID 
END
GO
/****** Object:  StoredProcedure [dbo].[GetInvoicesWithPaging]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetInvoicesWithPaging]
	
	@page  int = 0, 
	@limit int =10
AS
BEGIN

	SELECT [InvoiceId]
		  ,[InvoiceName]
		  ,[Amount]
		  ,[CreatedAt]
		  ,[InvoiceType]
		 , InvoiceType.[InvoiceTypeDesc]
	FROM Invoices 
	JOIN InvoiceType ON InvoiceType.InvoiceTypeID = Invoices.InvoiceType
	Where DeletedAt is null
	ORDER BY CreatedAt 
	OFFSET @page ROWS
	FETCH NEXT @limit ROWS ONLY
	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvoice]    Script Date: 16-Jul-23 2:17:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateInvoice]
	@InvoiceID uniqueidentifier,
	@InvoiceName varchar(50), 
	@Amount int,
	@InvoiceType int
AS
BEGIN

	update Invoices  set 
	InvoiceName= @InvoiceName, 
	Amount =@Amount,
	InvoiceType=@InvoiceType
	where InvoiceId = @InvoiceID;
	
END
GO
USE [master]
GO
ALTER DATABASE [Accounting] SET  READ_WRITE 
GO
