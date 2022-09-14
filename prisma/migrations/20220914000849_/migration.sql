/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `Hoby` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Hoby_name_key" ON "Hoby"("name");
