/*
  Warnings:

  - You are about to drop the column `slug` on the `organization` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[cnpj]` on the table `organization` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "organization_slug_idx";

-- DropIndex
DROP INDEX "organization_slug_key";

-- AlterTable
ALTER TABLE "organization" DROP COLUMN "slug",
ADD COLUMN     "cnpj" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "organization_cnpj_key" ON "organization"("cnpj");

-- CreateIndex
CREATE INDEX "organization_cnpj_idx" ON "organization"("cnpj");
