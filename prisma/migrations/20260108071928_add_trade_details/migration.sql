-- CreateTable
CREATE TABLE "trading_days" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "resultadoDia" REAL NOT NULL DEFAULT 0,
    "mood" TEXT,
    "notes" TEXT
);

-- CreateTable
CREATE TABLE "trades" (
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
    "tradeDayId" TEXT NOT NULL,
    CONSTRAINT "trades_tradeDayId_fkey" FOREIGN KEY ("tradeDayId") REFERENCES "trading_days" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "trading_days_date_key" ON "trading_days"("date");
