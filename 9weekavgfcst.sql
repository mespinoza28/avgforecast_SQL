select*
into #tempsales
from salesdata..RawData



-- Create temporary table with distinct Product, Warehouse, Nationalaccount combinations 
SELECT DISTINCT product, warehouse, nationalaccount,sdate
into #temp
FROM salesdata..RawData

-- Loop through each distinct combination and calculate 9 week averages
DECLARE @product varchar(50), @warehouse varchar(50), @nationalaccount varchar(50), @sdate date
DECLARE comb_cursor CURSOR FOR 
    SELECT Product, Warehouse, Nationalaccount,sdate
    FROM #temp;

OPEN comb_cursor;

FETCH NEXT FROM comb_cursor INTO @product, @warehouse, @nationalaccount, @sdate;

--select @product,@warehouse,@nationalaccount,@sdate


WHILE @@FETCH_STATUS = 0
BEGIN
    -- Calculate 9 week averages for current combination
    UPDATE #tempsales
    SET avgfcst = (
        SELECT sum(Cases) / 9 
        FROM #tempsales
        WHERE 
		Product = @product 
        AND Warehouse = @warehouse 
        AND Nationalaccount = @nationalaccount 
        AND sdate between  dateadd(ww,-9,@sdate) and @sdate
    )
    WHERE Product = @product 
        AND Warehouse = @warehouse 
        AND Nationalaccount = @nationalaccount
        and sdate > dateadd(ww,+8,(select min(sdate) from #tempsales))
		and sdate = @sdate;
    
    FETCH NEXT FROM comb_cursor INTO @product, @warehouse, @nationalaccount,@sdate;
END

CLOSE comb_cursor;
DEALLOCATE comb_cursor;

select*
from #tempsales



--drop table #temp

--drop table #tempsales 
