--- name = bảng.column giống nghĩa  column as name 
---SupportRepID cũm là customer

---1:Provide a query showing Customers (just their full names, customer ID and country) who are not in the US
SELECT FullName = FirstName + ' '+ LastName , CustomerId, Country 
FROM dbo.Customer 
WHERE Country != 'USA';
--ALTER TABLE dbo.customer add FullName nvarchar(100) null
update
Customer
set fullname = FirstName + ' '+ LastName

---2: Provide a query only showing the Customers from Brazil.
SELECT *
FROM Customer 
WHERE Country = 'Brazil';

---3:Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT FullName ,InvoiceId, InvoiceDate, BillingCountry
FROM dbo.Invoice
INNER JOIN DBO.Customer
ON Customer.CustomerId = Invoice.CustomerId
where Country = 'Brazil';

---4: Provide a query showing only the Employees who are Sales Agents.
SELECT *
FROM dbo.Employee
WHERE Title = 'Sales Support Agent'
--ALTER TABLE dbo.Employee add FullName nvarchar(100) null
update
Employee
SET fullname = FirstName + ' '+ LastName;

---5: Provide a query showing a unique list of billing countries from the Invoice table.
SELECT DISTINCT BillingCountry FROM dbo.Invoice

---6: Provide a query showing the invoices of customers who are from Brazil
SELECT * FROM dbo.Invoice
WHERE BillingCountry = 'Brazil';

---7: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT [dbo].[Employee].[FullName], SUM([Total]) AS InSaleAgent
FROM [dbo].[Employee]
INNER JOIN [dbo].[Customer]
ON [dbo].[Employee].EmployeeId = [dbo].[Customer].SupportRepId
INNER JOIN [dbo].[Invoice]
ON [dbo].[Customer].CustomerId = [dbo].[Invoice].CustomerId
WHERE [Title] = 'Sales Support Agent'
GROUP BY [dbo].[Employee].[FullName]

---8: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
SELECT CusName = [dbo].[Customer].[FullName] ,[dbo].[Customer].Country ,[dbo].[Employee].FullName, sum(Total) AS InTotal
FROM Customer
INNER JOIN dbo.Invoice
ON Customer.CustomerId=Invoice.CustomerId
INNER JOIN [dbo].[Employee]
ON [dbo].[Customer].SupportRepId = [dbo].[Employee].EmployeeId
WHERE [Title] = 'Sales Support Agent'
GROUP BY [dbo].[Customer].[FullName],[dbo].[Customer].Country, [dbo].[Employee].FullName

---9:How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?

SELECT COUNT(*)
FROM DBO.Invoice
WHERE YEAR(InvoiceDate) BETWEEN 2009 AND 2011

SELECT YEAR(InvoiceDate) AS invYear, SUM(Total)
FROM DBO.Invoice 
WHERE YEAR(InvoiceDate) BETWEEN 2009 AND 2011
GROUP BY YEAR(InvoiceDate)

---10: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT COUNT(*)
FROM dbo.InvoiceLine
WHERE [InvoiceId] = 37

---11: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.

SELECT DISTINCT [InvoiceId]
FROM DBO.InvoiceLine

---12:Provide a query that includes the track name with each invoice line item.

SELECT [Name]
FROM [dbo].[Track]
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].[TrackId] =[dbo].[InvoiceLine].[TrackId]

---13: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT [dbo].[Track].[Name] AS Tra_Ari_Name
FROM [dbo].[Track]
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].[TrackId] = [dbo].[InvoiceLine].[TrackId]
INNER JOIN [dbo].[Album]
ON  [dbo].[Track].[AlbumId] = [dbo].[Album].[AlbumId]
INNER JOIN [dbo].[Artist]
ON [dbo].[Album].[ArtistId] = [dbo].[Artist].[ArtistId] 

---14: Provide a query that shows the # of invoices per country.

select [BillingCountry], sum([Total]) as Totalpercountry
FROM [dbo].[Invoice] 
group by [BillingCountry] 

---15: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.
---Cung cấp truy vấn hiển thị tổng số bản nhạc trong mỗi danh sách phát. Tên danh sách phát phải được bao gồm trên bảng kết quả.

SELECT [Name], sum([TrackId]) as TotalTrack
FROM[dbo].[Playlist]
INNER JOIN [dbo].[PlaylistTrack]
ON [dbo].[Playlist].[PlaylistId] = [dbo].[PlaylistTrack].[PlaylistId] 
GROUP BY [Name]


---16: Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.

SELECT [dbo].[Track].[Name], [dbo].[MediaType].[Name],[dbo].[Genre].[Name],[dbo].[Album].Title  
FROM [dbo].[Track]
INNER JOIN [dbo].[Album]
ON [dbo].[Track].[AlbumId] = [dbo].[Album].[AlbumId]
INNER JOIN [dbo].[MediaType]
ON [dbo].[Track].[MediaTypeId] = [dbo].[MediaType].[MediaTypeId]
INNER JOIN [dbo].[Genre]
ON [dbo].[Track].[GenreId] = [dbo].[Genre].[GenreId]

---17: Provide a query that shows all Invoices but includes the of invoice line items.

SELECT *
FROM [dbo].[Invoice]
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Invoice].InvoiceId = [dbo].[InvoiceLine].[InvoiceId]

---18: Provide a query that shows total sales made by each sales agent

SELECT [dbo].[Employee].[FullName] , SUM([Total]) AS TotalSale
FROM [dbo].[Employee]
INNER JOIN [dbo].[Customer]
ON [dbo].[Employee].[EmployeeId] = [dbo].[Customer].[SupportRepId]
INNER JOIN [dbo].[Invoice]
ON [dbo].[Customer].[CustomerId] = [dbo].[Invoice].[InvoiceId]
WHERE Title = 'Sales Support Agent'
GROUP BY [dbo].[Employee].[FullName]

---19: Which sales agent made the most in sales in 2009?

SELECT TOP 1 [dbo].[Employee].[FullName], SUM([Total])
FROM [dbo].[Invoice]
INNER JOIN [dbo].[Customer]
ON [dbo].[Invoice].[CustomerId] = [dbo].[Customer].[CustomerId]
INNER JOIN [dbo].[Employee]
ON [dbo].[Customer].SupportRepId = [dbo].[Employee].EmployeeId
WHERE YEAR([InvoiceDate]) =2009 AND Title = 'Sales Support Agent'
GROUP BY [dbo].[Employee].[FullName]

---20: Which sales agent made the most in sales in 2010?

SELECT TOP 1 [dbo].[Employee].[FullName], SUM([Total])
FROM [dbo].[Invoice]
INNER JOIN [dbo].[Customer]
ON [dbo].[Invoice].[CustomerId] = [dbo].[Customer].[CustomerId]
INNER JOIN [dbo].[Employee]
ON [dbo].[Customer].SupportRepId = [dbo].[Employee].EmployeeId
WHERE YEAR([InvoiceDate]) =2010 AND Title = 'Sales Support Agent'
GROUP BY [dbo].[Employee].[FullName]

---21: Which sales agent made the most in sales over all?

SELECT top 1 [dbo].[Employee].[FullName] AS MostSalesAgent, SUM([Total]) AS Sales
FROM [dbo].[Invoice]
INNER JOIN [dbo].[Customer]
ON [dbo].[Invoice].[CustomerId] = [dbo].[Customer].[CustomerId]
INNER JOIN [dbo].[Employee]
ON [dbo].[Customer].SupportRepId = [dbo].[Employee].EmployeeId
WHERE Title = 'Sales Support Agent'
GROUP BY [dbo].[Employee].[FullName]

---22: Provide a query that shows the of customers assigned to each sales agent.

SELECT[dbo].[Customer].FullName AS NameCus,[dbo].[Employee].[FullName] AS NameSales
FROM [dbo].[Invoice]
INNER JOIN [dbo].[Customer]
ON [dbo].[Invoice].[CustomerId] = [dbo].[Customer].[CustomerId]
INNER JOIN [dbo].[Employee]
ON [dbo].[Customer].SupportRepId = [dbo].[Employee].EmployeeId
WHERE Title = 'Sales Support Agent'
GROUP BY [dbo].[Customer].[FullName],[dbo].[Employee].[FullName]

---23: Provide a query that shows the total sales per country. Which country's customers spent the most?
---Cung cấp một truy vấn hiển thị tổng doanh số bán hàng trên mỗi quốc gia. Khách hàng của quốc gia nào đã chi tiêu nhiều nhất?

SELECT [Country], SUM([Total]) AS TotalSalePerCountry
FROM [dbo].[Invoice]
INNER JOIN [dbo].[Customer]
ON [dbo].[Invoice].[CustomerId] = [dbo].[Customer].[CustomerId]
group by [Country]
order by SUM([Total]) DESC 

SELECT TOP 1 [FullName], SUM([Total]) AS MostSpentCus
FROM [dbo].[Customer]
INNER JOIN [dbo].[Invoice]
ON [dbo].[Customer].[CustomerId]=[dbo].[Invoice].[CustomerId]
WHERE [Country] = 'USA'
GROUP BY FullName
ORDER BY sum([Total]) DESC 

---24:  Provide a query that shows the most purchased track of 2013.
SELECT top 1 [Name], SUM([Total]) AS MostPurTrack
FROM [dbo].[Track]
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].[TrackId]= [dbo].[InvoiceLine].[TrackId]
INNER JOIN [dbo].[Invoice]
ON [dbo].[InvoiceLine].InvoiceId = [dbo].[Invoice].InvoiceId
WHERE YEAR([InvoiceDate]) = 2013
GROUP BY [Name]
order by Sum([Total]) desc

---25:Provide a query that shows the top 5 most purchased tracks over all

SELECT TOP 5 [Name], SUM([Total]) AS MostPurTracks
FROM [dbo].[Track]
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].[TrackId]= [dbo].[InvoiceLine].[TrackId]
INNER JOIN [dbo].[Invoice]
ON [dbo].[InvoiceLine].InvoiceId = [dbo].[Invoice].InvoiceId
GROUP BY [Name]
order by Sum([Total]) desc

---26: Provide a query that shows the top 3 best selling artists.
SELECT TOP 3
[dbo].[Artist].[Name], sum([Total]) AS BestSellArt
FROM [dbo].[Artist]
INNER JOIN[dbo].[Album]
ON [dbo].[Artist].ArtistId = [dbo].[Album].ArtistId
INNER JOIN [dbo].[Track]
ON [dbo].[Album].AlbumId = [dbo].[Track].AlbumId
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].TrackId = [dbo].[InvoiceLine].TrackId
INNER JOIN [dbo].[Invoice]
ON [dbo].[InvoiceLine].InvoiceId = [dbo].[Invoice].InvoiceId
GROUP BY [dbo].[Artist].[Name]
order by Sum([Total]) desc

---27: Provide a query that shows the most purchased Media Type.
SELECT TOP 1 [dbo].[MediaType].Name AS MostPurMediaType
FROM[dbo].[MediaType]
INNER JOIN [dbo].[Track]
ON [dbo].[MediaType].MediaTypeId = [dbo].[Track].MediaTypeId
INNER JOIN [dbo].[InvoiceLine]
ON [dbo].[Track].TrackId = [dbo].[InvoiceLine].TrackId
INNER JOIN [dbo].[Invoice]
ON [dbo].[InvoiceLine].InvoiceId = [dbo].[Invoice].InvoiceId
GROUP BY [dbo].[MediaType].Name
order by Sum([Total]) desc

