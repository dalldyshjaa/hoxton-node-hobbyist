/*
  Warnings:

  - You are about to drop the column `userId` on the `Hoby` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "_HobyToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_HobyToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Hoby" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_HobyToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Hoby" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "photoUrl" TEXT NOT NULL
);
INSERT INTO "new_Hoby" ("active", "id", "name", "photoUrl") SELECT "active", "id", "name", "photoUrl" FROM "Hoby";
DROP TABLE "Hoby";
ALTER TABLE "new_Hoby" RENAME TO "Hoby";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_HobyToUser_AB_unique" ON "_HobyToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_HobyToUser_B_index" ON "_HobyToUser"("B");
