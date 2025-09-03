PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS retail;
CREATE TABLE retail (
  InvoiceNo   TEXT,
  StockCode   TEXT,
  Description TEXT,
  Quantity    INTEGER,
  InvoiceDate TEXT,  -- ISO8601 text for SQLite
  UnitPrice   REAL,
  CustomerID  TEXT,
  Country     TEXT
);

-- Convenience view: exclude bad rows & credit notes
DROP VIEW IF EXISTS sales_clean;
CREATE VIEW sales_clean AS
SELECT
  InvoiceNo,
  StockCode,
  Description,
  Quantity,
  InvoiceDate,
  UnitPrice,
  CustomerID,
  Country,
  (Quantity * UnitPrice) AS LineRevenue
FROM retail
WHERE UnitPrice > 0
  AND Quantity > 0
  AND (InvoiceNo IS NOT NULL AND InvoiceNo NOT LIKE 'C%');

DROP TABLE best_selling_switch_games;
