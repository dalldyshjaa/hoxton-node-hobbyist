-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Hoby" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "photoUrl" TEXT
);
INSERT INTO "new_Hoby" ("active", "id", "name", "photoUrl") SELECT "active", "id", "name", "photoUrl" FROM "Hoby";
DROP TABLE "Hoby";
ALTER TABLE "new_Hoby" RENAME TO "Hoby";
CREATE UNIQUE INDEX "Hoby_name_key" ON "Hoby"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
