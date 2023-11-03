


/**** Code for importing the shopping_trends table ****/

/** Option 1(Best Option) - Command Line **/
-- ".import --csv --shopping_trends.csv shopping_trends"


/** Option 2 - Reading in the file(uncomment and read in the file) **/
-- Set the mode to CSV
--.mode csv

-- Import the data
--.import shopping_trends.csv shopping_trends


/**** Tables to be created ****/

-- info on the customer
CREATE TABLE "customer_info"(
    "customer_id" INTEGER,
    "age" INTEGER,
    "gender" TEXT,
    "subscription" TEXT CHECK ("subscription" IN ("Yes", "No")) DEFAULT "No",
    "purchase_freq" TEXT CHECK("purchase_freq" IN ("Weekly", "Fortnightly", "Monthly", "Annually","Quarterly","Bi-Weekly","Every 3 Months")) DEFAULT "None",
    "most_preferred_payment" TEXT,
    PRIMARY KEY("customer_id")
);

-- customer's purchase history
CREATE TABLE "customer_history"(
    "customer_id" INTEGER,
    "previous_purchases" INTEGER,
    PRIMARY KEY("customer_id"),
    FOREIGN KEY("customer_id") REFERENCES "customer_info"("customer_id")

);

-- information on the item
CREATE TABLE "item_info"(
    "item_id" INTEGER,
    "item" TEXT,
    "category" TEXT,
    "size" TEXT,
    "color" TEXT,
    "location" TEXT,
    "cost_USD" REAL,
    PRIMARY KEY("item_id")
);

-- order information
CREATE TABLE "order_details"(
    "order_id" INTEGER,
    "customer_id" INTEGER,
    "item_id" INTEGER,
    "item" TEXT,
    "item_type" TEXT,
    "purchase_amount" REAL,
    "season_of_purchase" TEXT,
    "discount_applied" TEXT CHECK("discount_applied" IN ("Yes", "No")) DEFAULT "No",
    "promo_code" TEXT CHECK("promo_code" IN ("Yes", "No")) DEFAULT "No",
    "payment_method" TEXT,
    "shipping_type" TEXT,
    PRIMARY KEY("order_id"),
    FOREIGN KEY("item_id") REFERENCES "item_info"("item_id"),
    FOREIGN KEY("customer_id") REFERENCES "customer_info"("customer_id")

);

-- units sold and information on it
CREATE TABLE "units_sold"(
   "item_type_id" INTEGER,
   "item" TEXT UNIQUE,
   "category" TEXT,
   "number_of_item_sold" INTEGER DEFAULT 0,
   PRIMARY KEY("item_type_id")

);

/**** Triggers ****/

-- Trigger to be used for updating the units sold table, particularly the number of item sold
CREATE TRIGGER "units_sold_updates"
AFTER INSERT ON "units_sold"
FOR EACH ROW
BEGIN
    -- Updates number of items_sold each time the item pops up per row
    UPDATE "units_sold"
    SET "number_of_item_sold" = "number_of_item_sold" + 1
    WHERE "item_type_id" = NEW."item_type_id";
END;

/**** Table Insertions ****/

-- Insertions into each of the tables that were created
INSERT INTO "customer_info"("customer_id","age","gender","subscription","purchase_freq","most_preferred_payment")
SELECT "Customer ID", "Age","Gender","Subscription Status","Frequency of Purchases", "Preferred Payment Method"
FROM "shopping_trends";

INSERT INTO "customer_history"("customer_id","previous_purchases")
SELECT "Customer ID", "Previous Purchases"
FROM "shopping_trends";

INSERT INTO "item_info"("item","category","size","color","location","cost_USD")
SELECT "Item Purchased", "Size","Category", "Color", "Location", "Purchase Amount (USD)"
FROM "shopping_trends";

INSERT INTO "order_details"("customer_id","item","item_type","purchase_amount","season_of_purchase","discount_applied","promo_code","payment_method","shipping_type")
SELECT "Customer ID","Item Purchased","Category", "Purchase Amount (USD)", "Season", "Discount Applied", "Promo Code Used", "Payment Method", "Shipping Type"
FROM "shopping_trends";

INSERT INTO "units_sold"("item","category","number_of_item_sold")
SELECT "Item Purchased","Category", COUNT("Item Purchased")
FROM "shopping_trends"
GROUP BY "Item Purchased";


