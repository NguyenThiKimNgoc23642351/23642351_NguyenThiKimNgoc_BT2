USE [Movies]
GO
/****** Object:  UserDefinedDataType [dbo].[Category_num]    Script Date: 3/3/2025 12:35:24 PM ******/
CREATE TYPE [dbo].[Category_num] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Cust_num]    Script Date: 3/3/2025 12:35:24 PM ******/
CREATE TYPE [dbo].[Cust_num] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Invoice_num]    Script Date: 3/3/2025 12:35:24 PM ******/
CREATE TYPE [dbo].[Invoice_num] FROM [int] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Movie_num]    Script Date: 3/3/2025 12:35:24 PM ******/
CREATE TYPE [dbo].[Movie_num] FROM [int] NOT NULL
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/3/2025 12:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category](
	[Category_num] [dbo].[Category_num] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Category_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/3/2025 12:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[Cust_num] [dbo].[Cust_num] IDENTITY(300,1) NOT NULL,
	[Lname] [varchar](20) NOT NULL,
	[Fname] [varchar](20) NOT NULL,
	[Address1] [varchar](30) NULL,
	[Address2] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[State] [char](2) NULL,
	[Zip] [char](10) NULL,
	[Phone] [varchar](10) NOT NULL,
	[Join_date] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Cust_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 3/3/2025 12:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movie](
	[Movie_num] [dbo].[Movie_num] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Category_Num] [dbo].[Category_num] NOT NULL,
	[Date_purch] [smalldatetime] NULL,
	[Rental_price] [int] NULL,
	[Rating] [char](5) NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[Movie_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rental]    Script Date: 3/3/2025 12:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rental](
	[Invoice_num] [dbo].[Invoice_num] NOT NULL,
	[Cust_num] [dbo].[Cust_num] NOT NULL,
	[Rental_date] [smalldatetime] NOT NULL,
	[Due_date] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_Rental] PRIMARY KEY CLUSTERED 
(
	[Invoice_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rental_Detail]    Script Date: 3/3/2025 12:35:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rental_Detail](
	[Invoice_num] [dbo].[Invoice_num] NOT NULL,
	[Line_num] [int] NOT NULL,
	[Movie_num] [dbo].[Movie_num] NOT NULL,
	[Rental_price] [smallmoney] NOT NULL,
 CONSTRAINT [PK_Rental_Detail] PRIMARY KEY CLUSTERED 
(
	[Invoice_num] ASC,
	[Line_num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DK_customer_join_date]  DEFAULT (getdate()) FOR [Join_date]
GO
ALTER TABLE [dbo].[Movie] ADD  CONSTRAINT [DK_movie_date_purch]  DEFAULT (getdate()) FOR [Date_purch]
GO
ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DK_rental_rental_date]  DEFAULT (getdate()) FOR [Rental_date]
GO
ALTER TABLE [dbo].[Rental] ADD  CONSTRAINT [DK_rental_due_date]  DEFAULT (dateadd(day,(2),getdate())) FOR [Due_date]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_movie] FOREIGN KEY([Category_Num])
REFERENCES [dbo].[Category] ([Category_num])
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_movie]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_Movie_Category] FOREIGN KEY([Category_Num])
REFERENCES [dbo].[Category] ([Category_num])
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_Movie_Category]
GO
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_rental] FOREIGN KEY([Cust_num])
REFERENCES [dbo].[Customer] ([Cust_num])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_rental]
GO
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [FK_Rental_Customer] FOREIGN KEY([Cust_num])
REFERENCES [dbo].[Customer] ([Cust_num])
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [FK_Rental_Customer]
GO
ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [FK_detail_invoice] FOREIGN KEY([Invoice_num])
REFERENCES [dbo].[Rental] ([Invoice_num])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [FK_detail_invoice]
GO
ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [FK_detail_movie] FOREIGN KEY([Movie_num])
REFERENCES [dbo].[Movie] ([Movie_num])
GO
ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [FK_detail_movie]
GO
ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [FK_RentalDetail_Movie] FOREIGN KEY([Movie_num])
REFERENCES [dbo].[Movie] ([Movie_num])
GO
ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [FK_RentalDetail_Movie]
GO
ALTER TABLE [dbo].[Rental_Detail]  WITH CHECK ADD  CONSTRAINT [FK_RentalDetail_Rental] FOREIGN KEY([Invoice_num])
REFERENCES [dbo].[Rental] ([Invoice_num])
GO
ALTER TABLE [dbo].[Rental_Detail] CHECK CONSTRAINT [FK_RentalDetail_Rental]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [CK_movie] CHECK  (([Rating]='NR' OR [Rating]='NC17' OR [Rating]='R' OR [Rating]='PG' OR [Rating]='G'))
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [CK_movie]
GO
ALTER TABLE [dbo].[Rental]  WITH CHECK ADD  CONSTRAINT [CK_Due_date] CHECK  (([Due_date]>=[Rental_date]))
GO
ALTER TABLE [dbo].[Rental] CHECK CONSTRAINT [CK_Due_date]
GO
