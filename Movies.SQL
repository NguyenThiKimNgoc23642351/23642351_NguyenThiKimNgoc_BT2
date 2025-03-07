--- Phần 3---
USE [master]
GO
/****** Object:  Database [Movies]    Script Date: 3/3/2025 9:48:35 AM ******/
CREATE DATABASE [Movies]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Movies_data', FILENAME = N'D:\CSDL\MOVIES\Movies_data.mdf' , SIZE = 25600KB , MAXSIZE = 40960KB , FILEGROWTH = 1024KB ), 
( NAME = N'Movies_data2', FILENAME = N'D:\CSDL\MOVIES\Movies_data2.ndf' , SIZE = 10240KB , MAXSIZE = 20480KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Movies_log', FILENAME = N'D:\CSDL\MOVIES\Movies_log.ldf' , SIZE = 6144KB , MAXSIZE = 8192KB , FILEGROWTH = 1024KB )
GO
ALTER DATABASE [Movies] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Movies] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Movies] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Movies] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Movies] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Movies] SET ARITHABORT OFF 
GO
ALTER DATABASE [Movies] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Movies] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Movies] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Movies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Movies] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Movies] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Movies] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Movies] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Movies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Movies] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Movies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Movies] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Movies] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Movies] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Movies] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Movies] SET  MULTI_USER 
GO
ALTER DATABASE [Movies] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Movies] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Movies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Movies] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Movies] SET  READ_WRITE 
GO

ALTER DATABASE Movies ADD FILEGROUP Data;
GO


ALTER DATABASE Movies MODIFY FILE 
(
    NAME = Movies_log, 
    MAXSIZE = 10MB
);
GO

ALTER DATABASE Movies 
ADD FILE 
(
    NAME = Movies_Data2,
    FILENAME = 'D:\CSDL\Movies_Data2.ndf',
    SIZE = 10MB
) 
TO FILEGROUP Data;
GO


EXEC sp_helpdb Movies;
GO
-- PHẦN 5: TẠO CÁC USER-DEFINED DATA TYPES
CREATE TYPE Movie_num FROM INT NOT NULL;
CREATE TYPE Category_num FROM INT NOT NULL;
CREATE TYPE Cust_num FROM INT NOT NULL;
CREATE TYPE Invoice_num FROM INT NOT NULL;
GO

-- PHẦN 6: TẠO CÁC BẢNG
-- Tạo bảng Customer
-- Tạo bảng Customer
CREATE TABLE Customer (
    Cust_num cust_num IDENTITY(300,1) NOT NULL,
    Lname varchar(20) NOT NULL,
    Fname varchar(20) NOT NULL,
    Address1 varchar(30) NULL,
    Address2 varchar(20) NULL,
    City varchar(20) NULL,
    State Char(2) NULL,
    Zip Char(10) NULL,
    Phone Varchar(10) NOT NULL,
    Join_date Smalldatetime NOT NULL,
    CONSTRAINT PK_Customer PRIMARY KEY (Cust_num)
);

-- Tạo bảng Category
CREATE TABLE Category (
    Category_num category_num IDENTITY(1,1) NOT NULL,
    Description Varchar(20) NOT NULL,
    CONSTRAINT PK_Category PRIMARY KEY (Category_num)
);

-- Tạo bảng Movie
CREATE TABLE Movie (
    Movie_num Movie_num NOT NULL,
    Title varchar(50) NOT NULL,
    Category_Num category_num NOT NULL,
    Date_purch Smalldatetime NULL,
    Rental_price Int NULL,
    Rating Char(5) NULL,
    CONSTRAINT PK_Movie PRIMARY KEY (Movie_num),
    CONSTRAINT FK_Movie_Category FOREIGN KEY (Category_Num) REFERENCES Category (Category_num)
);

-- Tạo bảng Rental
CREATE TABLE Rental (
    Invoice_num Invoice_num NOT NULL,
    Cust_num Cust_num NOT NULL,
    Rental_date Smalldatetime NOT NULL,
    Due_date Smalldatetime NOT NULL,
    CONSTRAINT PK_Rental PRIMARY KEY (Invoice_num),
    CONSTRAINT FK_Rental_Customer FOREIGN KEY (Cust_num) REFERENCES Customer (Cust_num)
);

-- Tạo bảng Rental_Detail
CREATE TABLE Rental_Detail (
    Invoice_num Invoice_num NOT NULL,
    Line_num Int NOT NULL,
    Movie_num Movie_num NOT NULL,
    Rental_price Smallmoney NOT NULL,
    CONSTRAINT PK_Rental_Detail PRIMARY KEY (Invoice_num, Line_num),
    CONSTRAINT FK_RentalDetail_Rental FOREIGN KEY (Invoice_num) REFERENCES Rental (Invoice_num),
    CONSTRAINT FK_RentalDetail_Movie FOREIGN KEY (Movie_num) REFERENCES Movie (Movie_num)
);

-- Kiểm tra cấu trúc bảng Customer sau khi tạo
EXEC sp_help 'Customer';

-- Kiểm tra cấu trúc bảng Category sau khi tạo
EXEC sp_help 'Category';

-- Kiểm tra cấu trúc bảng Movie sau khi tạo
EXEC sp_help 'Movie';

-- Kiểm tra cấu trúc bảng Rental sau khi tạo
EXEC sp_help 'Rental';

-- Kiểm tra cấu trúc bảng Rental_Detail sau khi tạo
EXEC sp_help 'Rental_Detail';

--- Phần 9 ---
EXEC sp_helpconstraint 'Movie';
EXEC sp_helpconstraint 'Customer';
EXEC sp_helpconstraint 'Category';
EXEC sp_helpconstraint 'Rental';
--- Phần 10 ----
-- Movie: Category_num tham chiếu Category(Category_num)
ALTER TABLE Movie 
ADD CONSTRAINT FK_movie FOREIGN KEY (Category_num) 
REFERENCES Category(Category_num);

-- Rental: Cust_num tham chiếu Customer(Cust_num)
ALTER TABLE Rental 
ADD CONSTRAINT FK_rental FOREIGN KEY (Cust_num) 
REFERENCES Customer(Cust_num);

-- Rental_detail: Invoice_num tham chiếu Rental(Invoice_num) (xóa dữ liệu khi Rental bị xóa)
ALTER TABLE Rental_detail 
ADD CONSTRAINT FK_detail_invoice FOREIGN KEY (Invoice_num) 
REFERENCES Rental(Invoice_num) ON DELETE CASCADE;

-- Rental_detail: Movie_num tham chiếu Movie(Movie_num)
ALTER TABLE Rental_detail 
ADD CONSTRAINT FK_detail_movie FOREIGN KEY (Movie_num) 
REFERENCES Movie(Movie_num);

EXEC sp_helpconstraint 'Customer';
EXEC sp_helpconstraint 'Movie';
EXEC sp_helpconstraint 'Rental';
EXEC sp_helpconstraint 'Rental_detail';
--- Phần 12---
-- Movie: Date_purch mặc định là ngày hiện tại
ALTER TABLE Movie 
ADD CONSTRAINT DK_movie_date_purch DEFAULT GETDATE() FOR Date_purch;

-- Customer: join_date mặc định là ngày hiện tại
ALTER TABLE Customer 
ADD CONSTRAINT DK_customer_join_date DEFAULT GETDATE() FOR join_date;

-- Rental: Rental_date mặc định là ngày hiện tại
ALTER TABLE Rental 
ADD CONSTRAINT DK_rental_rental_date DEFAULT GETDATE() FOR Rental_date;

-- Rental: Due_date mặc định là ngày hiện tại + 2 ngày
ALTER TABLE Rental 
ADD CONSTRAINT DK_rental_due_date DEFAULT DATEADD(DAY, 2, GETDATE()) FOR Due_date;

EXEC sp_helpconstraint 'Movie';
EXEC sp_helpconstraint 'Customer';
EXEC sp_helpconstraint 'Rental';
--- Phần 13---
-- Movie: Rating chỉ được nhận các giá trị ‘G’, ‘PG’, ‘R’, ‘NC17’, ‘NR’
ALTER TABLE Movie 
ADD CONSTRAINT CK_movie 
CHECK (Rating IN ('G', 'PG', 'R', 'NC17', 'NR'));

-- Rental: Due_date phải lớn hơn hoặc bằng Rental_date
ALTER TABLE Rental 
ADD CONSTRAINT CK_Due_date 
CHECK (Due_date >= Rental_date);

EXEC sp_helpconstraint 'Movie';
EXEC sp_helpconstraint 'Rental';
