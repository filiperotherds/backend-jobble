/*
  Warnings:

  - A unique constraint covering the columns `[organizationId,estimate_no]` on the table `estimate` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `estimate_no` to the `estimate` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "estimate" ADD COLUMN     "estimate_no" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "estimate_organizationId_estimate_no_key" ON "estimate"("organizationId", "estimate_no");
