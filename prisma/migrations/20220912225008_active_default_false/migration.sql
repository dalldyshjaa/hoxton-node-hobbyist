-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Hoby" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "photoUrl" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Hoby_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Hoby" ("active", "id", "name", "photoUrl", "userId") SELECT "active", "id", "name", "photoUrl", "userId" FROM "Hoby";
DROP TABLE "Hoby";
ALTER TABLE "new_Hoby" RENAME TO "Hoby";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
