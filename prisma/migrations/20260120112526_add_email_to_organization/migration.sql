/*
  Warnings:

  - A unique constraint covering the columns `[email]` on the table `organization` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "organization" ADD COLUMN     "email" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "organization_email_key" ON "organization"("email");
