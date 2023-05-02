---
name: "SQL 9 week averages"
about: The following SQL script allows you to create simple 9 week rolling average forecast.
labels: Forecasting

---

## Description
The code provided contains SQL queries that create temporary tables, loop through data and perform calculations on the data to update the temporary table.
Firstly, the code creates a temporary table named #tempsales using the SELECT...INTO statement, which selects all columns from the salesdata..RawData table.
Next, another temporary table named #temp is created using the SELECT DISTINCT statement which selects distinct product, warehouse, nationalaccount and sdate columns from the salesdata..RawData table.

The code provided contains SQL queries that create temporary tables, loop through data and perform calculations on the data to update the temporary table.

Firstly, the code creates a temporary table named #tempsales using the SELECT...INTO statement, which selects all columns from the salesdata..RawData table.
Next, another temporary table named #temp is created using the SELECT DISTINCT statement which selects distinct product, warehouse, nationalaccount and sdate columns from the salesdata..RawData table.
After the temporary tables are created, a cursor named comb_cursor is declared to loop through each distinct combination of product, warehouse, nationalaccount and sdate from the #temp table.
Then, the cursor is opened, and the first combination of data is fetched using the FETCH NEXT statement.
The WHILE loop is then used to iterate through the data until there are no more combinations of data to process. Inside the loop, the code calculates the 9 week averages for the current combination of data and updates the avgfcst column in the #tempsales table.
Finally, the cursor is closed, and the temporary table #tempsales is selected to display the updated data.
The last two statements are commented out, which would have been used to drop the temporary tables created.



### Basic example

The following is a sample of the raw data you can download above:
<img width="637" alt="image" src="https://user-images.githubusercontent.com/129782426/235568944-eb4ac877-4f2f-47a1-b291-b9f9369c50ee.png">
 
 The data is not organized so that's why creating a cursor is the best option, it grabs distinct product, warehouse, and nationalaccount and creates the forecast.
 
 I have hard coded the distinct values in order to show you the output:
 <img width="629" alt="image" src="https://user-images.githubusercontent.com/129782426/235569603-f70b3c3c-83a1-4655-977c-0ae3192962e3.png">

