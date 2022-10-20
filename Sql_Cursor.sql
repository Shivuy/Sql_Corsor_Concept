-- requirement
-- Depending omn how many products belong to a product category
-- Display a message that aProductCategory is Trending 
--							/ No Products in productCategory
		--					/ Normal Purchases for ProductCategory

Declare @ProductCount INT
Declare @Category nVarchar(50)
Declare cur_TrendingCategories Cursor FOR
Select Count(Product.[Name]) as [ProductCount],ProductCategory.[Name]
From Product Right outer join ProductCategory
on Product.CategoryId= ProductCategory.Id
Group by ProductCategory.[Name]

open cur_TrendingCategories
Fetch Next from cur_TrendingCategories
Into @ProductCount, @Category

-- Logic
WHILE @@FETCH_STATUS=0
BEGIN
	If @ProductCount > 3
		Print @CAtegory + ' is trending ';
	Else If @ProductCount > 0 and @ProductCount <=3
		print @Category + 'has normal purchases'
	Else
		Print @Category + 'Has no new Products'

Fetch Next from cur_TrendingCategories Into @ProductCount, @Category
END

-- End of row by row processing

 close cur_TrendingCategories
 DeAllocate cur_TrendingCategories
	