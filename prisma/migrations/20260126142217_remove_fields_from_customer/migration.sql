/*
  Warnings:

  - You are about to drop the column `cpfCnpj` on the `Customer` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `Customer` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "cpfCnpj",
DROP COLUMN "type";

-- DropEnum
DROP TYPE "CustomerType";

-- CreateIndex
CREATE INDEX "Customer_phone_email_idx" ON "Customer"("phone", "email");
