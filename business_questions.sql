/**** Question 1 ****/
-- From all Accessories purchased by subscribed customers, identify how many orders for each specific accessory had a promo code or had a discount applied to it.
-- Also show the total revenue generated from those orders and order by highest to lowest total revenue
-- Make a view of this information to conduct analysis on for the future
CREATE VIEW "subscriber_item_revenue" AS
SELECT b."item",COUNT(b."order_id") AS "count_of_orders", SUM(b."purchase_amount") AS "total_revenue"
FROM
    "customer_info" a JOIN "order_details" b
    ON a.customer_id = b.customer_id
WHERE (b."promo_code" = "Yes" OR b."discount_applied" = "Yes") AND a."subscription" = "Yes"
GROUP BY b."item"
ORDER BY "total_revenue" desc, "count_of_orders" desc;

--For looking at the view created above(uncomment below or paste in terminal or command line)
--SELECT * FROM "subscriber_item_revenue";


/**** Question 2 ****/
-- what are the top 10 most sold items among men?
-- Also display the total revenue produced from them?
-- Is there consistently a positive correlation between count of orders and total revenue for the top 10 items purchased among Men?
SELECT b."item", COUNT(b."order_id") AS "count_of_orders", SUM(b."purchase_amount") AS "total_revenue"
FROM
    "customer_info" a JOIN "order_details" b
    ON a."customer_id" = b."customer_id"
WHERE a."gender" = "Male"
GROUP BY b."item"
ORDER BY "count_of_orders" desc, "total_revenue" desc
LIMIT 10;
-- Answer: There is a weak positive relationship. r squared value of .38 as calculated through Analysis with Microsoft Excel


/**** Question 3 ****/
--Show how many orders are made by young adults(ages 18-25) during each season.
--Also show what the average amount spent per order is for the young adults in each season.
--finally show the most used payment method used by young adults during the seasons for the orders they made
--Create another query to see if the most used payment method in each season matches with the most used payment method overall

--CTE
WITH "most_used_payment" AS (
    SELECT "season_of_purchase","payment_method", COUNT("payment_method") AS "count_of_payments"
    FROM "order_details" a JOIN "customer_info" b
        ON a."customer_id" = b."customer_id"
    WHERE b."age" BETWEEN 18 AND 25
    GROUP BY "season_of_purchase", "payment_method"
    ORDER BY "count_of_payments" desc
    )



SELECT DISTINCT "season_of_purchase", MAX("count_of_payments") AS "young_adults_most_used_payment_method","payment_method"
FROM "most_used_payment"
GROUP BY "season_of_purchase";


SELECT "payment_method", COUNT("payment_method") AS "most_used_payment_method_overall"
FROM "order_details"
GROUP BY "payment_method"
ORDER BY "most_used_payment_method_overall" desc
LIMIT 1;





