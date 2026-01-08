/*
  Warnings:

  - You are about to drop the `Settings` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Settings";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "settings" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT DEFAULT 1,
    "initialCapital" REAL NOT NULL DEFAULT 0
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_trades" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "symbol" TEXT NOT NULL,
    "result" REAL NOT NULL,
    "strategy" TEXT NOT NULL,
    "direction" TEXT NOT NULL DEFAULT 'LONG',
    "riskPct" REAL,
    "rrRatio" REAL,
    "entryTime" DATETIME,
    "exitTime" DATETIME,
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tradeDayId" TEXT NOT NULL,
    CONSTRAINT "trades_tradeDayId_fkey" FOREIGN KEY ("tradeDayId") REFERENCES "trading_days" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_trades" ("direction", "entryTime", "exitTime", "id", "notes", "result", "riskPct", "rrRatio", "strategy", "symbol", "tradeDayId") SELECT "direction", "entryTime", "exitTime", "id", "notes", "result", "riskPct", "rrRatio", "strategy", "symbol", "tradeDayId" FROM "trades";
DROP TABLE "trades";
ALTER TABLE "new_trades" RENAME TO "trades";
CREATE TABLE "new_trading_days" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "resultadoDia" REAL NOT NULL DEFAULT 0,
    "mood" TEXT,
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_trading_days" ("date", "id", "mood", "notes", "resultadoDia") SELECT "date", "id", "mood", "notes", "resultadoDia" FROM "trading_days";
DROP TABLE "trading_days";
ALTER TABLE "new_trading_days" RENAME TO "trading_days";
CREATE UNIQUE INDEX "trading_days_date_key" ON "trading_days"("date");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
